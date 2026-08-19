import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_details_controller.dart';

class TaskDetailsView extends GetView<TaskDetailsController> {
  const TaskDetailsView({super.key});

  static const Color primaryColor = Color(0xFF5B5FEF);
  static const Color backgroundColor = Color(0xFFF7F8FC);
  static const Color textColor = Color(0xFF171725);
  static const Color mutedColor = Color(0xFF8C8C9A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
          ),
        ),
        title: const Text(
          'Task Details',
          style: TextStyle(
            color: textColor,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showEditDialog,
            icon: const Icon(
              Icons.edit_rounded,
              color: primaryColor,
            ),
          ),
          IconButton(
            onPressed: controller.confirmDelete,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.redAccent,
            ),
          ),
        ],
      ),
      body: GetBuilder<TaskDetailsController>(
        builder: (controller) {
          if (controller.task == null) {
            return const Center(child: Text('Task not found'));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5B5FEF),
                        Color(0xFF7B61FF),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        controller.subtitle,
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                _info('Priority', controller.priority),
                _info('Status', controller.status),
                _info(
                  'Description',
                  controller.description.isEmpty
                      ? 'No description'
                      : controller.description,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Change Status',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _statusButton('New'),
                    const SizedBox(width: 8),
                    _statusButton('Progress'),
                    const SizedBox(width: 8),
                    _statusButton('Completed'),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _showEditDialog,
                    icon: const Icon(Icons.edit_rounded),
                    label: const Text('Edit Task'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: controller.confirmDelete,
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Delete Task'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _info(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: mutedColor)),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusButton(String status) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.updateStatus(status),
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: controller.status == status
                ? primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            status,
            style: TextStyle(
              color: controller.status == status
                  ? Colors.white
                  : textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog() {
    controller.titleController.text = controller.title;
    controller.descriptionController.text =
        controller.description;
    controller.selectedPriority.value = controller.priority;

    Get.dialog(
      AlertDialog(
        title: const Text('Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.descriptionController,
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            const SizedBox(height: 16),
            Obx(
                  () => DropdownButton<String>(
                value: controller.selectedPriority.value,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'Low',
                    child: Text('Low'),
                  ),
                  DropdownMenuItem(
                    value: 'Medium',
                    child: Text('Medium'),
                  ),
                  DropdownMenuItem(
                    value: 'High',
                    child: Text('High'),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) {
                    controller.changePriority(value);
                  }
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final success = controller.saveTask();

              if (success) {
                Get.back();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}