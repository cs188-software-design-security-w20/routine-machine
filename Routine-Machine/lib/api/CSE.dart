import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:steel_crypt/steel_crypt.dart' as Steel;
import 'package:crypton/crypton.dart' as Crypton;

class CSE {
  var storage = const FlutterSecureStorage();
  static const privateKeyStorageKey = 'routine-machine-private-key';
  static const publicKeyStorageKey = 'routine-machine-public-key';
  static const dekStorageKey = 'routine-machine-dek';
  static final CSE _instance = CSE._create();
  factory CSE() => _instance;
  CSE._create();

  Future<String> generateDEK() async {
    final dek = Steel.CryptKey().genFortuna(len: 32);
    return dek;
  }

  Future<Crypton.RSAKeypair> generateNewKeyPair() async {
    return Crypton.RSAKeypair.fromRandom(keySize: 4096);
  }

  Future<String> getOwnerDEK() async {
    final containsKey = await storage.containsKey(key: dekStorageKey);
    if (!containsKey) await generateNewKeyPair();
    final dek = await storage.read(key: dekStorageKey);
    return dek;
  }

  Future<String> getOwnerPrivateKey() async {
    final containsKey = await storage.containsKey(key: privateKeyStorageKey);
    if (!containsKey) await generateNewKeyPair();
    final privateKey = await storage.read(key: privateKeyStorageKey);
    return privateKey;
  }

  Future<String> getOwnerPublicKey() async {
    final containsKey = await storage.containsKey(key: publicKeyStorageKey);
    if (!containsKey) await generateNewKeyPair();
    final publicKey = await storage.read(key: publicKeyStorageKey);
    return publicKey;
  }

  Future<void> setOwnerDEK() async {
    final dek = await generateDEK();
    await storage.write(key: dekStorageKey, value: dek);
  }

  Future<void> setOwnerPKPair({String publicKey, String privateKey}) async {
    throw UnimplementedError();
  }

  Future<String> getEncryptedDEK({String publicKey}) async {
    throw UnimplementedError();
  }

  Future<String> encryptText({String text}) async {
    throw UnimplementedError();
  }

  Future<String> decryptText({String dek}) async {
    throw UnimplementedError();
  }

  Future<String> encryptOwnerDEK({String usingPublicKey}) async {
    throw UnimplementedError();
  }

  Future<String> decryptOtherDEK({String encryptedDEK}) async {
    throw UnimplementedError();
  }
}
