import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../../../core/services/theme_service.dart';
import '../../task/views/task_statistics_view.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  static const Color primaryColor = Color(0xFF5B5FEF);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF171725);
    final mutedColor = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF8C8C9A);
    final iconBgColor = isDark ? const Color(0xFF2C2C3E) : const Color(0xFFEDEEFF);
    final dividerColor = isDark ? const Color(0xFF2C2C2C) : const Color(0xFFE9E9F2);

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          'Profile',
          style: TextStyle(
            color: textColor,
            fontSize: 22,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: colorScheme.primary),
          );
        }

        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 40),
          child: Column(
            children: [

              // ── PROFILE HEADER ────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF5B5FEF), Color(0xFF7B61FF)],
                  ),
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF5B5FEF).withValues(alpha: 0.28),
                      blurRadius: 24,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: controller.showImagePickerDialog,
                      child: Stack(
                        children: [
                          Obx(() => Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: controller.profileImage.value != null
                                ? ClipOval(
                              child: Image.file(
                                controller.profileImage.value!,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                              ),
                            )
                                : Center(
                              child: Text(
                                controller.firstName.value.isNotEmpty
                                    ? controller.firstName.value[0].toUpperCase()
                                    : 'U',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          )),

                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: primaryColor,
                                  width: 1.5,
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt_rounded,
                                color: primaryColor,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    Obx(() => Text(
                      controller.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    )),

                    const SizedBox(height: 4),

                    Obx(() => Text(
                      controller.email.value,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    )),

                    const SizedBox(height: 4),

                    Obx(() => Text(
                      controller.mobile.value,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    )),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── TASK STATISTICS ───────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Task Statistics',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      label: 'Total',
                      value: '12',
                      icon: Icons.task_alt_rounded,
                      color: colorScheme.primary,
                      bg: iconBgColor,
                      cardColor: cardColor,
                      textColor: textColor,
                      mutedColor: mutedColor,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      label: 'Completed',
                      value: '7',
                      icon: Icons.check_circle_outline_rounded,
                      color: const Color(0xFF1D9E75),
                      bg: isDark ? const Color(0xFF1A2E27) : const Color(0xFFE1F5EE),
                      cardColor: cardColor,
                      textColor: textColor,
                      mutedColor: mutedColor,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      label: 'Pending',
                      value: '5',
                      icon: Icons.pending_actions_rounded,
                      color: const Color(0xFFEF9F27),
                      bg: isDark ? const Color(0xFF2E2516) : const Color(0xFFFAEEDA),
                      cardColor: cardColor,
                      textColor: textColor,
                      mutedColor: mutedColor,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // ── SETTINGS ──────────────────────────────────
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Settings',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Obx(() => _buildSettingsTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      textColor: textColor,
                      iconBgColor: iconBgColor,
                      trailing: Switch(
                        value: controller.notificationsEnabled.value,
                        onChanged: controller.toggleNotifications,
                      ),
                    )),

                    Divider(height: 1, indent: 16, endIndent: 16, color: dividerColor),

                    Obx(() => _buildSettingsTile(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      textColor: textColor,
                      iconBgColor: iconBgColor,
                      trailing: Switch(
                        value: ThemeService.to.isDarkMode.value,
                        onChanged: (_) => ThemeService.to.toggleTheme(),
                      ),
                    )),

                    Divider(height: 1, indent: 16, endIndent: 16, color: dividerColor),

                    _buildSettingsTile(
                      icon: Icons.bar_chart_rounded,
                      title: 'Task Statistics',
                      textColor: textColor,
                      iconBgColor: iconBgColor,
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: mutedColor,
                      ),
                      onTap: () => Get.to(() => const TaskStatisticsView()),
                    ),

                    Divider(height: 1, indent: 16, endIndent: 16, color: dividerColor),

                    _buildSettingsTile(
                      icon: Icons.lock_outline_rounded,
                      title: 'Change Password',
                      textColor: textColor,
                      iconBgColor: iconBgColor,
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: mutedColor,
                      ),
                      onTap: () {},
                    ),

                    Divider(height: 1, indent: 16, endIndent: 16, color: dividerColor),

                    _buildSettingsTile(
                      icon: Icons.info_outline_rounded,
                      title: 'About App',
                      textColor: textColor,
                      iconBgColor: iconBgColor,
                      trailing: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: mutedColor,
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── LOGOUT ────────────────────────────────────
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.dialog(
                      AlertDialog(
                        backgroundColor: cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: Text(
                          'Logout',
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        content: Text(
                          'Are you sure you want to logout?',
                          style: TextStyle(color: mutedColor),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: mutedColor),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Get.back();
                              controller.logout();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: const Text('Logout'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? Colors.red.withValues(alpha: 0.15)
                        : const Color(0xFFFFEEEE),
                    foregroundColor: Colors.red,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required Color bg,
    required Color cardColor,
    required Color textColor,
    required Color mutedColor,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontSize: 22,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: mutedColor,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required Widget trailing,
    required Color textColor,
    required Color iconBgColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 4,
      ),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: iconBgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: primaryColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailing,
    );
  }
}