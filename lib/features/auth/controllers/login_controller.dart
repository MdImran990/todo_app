import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';

class LoginController extends GetxController {
  // =========================================================
  // AUTH SERVICE
  // =========================================================

  final AuthService _authService = AuthService();

  // =========================================================
  // TEXT CONTROLLERS
  // =========================================================

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  // =========================================================
  // STATES
  // =========================================================

  final RxBool isPasswordHidden = true.obs;

  final RxBool isLoading = false.obs;

  // =========================================================
  // PASSWORD VISIBILITY
  // =========================================================

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  // =========================================================
  // LOGIN
  // =========================================================

  Future<void> login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    // =======================================================
    // EMAIL VALIDATION
    // =======================================================

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

    // =======================================================
    // PASSWORD VALIDATION
    // =======================================================

    if (password.isEmpty) {
      Get.snackbar(
        'Password Required',
        'Please enter your password.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // =======================================================
    // API CALL
    // =======================================================

    try {
      isLoading.value = true;

      debugPrint('======================================');
      debugPrint('TASKFLOW LOGIN START');
      debugPrint('Email: $email');
      debugPrint('======================================');

      final Response response = await _authService.login(
        email: email,
        password: password,
      );

      // =====================================================
      // API RESPONSE
      // =====================================================

      debugPrint(
        'Status Code: ${response.statusCode}',
      );

      debugPrint(
        'Response: ${response.data}',
      );

      debugPrint('======================================');

      // =====================================================
      // SUCCESS
      // =====================================================

      if (response.statusCode == 200) {
        final dynamic data = response.data;

        if (data is Map && data['status'] == 'success') {
          // -----------------------------------------------
          // GET TOKEN
          // -----------------------------------------------

          final String? token = data['token']?.toString();

          debugPrint(
            'Token received: ${token != null && token.isNotEmpty}',
          );

          // -----------------------------------------------
          // SUCCESS MESSAGE
          // -----------------------------------------------

          Get.snackbar(
            'Login Successful ',
            'Welcome back to TaskFlow!',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );

          // -----------------------------------------------
          // GO TO HOME
          // -----------------------------------------------

          await Future.delayed(
            const Duration(milliseconds: 500),
          );

          Get.offNamed(AppRoutes.home);

          return;
        }

        // ===================================================
        // API RETURNED 200 BUT LOGIN FAILED
        // ===================================================

        Get.snackbar(
          'Login Failed',
          'Email or password is incorrect.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      // =====================================================
      // OTHER STATUS CODE
      // =====================================================

      Get.snackbar(
        'Login Failed',
        'Unable to login. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // =======================================================
    // DIO ERROR
    // =======================================================

    on DioException catch (e) {
      debugPrint('======================================');
      debugPrint('LOGIN API ERROR');
      debugPrint('Message: ${e.message}');
      debugPrint(
        'Status Code: ${e.response?.statusCode}',
      );
      debugPrint(
        'Response: ${e.response?.data}',
      );
      debugPrint('======================================');

      String message =
          'Unable to login. Please try again.';

      if (e.response?.data is Map) {
        final Map errorData =
        e.response!.data as Map;

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

    // =======================================================
    // UNKNOWN ERROR
    // =======================================================

    catch (e) {
      debugPrint('======================================');
      debugPrint('UNEXPECTED LOGIN ERROR');
      debugPrint('$e');
      debugPrint('======================================');

      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    // =======================================================
    // STOP LOADING
    // =======================================================

    finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // DISPOSE
  // =========================================================

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();

    super.onClose();
  }
}