import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController =
  TextEditingController();

  void verifyEmail() {
    final email = emailController.text.trim();

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
    Get.snackbar(
      'Email Ready',
      'Email validation successful.',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}