import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_service.dart';

class RegisterController extends GetxController {final AuthService _authService = AuthService();
  // TEXT CONTROLLERS
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController = TextEditingController();
  // STATES
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;
  final RxBool isLoading = false.obs;
  // PASSWORD VISIBILITY

  void togglePasswordVisibility() {
    isPasswordHidden.value =
    !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value =
    !isConfirmPasswordHidden.value;
  }
  // REGISTER

  Future<void> register() async {
    final String firstName =
    firstNameController.text.trim();

    final String lastName =
    lastNameController.text.trim();

    final String email =
    emailController.text.trim();

    final String mobile =
    mobileController.text.trim();

    final String password =
    passwordController.text.trim();

    final String confirmPassword =
    confirmPasswordController.text.trim();

    // VALIDATION

    if (firstName.isEmpty) {
      _showError(
        'First Name Required',
        'Please enter your first name.',
      );
      return;
    }

    if (lastName.isEmpty) {
      _showError(
        'Last Name Required',
        'Please enter your last name.',
      );
      return;
    }

    if (email.isEmpty) {
      _showError(
        'Email Required',
        'Please enter your email.',
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      _showError(
        'Invalid Email',
        'Please enter a valid email address.',
      );
      return;
    }

    if (mobile.isEmpty) {
      _showError(
        'Mobile Required',
        'Please enter your mobile number.',
      );
      return;
    }

    if (password.isEmpty) {
      _showError(
        'Password Required',
        'Please enter a password.',
      );
      return;
    }

    if (password.length < 6) {
      _showError(
        'Weak Password',
        'Password must be at least 6 characters.',
      );
      return;
    }

    if (confirmPassword.isEmpty) {
      _showError(
        'Confirm Password',
        'Please confirm your password.',
      );
      return;
    }

    if (password != confirmPassword) {
      _showError(
        'Password Mismatch',
        'Passwords do not match.',
      );
      return;
    }
    // API CALL
    try {
      isLoading.value = true;

      debugPrint('');
      debugPrint('TASKFLOW REGISTRATION START');
      debugPrint('Email: $email');
      debugPrint('Mobile: $mobile');
      debugPrint('');

      final Response response =
      await _authService.register(
        firstName: firstName,
        lastName: lastName,
        email: email,
        mobile: mobile,
        password: password,
      );
      // RESPONSE
      debugPrint(
        'REGISTER STATUS CODE: ${response.statusCode}',
      );

      debugPrint(
        'REGISTER RESPONSE: ${response.data}',
      );
      debugPrint('');

      // SUCCESS

      if (response.statusCode == 200 ||
          response.statusCode == 201) {
        final dynamic data = response.data;

        if (data is Map &&
            data['status'] == 'success') {
          Get.snackbar(
            'Registration Successful 🎉',
            'Your account has been created.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );

          await Future.delayed(
            const Duration(milliseconds: 700),
          );

          // Go to Login
          Get.offNamed(AppRoutes.login);

          return;
        }
      }
      // FAILED

      String message =
          'Registration failed. Please try again.';

      if (response.data is Map) {
        final Map data =
        response.data as Map;

        if (data['message'] != null) {
          message =
              data['message'].toString();
        }
      }

      _showError(
        'Registration Failed',
        message,
      );
    }

    // DIO ERROR

    on DioException catch (e) {
      debugPrint('');
      debugPrint('REGISTRATION API ERROR');
      debugPrint('Message: ${e.message}');
      debugPrint(
        'Status Code: ${e.response?.statusCode}',
      );
      debugPrint(
        'Response: ${e.response?.data}',
      );
      debugPrint('');

      String message =
          'Unable to create account. Please try again.';

      if (e.response?.data is Map) {
        final Map data =
        e.response!.data as Map;

        if (data['message'] != null) {
          message =
              data['message'].toString();
        }
      }

      _showError(
        'Registration Failed',
        message,
      );
    }
    // UNKNOWN ERROR
    catch (e) {
      debugPrint(
        'Unexpected registration error: $e',
      );

      _showError(
        'Error',
        'Something went wrong. Please try again.',
      );
    }
    // STOP LOADING

    finally {
      isLoading.value = false;
    }
  }
  // ERROR SNACKBAR
  void _showError(
      String title,
      String message,
      ) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
  // DISPOSE
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}