import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';

class HomeController extends GetxController {
  // =========================================================
  // STATES
  // =========================================================

  final RxInt selectedIndex = 0.obs;

  final RxBool isLoading = false.obs;

  final RxInt totalTasks = 0.obs;
  final RxInt newTasks = 0.obs;
  final RxInt progressTasks = 0.obs;
  final RxInt completedTasks = 0.obs;
  final RxInt cancelledTasks = 0.obs;

  // =========================================================
  // BOTTOM NAVIGATION
  // =========================================================

  void changeBottomNav(int index) {
    selectedIndex.value = index;
  }

  // =========================================================
  // GET TASK STATUS COUNT
  // =========================================================

  Future<void> getTaskStatusCount() async {
    try {
      isLoading.value = true;

      debugPrint('======================================');
      debugPrint('TASK STATUS COUNT API START');
      debugPrint('======================================');

      final response = await ApiClient.dio.get(
        ApiConstants.taskStatusCount,
      );

      debugPrint('STATUS CODE: ${response.statusCode}');
      debugPrint('RESPONSE: ${response.data}');
      debugPrint('======================================');

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map && data['status'] == 'success') {
          final dynamic taskData = data['data'];

          if (taskData is Map) {
            newTasks.value =
                int.tryParse('${taskData['New'] ?? 0}') ?? 0;

            progressTasks.value =
                int.tryParse('${taskData['Progress'] ?? 0}') ?? 0;

            completedTasks.value =
                int.tryParse('${taskData['Completed'] ?? 0}') ?? 0;

            cancelledTasks.value =
                int.tryParse('${taskData['Cancelled'] ?? 0}') ?? 0;

            totalTasks.value =
                newTasks.value +
                    progressTasks.value +
                    completedTasks.value +
                    cancelledTasks.value;
          }
        }
      }
    } catch (e) {
      debugPrint('TASK STATUS COUNT ERROR: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // =========================================================
  // CONTROLLER START
  // =========================================================

  @override
  void onInit() {
    super.onInit();

    getTaskStatusCount();
  }
}