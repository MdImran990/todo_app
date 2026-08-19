import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'task_controller.dart';

class AddTaskController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  final RxString selectedPriority = 'Medium'.obs;

  void changePriority(String priority) {
    selectedPriority.value = priority;
  }

  void createTask() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty) {
      Get.snackbar(
        'Task Required',
        'Please enter a task title.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final bool isRegistered = Get.isRegistered<TaskController>();

    if (!isRegistered) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final taskController = Get.find<TaskController>();

    // ✅ updated method call
    taskController.addTask(
      title: title,
      description: description,
      priority: selectedPriority.value,
    );

    Get.snackbar(
      'Success',
      'Task created successfully.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );

    Get.back();
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}