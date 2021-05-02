import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:routine_machine/api/CSE.dart';
import './mock_storage.dart';
import './mock_objects.dart';

void main() {
  CSE cse;

  setUp(() {
    cse = new CSE();
    cse.injectStorageProvider(provider: MockStorage());
  });

  tearDown(() {
    cse = null;
  });

  test('CSE is a singleton', () {
    final cse1 = new CSE();
    final cse2 = new CSE();
    expect(cse1, same(cse2));
  });

  group('Creation and Storage of Keys:', () {
    test('Getters when key is not initialized', () async {
      expect(cse.hasDEK(), completion(equals(false)));
      expect(cse.hasKeyPair(), completion(equals(false)));
      expect(cse.getDEK(), throwsA(isA<MissingKeyException>()));
      expect(cse.getPublicKey(), throwsA(isA<MissingKeyException>()));
      expect(cse.getPrivateKey(), throwsA(isA<MissingKeyException>()));
    });

    test('DEK initialization and getters', () async {
      await cse.refreshOwnerDEK();
      final aesKey = await cse.getDEK();
      final keyBytes = base64Decode(aesKey.key);
      final ivBytes = base64Decode(aesKey.iv);
      expect(cse.hasDEK(), completion(isTrue));
      expect(cse.hasKeyPair(), completion(isFalse));
      expect(aesKey.key, isNotNull);
      expect(aesKey.iv, isNotNull);
      expect(keyBytes.length, equals(32));
      expect(ivBytes.length, equals(16));
    });

    test('PKPair initialization and getters', () async {
      await cse.refreshOwnerPKPair();
      final publicKey = await cse.getPublicKey();
      final privateKey = await cse.getPrivateKey();
      expect(cse.hasDEK(), completion(isFalse));
      expect(cse.hasKeyPair(), completion(isTrue));
      expect(publicKey, isNotNull);
      expect(privateKey, isNotNull);
    });

    test('Refreshing keys', () async {
      await cse.refreshOwnerDEK();
      await cse.refreshOwnerPKPair();
      final firstAESKey = await cse.getDEK();
      final firstPrivateKey = await cse.getPrivateKey();
      final firstPublicKey = await cse.getPublicKey();
      await cse.refreshOwnerDEK();
      await cse.refreshOwnerPKPair();
      final secondAESKey = await cse.getDEK();
      final secondPrivateKey = await cse.getPrivateKey();
      final secondPublicKey = await cse.getPublicKey();
      expect(firstAESKey.key, isNot(equals(secondAESKey.key)));
      expect(firstAESKey.iv, isNot(equals(secondAESKey.iv)));
      expect(firstPublicKey, isNot(equals(secondPublicKey)));
      expect(firstPrivateKey, isNot(equals(secondPrivateKey)));
    });
  });

  group('Encryption and Decryption:', () {
    test('DEK Encryption using owner key', () async {
      await cse.refreshOwnerDEK();
      final encrypted = await cse.encryptText(text: testJSON);
      final decrypted = await cse.decryptText(text: encrypted);
      expect(testJSON, equals(decrypted));
    });
    test('DEK Encryption using other key', () async {
      await cse.refreshOwnerDEK();
      final otherDEK = await cse.getDEK();
      final encrypted = await cse.encryptText(text: testJSON);
      await cse.refreshOwnerDEK();
      final decrypted =
          await cse.decryptText(text: encrypted, usingKey: otherDEK);
      expect(decrypted, equals(testJSON));
    });

    test('Asymmetric Encryption of DEK', () async {
      await cse.refreshOwnerDEK();
      await cse.refreshOwnerPKPair();
      final ownerDEK = await cse.getDEK();
      final ownerPublicKey = await cse.getPublicKey();
      final encryptedDEK =
          await cse.encryptOwnerDEK(usingPublicKey: ownerPublicKey.toString());
      final decryptedDEK =
          await cse.decryptOtherDEK(encryptedDEK: encryptedDEK);
      expect(decryptedDEK.key, equals(ownerDEK.key));
      expect(decryptedDEK.iv, equals(ownerDEK.iv));
    });
  });
}
