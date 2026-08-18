import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  AuthStorage._();
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';
  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';
  static const String _emailKey = 'user_email';
  static const String _mobileKey = 'user_mobile';
  static const String _photoKey = 'user_photo';

  // TOKEN
  static Future<void> saveToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: _tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<bool> hasToken() async {
    final String? token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // USER INFO SAVE
  static Future<void> saveUserInfo({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    String photo = '',
  }) async {
    await _storage.write(key: _firstNameKey, value: firstName);
    await _storage.write(key: _lastNameKey, value: lastName);
    await _storage.write(key: _emailKey, value: email);
    await _storage.write(key: _mobileKey, value: mobile);
    await _storage.write(key: _photoKey, value: photo);
  }

  // USER INFO GET
  static Future<Map<String, String>> getUserInfo() async {
    return {
      'firstName': await _storage.read(key: _firstNameKey) ?? '',
      'lastName': await _storage.read(key: _lastNameKey) ?? '',
      'email': await _storage.read(key: _emailKey) ?? '',
      'mobile': await _storage.read(key: _mobileKey) ?? '',
      'photo': await _storage.read(key: _photoKey) ?? '',
    };
  }

  // CLEAR ALL
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}