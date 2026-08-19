import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'task_controller.dart';

class TaskDetailsController extends GetxController {
  late TaskController taskController;

  String taskId = '';

  // =====================================================
  // EDIT CONTROLLERS
  // =====================================================

  final TextEditingController titleController =
  TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  final RxString selectedPriority = 'Medium'.obs;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<TaskController>()) {
      taskController = Get.find<TaskController>();
    } else {
      taskController = Get.put(TaskController());
    }

    final dynamic argument = Get.arguments;

    if (argument is String) {
      taskId = argument;
    } else if (argument is Map) {
      taskId = argument['id']?.toString() ?? '';
    }

    _loadTaskData();
  }

  // =====================================================
  // CURRENT TASK
  // =====================================================

  Map<String, dynamic>? get task {
    if (taskId.isEmpty) {
      return null;
    }

    return taskController.getTaskById(taskId);
  }

  // =====================================================
  // LOAD DATA
  // =====================================================

  void _loadTaskData() {
    final currentTask = task;

    if (currentTask == null) {
      return;
    }

    titleController.text =
        currentTask['title']?.toString() ?? '';

    descriptionController.text =
        currentTask['description']?.toString() ?? '';

    selectedPriority.value =
        currentTask['priority']?.toString() ?? 'Medium';
  }

  // =====================================================
  // TITLE
  // =====================================================

  String get title {
    return task?['title']?.toString() ?? '';
  }

  // =====================================================
  // DESCRIPTION
  // =====================================================

  String get description {
    return task?['description']?.toString() ?? '';
  }

  // =====================================================
  // SUBTITLE
  // =====================================================

  String get subtitle {
    final currentTask = task;

    if (currentTask == null) {
      return '';
    }

    final String desc =
        currentTask['description']?.toString() ?? '';

    if (desc.isNotEmpty) {
      return desc;
    }

    return currentTask['subtitle']?.toString() ?? '';
  }

  // =====================================================
  // PRIORITY
  // =====================================================

  String get priority {
    return task?['priority']?.toString() ?? 'Medium';
  }

  // =====================================================
  // STATUS
  // =====================================================

  String get status {
    return task?['status']?.toString() ?? 'New';
  }

  // =====================================================
  // CHANGE PRIORITY
  // =====================================================

  void changePriority(String priority) {
    selectedPriority.value = priority;
  }

  // =====================================================
  // UPDATE STATUS
  // =====================================================

  void updateStatus(String newStatus) {
    if (taskId.isEmpty) {
      return;
    }

    final bool success =
    taskController.updateTaskStatus(
      id: taskId,
      newStatus: newStatus,
    );

    if (!success) {
      Get.snackbar(
        'Error',
        'Task status could not be updated.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );
      return;
    }

    update();

    Get.snackbar(
      'Status Updated',
      'Task status changed to $newStatus.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  // =====================================================
  // SAVE EDIT
  // =====================================================

  bool saveTask() {
    final String newTitle =
    titleController.text.trim();

    final String newDescription =
    descriptionController.text.trim();

    if (newTitle.isEmpty) {
      Get.snackbar(
        'Title Required',
        'Please enter a task title.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return false;
    }

    final bool success =
    taskController.updateTask(
      id: taskId,
      title: newTitle,
      description: newDescription,
      priority: selectedPriority.value,
    );

    if (!success) {
      Get.snackbar(
        'Update Failed',
        'Task could not be updated.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return false;
    }

    update();

    Get.snackbar(
      'Task Updated',
      'Your task has been updated successfully.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );

    return true;
  }

  // =====================================================
  // DELETE
  // =====================================================

  void deleteTask() {
    if (taskId.isEmpty) {
      return;
    }

    final bool success =
    taskController.deleteTask(taskId);

    if (!success) {
      Get.snackbar(
        'Delete Failed',
        'Task could not be deleted.',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
      );

      return;
    }

    Get.back();

    Get.snackbar(
      'Task Deleted',
      'The task has been deleted successfully.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 2),
    );
  }

  // =====================================================
  // CONFIRM DELETE
  // =====================================================

  void confirmDelete() {
    Get.dialog(
      AlertDialog(
        title: const Text(
          'Delete Task?',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this task?',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              deleteTask();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // DISPOSE
  // =====================================================

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();

    super.onClose();
  }
}