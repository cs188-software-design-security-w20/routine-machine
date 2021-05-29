import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:steel_crypt/steel_crypt.dart' as Steel;
import 'package:crypton/crypton.dart' as Crypton;

class AESKey {
  String key;
  String iv;
  AESKey({this.key, this.iv});

  EncryptedDEK encrypt({String usingPublicKey}) {
    final pk = Crypton.RSAPublicKey.fromString(usingPublicKey);
    final encryptedKey = pk.encrypt(key);
    return EncryptedDEK(encrypted: encryptedKey, iv: iv);
  }
}

class EncryptedDEK {
  String encrypted;
  String iv;
  EncryptedDEK({this.encrypted, this.iv});

  @override
  toString() => '$encrypted\$$iv';

  EncryptedDEK.fromString(String input) {
    final tokens = input.split('\$');
    this.encrypted = tokens[0];
    this.iv = tokens[1];
  }

  AESKey decrypt({String usingPrivateKey}) {
    final pk = Crypton.RSAPrivateKey.fromString(usingPrivateKey);
    final decryptedKey = pk.decrypt(encrypted);
    return AESKey(key: decryptedKey, iv: iv);
  }
}

class MissingKeyException implements Exception {
  final String msg;
  const MissingKeyException(this.msg);
  @override
  String toString() => 'MissingKeyException: $msg';
}

/// Utility class for management of keys and encryption/decryption of data
class CSE {
  var _storage = const FlutterSecureStorage();
  String privateKeyStorageKey; // = 'routine-machine-private-key';
  String publicKeyStorageKey; //= 'routine-machine-public-key';
  String dekStorageKey;
  String ivStorageKey; // = 'routine-machine-iv';
  static final CSE _instance = CSE._create();
  factory CSE() => _instance;
  CSE._create();

  /// Inject a key-value storage system using the FlutterSecureStorage interface
  injectStorageProvider({FlutterSecureStorage provider}) {
    _storage = provider;
  }

  void setUID(String uid) {
    this.privateKeyStorageKey = 'private-key-$uid';
    this.publicKeyStorageKey = 'public-key-$uid';
    this.dekStorageKey = 'dek-$uid';
    this.ivStorageKey = 'iv-$uid';
  }

  /// Changes the DEK and IV of the client for AES-CBC-256
  /// If the key does not exist, this is used to initialize the key
  Future<void> refreshOwnerDEK() async {
    if (dekStorageKey == null) {
      throw Exception(
          'No UID set for key storage. Be sure to use "setUID" before other methods');
    }
    final aesKey = await _generateDEK();
    await _storage.write(key: dekStorageKey, value: aesKey.key);
    await _storage.write(key: ivStorageKey, value: aesKey.iv);
  }

  /// Changes the PK Pair of the client for RSA-4096
  /// If the key does not exist, this is used to initialize the key
  Future<void> refreshOwnerPKPair() async {
    if (privateKeyStorageKey == null) {
      throw Exception(
          'No UID set for key storage. Be sure to use "setUID" before other methods');
    }
    final keyPair = await _generateKeyPair();
    final publicKeyStr = keyPair.publicKey.toString();
    final privateKeyStr = keyPair.privateKey.toString();
    await _storage.write(key: publicKeyStorageKey, value: publicKeyStr);
    await _storage.write(key: privateKeyStorageKey, value: privateKeyStr);
  }

  /// Overrides the Private Key in storage
  /// If creating a new user, use "refreshOwnerPKPair" instead
  Future<void> setPrivateKey({String key}) async {
    await _storage.write(key: privateKeyStorageKey, value: key);
  }

  /// Overrides the Public Key in storage
  /// If creating a new user, use "refreshOwnerPKPair" instead
  Future<void> setPublicKey({String key}) async {
    await _storage.write(key: publicKeyStorageKey, value: key);
  }

  /// Get the DEK corresponding to the client
  Future<AESKey> getDEK() async {
    final dek = await _storage.read(key: dekStorageKey);
    final iv = await _storage.read(key: ivStorageKey);
    if (dek == null || iv == null)
      throw MissingKeyException('DEK not initialized');
    return AESKey(key: dek, iv: iv);
  }

  /// Get the Private Key corresponding to the client
  Future<Crypton.RSAPrivateKey> getPrivateKey() async {
    final privateKeyStr = await _storage.read(key: privateKeyStorageKey);
    if (privateKeyStr == null)
      throw MissingKeyException('Private Key not initialized');
    return Crypton.RSAPrivateKey.fromString(privateKeyStr);
  }

  /// Get the Public Key corresponding to the client
  Future<Crypton.RSAPublicKey> getPublicKey() async {
    final publicKeyStr = await _storage.read(key: publicKeyStorageKey);
    if (publicKeyStr == null)
      throw MissingKeyException('Public Key not initialized');
    return Crypton.RSAPublicKey.fromString(publicKeyStr);
  }

  /// Whether the DEK is initialized for the client
  Future<bool> hasDEK() async {
    final hasDEKKey = await _storage.containsKey(key: dekStorageKey);
    final hasIVKey = await _storage.containsKey(key: ivStorageKey);
    return hasDEKKey && hasIVKey;
  }

  /// Whether the PK Pair is initialized for the client
  Future<bool> hasKeyPair() async {
    final hasPrivateKey = await _storage.containsKey(key: privateKeyStorageKey);
    final hasPublicKey = await _storage.containsKey(key: publicKeyStorageKey);
    return hasPrivateKey && hasPublicKey;
  }

  /// Encrypt outgoing data using the client's DEK
  Future<String> encryptText({String text}) async {
    final ownerAESKey = await getDEK();
    final key = ownerAESKey.key;
    final iv = ownerAESKey.iv;
    final aes = Steel.AesCrypt(key: key, padding: Steel.PaddingAES.pkcs7);
    final encrypted = aes.cbc.encrypt(inp: text, iv: iv);
    return encrypted;
  }

  /// Decrypt incoming data using own key or a follower's key
  Future<String> decryptText({String text, AESKey usingKey}) async {
    final aesKey = await (() {
      if (usingKey != null) return Future(() => usingKey);
      return getDEK();
    })();
    final key = aesKey.key;
    final iv = aesKey.iv;
    final aes = Steel.AesCrypt(key: key, padding: Steel.PaddingAES.pkcs7);
    final decrypted = aes.cbc.decrypt(enc: text, iv: iv);
    return decrypted;
  }

  /// Used to encrypt the owner's DEK using a follower's public key
  /// before distribution to that follower
  Future<EncryptedDEK> encryptOwnerDEK({String usingPublicKey}) async {
    final publicKey = await (() async {
      if (usingPublicKey == null) return await this.getPublicKey();
      return Crypton.RSAPublicKey.fromString(usingPublicKey);
    })();
    final ownerDEK = await getDEK();
    final encryptedKey = publicKey.encrypt(ownerDEK.key);
    return EncryptedDEK(encrypted: encryptedKey, iv: ownerDEK.iv);
  }

  /// Used to decrypt a followee's DEK that has been encrypted
  /// using the owner's public key and distributed to the owner
  Future<AESKey> decryptOtherDEK({EncryptedDEK encryptedDEK}) async {
    final privateKey = await getPrivateKey();
    return encryptedDEK.decrypt(usingPrivateKey: privateKey.toString());
  }

  Future<String> decryptChallengeString({String encrypted}) async {
    final privateKey = await getPrivateKey();
    return privateKey.decrypt(encrypted);
  }

  Future<AESKey> _generateDEK() async {
    final cryptKey = Steel.CryptKey();
    final dek = cryptKey.genFortuna(len: 32);
    final iv = cryptKey.genDart(len: 16);
    return AESKey(key: dek, iv: iv);
  }

  Future<Crypton.RSAKeypair> _generateKeyPair() async {
    return Crypton.RSAKeypair.fromRandom(keySize: 1024);
  }
}
