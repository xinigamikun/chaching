import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:encrypt/encrypt.dart' as encrypt;

class EncryptionService {
  static const _keyStorageKey = 'encryption_key';
  static const _ivStorageKey = 'encryption_iv';
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  late encrypt.Encrypter _encrypter;
  late encrypt.IV _iv;

  /// Initialize the encryption service
  Future<void> initialize() async {
    // Check if we have an existing key and IV
    String? storedKey = await _secureStorage.read(key: _keyStorageKey);
    String? storedIV = await _secureStorage.read(key: _ivStorageKey);

    if (storedKey == null || storedIV == null) {
      // Generate new key and IV if they don't exist
      await _generateAndStoreNewKey();
      storedKey = await _secureStorage.read(key: _keyStorageKey);
      storedIV = await _secureStorage.read(key: _ivStorageKey);
    }

    // Initialize encrypter with stored or new key
    final key = encrypt.Key(base64Decode(storedKey!));
    _iv = encrypt.IV(base64Decode(storedIV!));
    _encrypter = encrypt.Encrypter(encrypt.AES(key));
  }

  /// Generate and store a new encryption key and IV
  Future<void> _generateAndStoreNewKey() async {
    final key = encrypt.Key.fromSecureRandom(32); // 256-bit key
    final iv = encrypt.IV.fromSecureRandom(16); // 128-bit IV

    await _secureStorage.write(
      key: _keyStorageKey,
      value: base64Encode(key.bytes),
    );
    await _secureStorage.write(
      key: _ivStorageKey,
      value: base64Encode(iv.bytes),
    );
  }

  /// Encrypt a string
  String encryptString(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  /// Decrypt a string
  String decryptString(String encryptedText) {
    final encrypted = encrypt.Encrypted(base64Decode(encryptedText));
    return _encrypter.decrypt(encrypted, iv: _iv);
  }

  /// Encrypt a map
  String encryptMap(Map<String, dynamic> data) {
    final jsonString = jsonEncode(data);
    return encryptString(jsonString);
  }

  /// Decrypt a map
  Map<String, dynamic> decryptMap(String encryptedText) {
    final jsonString = decryptString(encryptedText);
    return jsonDecode(jsonString) as Map<String, dynamic>;
  }

  /// Encrypt a list
  String encryptList(List<dynamic> data) {
    final jsonString = jsonEncode(data);
    return encryptString(jsonString);
  }

  /// Decrypt a list
  List<dynamic> decryptList(String encryptedText) {
    final jsonString = decryptString(encryptedText);
    return jsonDecode(jsonString) as List<dynamic>;
  }

  /// Encrypt binary data
  String encryptBytes(Uint8List data) {
    final encrypted = _encrypter.encryptBytes(data, iv: _iv);
    return encrypted.base64;
  }

  /// Decrypt binary data
  Uint8List decryptBytes(String encryptedText) {
    final encrypted = encrypt.Encrypted(base64Decode(encryptedText));
    return Uint8List.fromList(_encrypter.decryptBytes(encrypted, iv: _iv));
  }

  /// Change the encryption key
  Future<void> rotateKey() async {
    // Generate new key and IV
    await _generateAndStoreNewKey();
    
    // Re-initialize with new key
    await initialize();
  }

  /// Clear stored encryption keys
  Future<void> clearKeys() async {
    await _secureStorage.delete(key: _keyStorageKey);
    await _secureStorage.delete(key: _ivStorageKey);
  }
}