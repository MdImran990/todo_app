import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back button
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Logo
              Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5B5FEF),
                      Color(0xFF7B61FF),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(19),
                ),
                child: const Icon(
                  Icons.task_alt_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Create your TaskFlow account and start managing your tasks.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 30),

              // First Name
              _label('First Name'),

              const SizedBox(height: 8),

              _textField(
                controller: controller.firstNameController,
                hint: 'Enter your first name',
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 18),

              // Last Name
              _label('Last Name'),

              const SizedBox(height: 8),

              _textField(
                controller: controller.lastNameController,
                hint: 'Enter your last name',
                icon: Icons.person_outline_rounded,
              ),

              const SizedBox(height: 18),

              // Email
              _label('Email Address'),

              const SizedBox(height: 8),

              _textField(
                controller: controller.emailController,
                hint: 'Enter your email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              // Mobile
              _label('Mobile Number'),

              const SizedBox(height: 8),

              _textField(
                controller: controller.mobileController,
                hint: 'Enter your mobile number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 18),

              // Password
              _label('Password'),

              const SizedBox(height: 8),

              Obx(
                    () => _textField(
                  controller: controller.passwordController,
                  hint: 'Create a password',
                  icon: Icons.lock_outline_rounded,
                  obscureText:
                  controller.isPasswordHidden.value,
                  suffixIcon: IconButton(
                    onPressed:
                    controller.togglePasswordVisibility,
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Confirm Password
              _label('Confirm Password'),

              const SizedBox(height: 8),

              Obx(
                    () => _textField(
                  controller:
                  controller.confirmPasswordController,
                  hint: 'Confirm your password',
                  icon: Icons.lock_outline_rounded,
                  obscureText:
                  controller.isConfirmPasswordHidden.value,
                  suffixIcon: IconButton(
                    onPressed:
                    controller.toggleConfirmPasswordVisibility,
                    icon: Icon(
                      controller.isConfirmPasswordHidden.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Create Account Button
              Obx(
                    () => SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF5B5FEF),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                      const Color(0xFFBFC2F5),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child:
                      CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.white,
                      ),
                    )
                        : const Row(
                      mainAxisAlignment:
                      MainAxisAlignment.center,
                      children: [
                        Text(
                          'Create Account',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(
                          Icons.arrow_forward_rounded,
                          size: 21,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Login
              Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    const Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          color: Color(0xFF5B5FEF),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  // LABEL

  Widget _label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }
  // TEXT FIELD

  Widget _textField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF5B5FEF),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 18,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: const BorderSide(
            color: Color(0xFF5B5FEF),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}