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

    debugPrint('=== CREATE TASK CALLED ===');
    debugPrint('Title: $title');
    debugPrint('Priority: ${selectedPriority.value}');

    if (title.isEmpty) {
      Get.snackbar(
        'Task Required',
        'Please enter a task title.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // TaskController registered আছে কিনা চেক
    final bool isRegistered = Get.isRegistered<TaskController>();
    debugPrint('TaskController registered: $isRegistered');

    if (!isRegistered) {
      debugPrint('ERROR: TaskController not found!');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final taskController = Get.find<TaskController>();
    debugPrint('Tasks before add: ${taskController.tasks.length}');

    taskController.addTask({
      'title': title,
      'subtitle': description.isNotEmpty ? description : 'No description',
      'status': 'New',
      'priority': selectedPriority.value,
    });

    debugPrint('Tasks after add: ${taskController.tasks.length}');

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