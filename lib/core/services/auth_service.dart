import 'package:dio/dio.dart';

import '../constants/api_constants.dart';
import '../network/api_client.dart';

class AuthService {
  final Dio _dio = ApiClient.dio;
  // LOGIN
  Future<Response> login({
    required String email,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {
        'email': email,
        'password': password,
      },
    );

    return response;
  }

  // REGISTER

  Future<Response> register({
    required String firstName,
    required String lastName,
    required String email,
    required String mobile,
    required String password,
    String photo = '',
  }) async {
    final response = await _dio.post(
      ApiConstants.registration,
      data: {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'mobile': mobile,
        'password': password,
        'photo': photo,
      },
    );

    return response;
  }
  // FORGOT PASSWORD - VERIFY EMAIL

  Future<Response> verifyRecoveryEmail({
    required String email,
  }) async {
    final response = await _dio.get(
      '${ApiConstants.recoverVerifyEmail}/$email',
    );

    return response;
  }
}