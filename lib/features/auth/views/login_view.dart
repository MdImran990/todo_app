import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/theme/app_colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ================= TOP GRADIENT =================
          Container(
            height: size.height * 0.46,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),

          // Decorative Circle
          Positioned(
            top: -70,
            right: -55,
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),

          Positioned(
            top: 140,
            left: -80,
            child: Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          // ================= CONTENT =================
          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 35, 20, 30),
              child: Column(
                children: [
                  // ================= LOGO =================
                  Container(
                    height: 72,
                    width: 72,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),

                  const SizedBox(height: 18),

                  const Text(
                    'TaskFlow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'Organize your tasks.\nAchieve more every day.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.82),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 42),

                  // ================= LOGIN CARD =================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(
                      22,
                      28,
                      22,
                      24,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.10),
                          blurRadius: 35,
                          offset: const Offset(0, 15),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome Back 👋',
                          style: theme.textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 7),

                        Text(
                          'Sign in to continue to your workspace',
                          style: theme.textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 28),

                        // ================= EMAIL =================
                        Text(
                          'Email Address',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 9),

                        TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          decoration: const InputDecoration(
                            hintText: 'you@example.com',
                            prefixIcon: Icon(
                              Icons.mail_outline_rounded,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // ================= PASSWORD =================
                        Text(
                          'Password',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 9),

                        Obx(
                              () => TextField(
                            controller: controller.passwordController,
                            obscureText:
                            controller.isPasswordHidden.value,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) => controller.login(),
                            decoration: InputDecoration(
                              hintText: 'Enter your password',
                              prefixIcon: const Icon(
                                Icons.lock_outline_rounded,
                                color: AppColors.primaryLight,
                              ),
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
                        ),

                        const SizedBox(height: 12),

                        // ================= FORGOT PASSWORD =================
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        // ================= LOGIN BUTTON =================
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: AppColors.primaryGradient,
                              borderRadius: BorderRadius.circular(17),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.28,
                                  ),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              onPressed: controller.login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                foregroundColor: Colors.white,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(17),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800,
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

                        const SizedBox(height: 26),

                        // ================= DIVIDER =================
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.border,
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(
                                'OR',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            const Expanded(
                              child: Divider(
                                color: AppColors.border,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 24),

                        // ================= REGISTER =================
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: theme.textTheme.bodyMedium,
                              children: [
                                WidgetSpan(
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: const Text(
                                      'Create Account',
                                      style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),

                  Text(
                    'By continuing, you agree to our Terms & Privacy Policy',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}