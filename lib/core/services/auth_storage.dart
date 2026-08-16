import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorage {
  AuthStorage._();

  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  static const String _tokenKey = 'auth_token';

  static Future<void> saveToken(String token) async {
    await _storage.write(
      key: _tokenKey,
      value: token,
    );
  }

  static Future<String?> getToken() async {
    return await _storage.read(
      key: _tokenKey,
    );
  }

  static Future<void> deleteToken() async {
    await _storage.delete(
      key: _tokenKey,
    );
  }

  static Future<bool> hasToken() async {
    final String? token = await getToken();

    return token != null && token.isNotEmpty;
  }
}