import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'task_controller.dart';

class TaskDetailsController extends GetxController {
  final TaskController _taskController = Get.find<TaskController>();

  final RxMap<String, dynamic> task = <String, dynamic>{}.obs;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RxString selectedPriority = 'Medium'.obs;
  final RxString selectedStatus = 'New'.obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final String? id = Get.arguments as String?;
    if (id != null) {
      loadTask(id);
    }
  }

  void loadTask(String id) {
    final data = _taskController.getTaskById(id);
    if (data != null) {
      task.value = data;
      titleController.text = data['title'] ?? '';
      descriptionController.text = data['description'] ?? '';
      selectedPriority.value = data['priority'] ?? 'Medium';
      selectedStatus.value = data['status'] ?? 'New';
    }
  }

  void changePriority(String priority) {
    selectedPriority.value = priority;
  }

  void changeStatus(String status) {
    selectedStatus.value = status;
  }

  void updateTask() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (title.isEmpty) {
      Get.snackbar(
        'Title Required',
        'Please enter a task title.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final String id = task['id']?.toString() ?? '';

    final bool updated = _taskController.updateTask(
      id: id,
      title: title,
      description: description,
      priority: selectedPriority.value,
    );

    _taskController.updateTaskStatus(
      id: id,
      newStatus: selectedStatus.value,
    );

    if (updated) {
      Get.snackbar(
        'Success',
        'Task updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
      Get.back();
    } else {
      Get.snackbar(
        'Error',
        'Failed to update task.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void deleteTask() {
    final String id = task['id']?.toString() ?? '';

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete Task',
          style: TextStyle(
            color: Color(0xFF171725),
            fontWeight: FontWeight.w800,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this task?',
          style: TextStyle(color: Color(0xFF8C8C9A)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Color(0xFF8C8C9A)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              final bool deleted = _taskController.deleteTask(id);
              if (deleted) {
                Get.snackbar(
                  'Deleted',
                  'Task deleted successfully.',
                  snackPosition: SnackPosition.BOTTOM,
                  duration: const Duration(seconds: 2),
                );
                Get.back();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}