import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/auth_storage.dart';
class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // EMAIL VALIDATION
    if (email.isEmpty) {
      Get.snackbar(
        'Email Required',
        'Please enter your email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Invalid Email',
        'Please enter a valid email address.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // PASSWORD VALIDATION
    if (password.isEmpty) {
      Get.snackbar(
        'Password Required',
        'Please enter your password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // API CALL
    try {
      isLoading.value = true;

      debugPrint('');
      debugPrint('TASKFLOW LOGIN START');
      debugPrint('Email: $email');
      debugPrint('');

      final Response response = await _authService.login(
        email: email,
        password: password,
      );

      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response: ${response.data}');
      debugPrint('');

      // SUCCESS
      if (response.statusCode == 200) {
        final dynamic data = response.data;

        if (data is Map && data['status'] == 'success') {
          final String? token = data['token']?.toString();

          // TOKEN SAVE
          await AuthStorage.saveToken(token ?? '');

          // USER INFO SAVE
          final Map userData = data['data'] ?? {};
          await AuthStorage.saveUserInfo(
            firstName: userData['firstName']?.toString() ?? '',
            lastName: userData['lastName']?.toString() ?? '',
            email: userData['email']?.toString() ?? '',
            mobile: userData['mobile']?.toString() ?? '',
            photo: userData['photo']?.toString() ?? '',
          );

          debugPrint('Token received: ${token != null && token.isNotEmpty}');
          debugPrint('User: ${userData['firstName']} ${userData['lastName']}');

          Get.snackbar(
            'Login Successful',
            'Welcome back to TaskFlow!',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );

          await Future.delayed(const Duration(milliseconds: 500));
          Get.offNamed(AppRoutes.home);
          return;
        }

        Get.snackbar(
          'Login Failed',
          'Email or password is incorrect.',
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      Get.snackbar(
        'Login Failed',
        'Unable to login. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    on DioException catch (e) {
      debugPrint('=');
      debugPrint('LOGIN API ERROR');
      debugPrint('Message: ${e.message}');
      debugPrint('Status Code: ${e.response?.statusCode}');
      debugPrint('Response: ${e.response?.data}');
      debugPrint('=');

      String message = 'Unable to login. Please try again.';

      if (e.response?.data is Map) {
        final Map errorData = e.response!.data as Map;
        if (errorData['message'] != null) {
          message = errorData['message'].toString();
        }
      }

      Get.snackbar(
        'Login Failed',
        message,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
    catch (e) {
      debugPrint('=');
      debugPrint('UNEXPECTED LOGIN ERROR');
      debugPrint('$e');
      debugPrint('=');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    finally {
      isLoading.value = false;
    }
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}