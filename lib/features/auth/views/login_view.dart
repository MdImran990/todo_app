import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
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
          // TOP GRADIENT BACKGROUND

          Container(
            height: size.height * 0.47,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: AppColors.primaryGradient,
            ),
          ),

          // DECORATIVE CIRCLE 1

          Positioned(
            top: -80,
            right: -60,
            child: Container(
              height: 190,
              width: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
          ),

          // DECORATIVE CIRCLE 2

          Positioned(
            top: 130,
            left: -85,
            child: Container(
              height: 160,
              width: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          // MAIN CONTENT

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                20,
                35,
                20,
                30,
              ),
              child: Column(
                children: [
                  // APP LOGO

                  Container(
                    height: 74,
                    width: 74,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.18),
                      borderRadius: BorderRadius.circular(23),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.25),
                      ),
                    ),
                    child: const Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: 44,
                    ),
                  ),

                  const SizedBox(height: 18),

                  // APP NAME

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
                  // APP DESCRIPTION
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
                  // LOGIN CARD
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
                        // TITLE

                        Text(
                          'Welcome Back',
                          style: theme.textTheme.headlineMedium,
                        ),

                        const SizedBox(height: 7),

                        Text(
                          'Sign in to continue to your workspace',
                          style: theme.textTheme.bodyMedium,
                        ),

                        const SizedBox(height: 28),

                        // EMAIL LABEL

                        Text(
                          'Email Address',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 9),
                        // EMAIL FIELD

                        TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            hintText: 'you@example.com',
                            prefixIcon: Icon(
                              Icons.mail_outline_rounded,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        // PASSWORD LABEL
                        Text(
                          'Password',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 9),
                        // PASSWORD FIELD

                        Obx(
                              () => TextField(
                            controller: controller.passwordController,
                            obscureText:
                            controller.isPasswordHidden.value,
                            textInputAction: TextInputAction.done,
                            onSubmitted: (_) {
                              if (!controller.isLoading.value) {
                                controller.login();
                              }
                            },
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
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),
                        // FORGOT PASSWORD
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.forgotPassword);
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),
                        // LOGIN BUTTON
                        Obx(
                              () => SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: controller.isLoading.value
                                    ? const LinearGradient(
                                  colors: [
                                    AppColors.textLight,
                                    AppColors.textSecondary,
                                  ],
                                )
                                    : AppColors.primaryGradient,
                                borderRadius: BorderRadius.circular(17),
                                boxShadow: controller.isLoading.value
                                    ? null
                                    : [
                                  BoxShadow(
                                    color: AppColors.primary
                                        .withValues(alpha: 0.28),
                                    blurRadius: 18,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: controller.isLoading.value
                                    ? null
                                    : controller.login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  disabledBackgroundColor:
                                  Colors.transparent,
                                  foregroundColor: Colors.white,
                                  disabledForegroundColor: Colors.white,
                                  shadowColor: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(17),
                                  ),
                                ),
                                child: controller.isLoading.value
                                    ? const SizedBox(
                                  height: 24,
                                  width: 24,
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
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight.w800,
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
                        ),

                        const SizedBox(height: 28),
                        // DIVIDER
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.border,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(
                                horizontal: 14,
                              ),
                              child: Text(
                                'OR',
                                style:
                                theme.textTheme.bodySmall?.copyWith(
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
                        // CREATE ACCOUNT

                        Center(
                          child: Wrap(
                            alignment: WrapAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: theme.textTheme.bodyMedium,
                              ),

                              GestureDetector(
                                onTap: () {
                                  // GO TO REGISTER SCREEN
                                  Get.toNamed(
                                    AppRoutes.register,
                                  );
                                },
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 22),
                  // TERMS
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