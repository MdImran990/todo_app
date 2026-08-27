import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'task_controller.dart';

class TaskDetailsController extends GetxController {
  final TaskController _taskController = Get.find<TaskController>();

  final RxMap<String, dynamic> task = <String, dynamic>{}.obs;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController =
  TextEditingController();

  final RxString selectedPriority = 'Medium'.obs;
  final RxString selectedStatus = 'New'.obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    final String? id = Get.arguments as String?;

    if (id != null && id.isNotEmpty) {
      loadTask(id);
    }
  }

  void loadTask(String id) {
    final Map<String, dynamic>? data =
    _taskController.getTaskById(id);

    if (data != null) {
      task.value = Map<String, dynamic>.from(data);

      titleController.text = data['title']?.toString() ?? '';

      descriptionController.text =
          data['description']?.toString() ?? '';

      selectedPriority.value =
          data['priority']?.toString() ?? 'Medium';

      selectedStatus.value =
          data['status']?.toString() ?? 'New';
    }
  }

  void changePriority(String priority) {
    selectedPriority.value = priority;
  }

  void changeStatus(String status) {
    selectedStatus.value = status;
  }

  Future<void> updateTask() async {
    final String title = titleController.text.trim();

    final String description =
    descriptionController.text.trim();

    if (title.isEmpty) {
      Get.snackbar(
        'Title Required',
        'Please enter a task title.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    final String id = task['id']?.toString() ?? '';

    if (id.isEmpty) {
      Get.snackbar(
        'Error',
        'Task ID not found.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    isLoading.value = true;

    try {
      final bool updated =
      await _taskController.updateTask(
        id: id,
        title: title,
        description: description,
        priority: selectedPriority.value,
      );

      if (!updated) {
        Get.snackbar(
          'Error',
          'Failed to update task.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      final bool statusUpdated =
      await _taskController.updateTaskStatus(
        id: id,
        newStatus: selectedStatus.value,
      );

      if (!statusUpdated) {
        Get.snackbar(
          'Error',
          'Task status could not be updated.',
          snackPosition: SnackPosition.BOTTOM,
        );

        return;
      }

      task.value = {
        ...task,
        'title': title,
        'description': description,
        'priority': selectedPriority.value,
        'status': selectedStatus.value,
        'subtitle':
        'Today • ${selectedPriority.value} Priority',
      };

      Get.snackbar(
        'Success',
        'Task updated successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteTask() async {
    final String id = task['id']?.toString() ?? '';

    if (id.isEmpty) {
      Get.snackbar(
        'Error',
        'Task ID not found.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Delete Task',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this task?',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back();

              isLoading.value = true;

              try {
                final bool deleted =
                await _taskController.deleteTask(id);

                if (deleted) {
                  Get.snackbar(
                    'Deleted',
                    'Task deleted successfully.',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );

                  Get.back();
                } else {
                  Get.snackbar(
                    'Error',
                    'Failed to delete task.',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              } catch (e) {
                Get.snackbar(
                  'Error',
                  'Something went wrong.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              } finally {
                isLoading.value = false;
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
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