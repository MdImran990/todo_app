import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_storage.dart';

class ProfileController extends GetxController {
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;
  final RxString email = ''.obs;
  final RxString mobile = ''.obs;
  final RxBool isLoading = true.obs;
  final RxBool notificationsEnabled = true.obs;
  final Rx<File?> profileImage = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  // =====================================================
  // LOAD USER INFO
  // =====================================================

  Future<void> loadUserInfo() async {
    isLoading.value = true;

    final info = await AuthStorage.getUserInfo();
    firstName.value = info['firstName'] ?? '';
    lastName.value = info['lastName'] ?? '';
    email.value = info['email'] ?? '';
    mobile.value = info['mobile'] ?? '';

    // ✅ photo আলাদাভাবে load — logout এ delete হয় না
    final String? savedPhoto = AuthStorage.getPhoto();
    if (savedPhoto != null && savedPhoto.isNotEmpty) {
      final file = File(savedPhoto);
      if (await file.exists()) {
        profileImage.value = file;
      }
    }

    isLoading.value = false;
  }

  String get fullName => '${firstName.value} ${lastName.value}'.trim();

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }

  // =====================================================
  // PICK IMAGE FROM GALLERY
  // =====================================================

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (picked != null) {
        profileImage.value = File(picked.path);

        // ✅ শুধু photo save — বাকি info যায় না
        AuthStorage.savePhoto(picked.path);

        Get.snackbar(
          'Success',
          'Profile photo updated!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not pick image. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // =====================================================
  // PICK IMAGE FROM CAMERA
  // =====================================================

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? picked = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (picked != null) {
        profileImage.value = File(picked.path);

        // ✅ শুধু photo save
        AuthStorage.savePhoto(picked.path);

        Get.snackbar(
          'Success',
          'Profile photo updated!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Could not take photo. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // =====================================================
  // SHOW IMAGE PICKER DIALOG
  // =====================================================

  void showImagePickerDialog() {
    Get.bottomSheet(
      _ImagePickerSheet(
        onGallery: () {
          Get.back();
          pickImageFromGallery();
        },
        onCamera: () {
          Get.back();
          pickImageFromCamera();
        },
      ),
      isScrollControlled: true,
    );
  }

  // =====================================================
  // LOGOUT
  // =====================================================

  Future<void> logout() async {
    await AuthStorage.clearAll();
    Get.offAllNamed(AppRoutes.login);
  }
}

// =====================================================
// IMAGE PICKER SHEET
// =====================================================

class _ImagePickerSheet extends StatelessWidget {
  final VoidCallback onGallery;
  final VoidCallback onCamera;

  const _ImagePickerSheet({
    required this.onGallery,
    required this.onCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Update Profile Photo',
            style: TextStyle(
              color: Color(0xFF171725),
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _PickerOption(
                  icon: Icons.photo_library_rounded,
                  label: 'Gallery',
                  onTap: onGallery,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _PickerOption(
                  icon: Icons.camera_alt_rounded,
                  label: 'Camera',
                  onTap: onCamera,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// =====================================================
// PICKER OPTION
// =====================================================

class _PickerOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PickerOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFFEDEEFF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF5B5FEF), size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF171725),
                fontSize: 13,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}