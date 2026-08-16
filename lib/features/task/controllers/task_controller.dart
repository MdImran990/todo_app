import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TaskController extends GetxController {
  // =========================================================
  // STATE
  // =========================================================

  final RxBool isLoading = false.obs;

  final RxString selectedStatus = 'All'.obs;

  // =========================================================
  // TASK LIST
  // =========================================================

  final RxList<Map<String, dynamic>> tasks =
      <Map<String, dynamic>>[].obs;

  // =========================================================
  // FILTERS
  // =========================================================

  final List<String> statusFilters = [
    'All',
    'New',
    'Progress',
    'Completed',
    'Cancelled',
  ];

  // =========================================================
  // CHANGE FILTER
  // =========================================================

  void changeStatus(String status) {
    selectedStatus.value = status;

    // API integration আমরা পরের ধাপে করব।
    debugPrint('Selected Status: $status');
  }

  // =========================================================
  // LOAD TASKS
  // =========================================================

  Future<void> getTasks() async {
    try {
      isLoading.value = true;

      // API integration next step.
      //
      // এখানে:
      // listTaskByStatus
      // API call হবে।

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

    } catch (e) {
      debugPrint('Task Error: $e');

      Get.snackbar(
        'Error',
        'Unable to load tasks.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // INIT
  // =========================================================

  @override
  void onInit() {
    super.onInit();

    getTasks();
  }
}