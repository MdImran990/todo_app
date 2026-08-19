import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'task_controller.dart';

class AddTaskController extends GetxController {
  // TEXT CONTROLLERS

  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  // PRIORITY


  final RxString selectedPriority = 'Medium'.obs;

  // CHANGE PRIORITY

  void changePriority(String priority) {
    selectedPriority.value = priority;
  }

  // ADD TASK

  void addTask() {
    final title = titleController.text.trim();

    final description =
    descriptionController.text.trim();

    // VALIDATION

    if (title.isEmpty) {
      Get.snackbar(
        'Task Title Required',
        'Please enter a task title.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return;
    }

    // GET TASK CONTROLLER

    TaskController taskController;

    if (Get.isRegistered<TaskController>()) {
      taskController = Get.find<TaskController>();
    } else {
      taskController = Get.put(TaskController());
    }
    // ADD TASK

    taskController.addTask(
      title: title,
      description: description,
      priority: selectedPriority.value,
    );
    // SUCCESS MESSAGE

    Get.snackbar(
      'Task Added Successfully',
      '$title has been added to your tasks.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
    // CLEAR FIELDS

    titleController.clear();
    descriptionController.clear();

    selectedPriority.value = 'Medium';
    // BACK TO TASK SCREEN

    Get.back();
  }

  // DISPOSE

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();

    super.onClose();
  }
}