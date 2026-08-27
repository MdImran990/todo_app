import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';

class AuthStorage {
  AuthStorage._();

  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static final GetStorage _box = GetStorage();

  static const String _tokenKey = 'auth_token';
  static const String _firstNameKey = 'first_name';
  static const String _lastNameKey = 'last_name';
  static const String _emailKey = 'user_email';
  static const String _mobileKey = 'user_mobile';
  static const String _photoKey = 'user_photo';

  // =====================================================
  // TOKEN
  // =====================================================

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

  // =====================================================
  // USER INFO SAVE
  // =====================================================

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

    // ✅ photo GetStorage এ save — logout এ delete হবে না
    if (photo.isNotEmpty) {
      _box.write(_photoKey, photo);
    }
  }

  // =====================================================
  // USER INFO GET
  // =====================================================

  static Future<Map<String, String>> getUserInfo() async {
    return {
      'firstName': await _storage.read(key: _firstNameKey) ?? '',
      'lastName': await _storage.read(key: _lastNameKey) ?? '',
      'email': await _storage.read(key: _emailKey) ?? '',
      'mobile': await _storage.read(key: _mobileKey) ?? '',
      'photo': _box.read(_photoKey) ?? '', // ✅ GetStorage থেকে
    };
  }

  // =====================================================
  // PHOTO — আলাদাভাবে save/get
  // =====================================================

  static void savePhoto(String path) {
    _box.write(_photoKey, path);
  }

  static String? getPhoto() {
    return _box.read(_photoKey);
  }

  // =====================================================
  // GET CURRENT EMAIL
  // =====================================================

  static Future<String> getCurrentEmail() async {
    return await _storage.read(key: _emailKey) ?? '';
  }

  // =====================================================
  // CLEAR — photo রেখে বাকি সব delete
  // =====================================================

  static Future<void> clearAll() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _firstNameKey);
    await _storage.delete(key: _lastNameKey);
    await _storage.delete(key: _emailKey);
    await _storage.delete(key: _mobileKey);
    // ✅ _photoKey delete করা হচ্ছে না
  }
}