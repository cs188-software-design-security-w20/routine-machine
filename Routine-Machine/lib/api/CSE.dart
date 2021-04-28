import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final storage = new FlutterSecureStorage();
const privateKeyStorageKey = 'routine-machine-private-key';
const publicKeyStorageKey = 'routine-machine-public-key';
const dekStorageKey = 'routine-machine-dek';

class KeyPair {
  String publicKey;
  String privateKey;
  KeyPair({this.publicKey, this.privateKey});
}

Future<String> generateSymmetricKey() async {
  return '';
}

Future<KeyPair> generateNewKeyPair() async {
  return KeyPair(publicKey: '', privateKey: '');
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

Future<void> setNewOwnerPKPair({String publicKey, String privateKey}) async {
  await storage.write(key: publicKeyStorageKey, value: publicKey);
  await storage.write(key: privateKeyStorageKey, value: privateKey);
}

Future<String> getEncryptedDEK({String publicKey}) async {
  final ownerDEK = await getOwnerDEK();
  return ownerDEK;
}

Future<String> encryptText({String text}) async {
  return '';
}

Future<String> decryptText({String dek}) async {
  return '';
}

Future<String> encryptOwnerDEK({String usingPublicKey}) async {
  return '';
}

Future<String> decryptOtherDEK({String encryptedDEK}) async {
  return '';
}
