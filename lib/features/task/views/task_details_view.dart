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
          onPressed: () => Get.back(),
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
            onPressed: controller.deleteTask,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.red,
            ),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // TITLE
              const Text(
                'Task Title',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.titleController,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Enter task title',
                  hintStyle: const TextStyle(color: mutedColor),
                  prefixIcon: const Icon(
                    Icons.task_alt_rounded,
                    color: primaryColor,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // DESCRIPTION
              const Text(
                'Description',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller.descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write something about this task...',
                  hintStyle: const TextStyle(color: mutedColor),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),

              const SizedBox(height: 24),

              // STATUS
              const Text(
                'Status',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Row(
                children: [
                  _statusButton('New', Icons.fiber_new_rounded),
                  const SizedBox(width: 10),
                  _statusButton('Progress', Icons.timelapse_rounded),
                  const SizedBox(width: 10),
                  _statusButton('Completed', Icons.check_circle_outline_rounded),
                ],
              )),

              const SizedBox(height: 24),

              // PRIORITY
              const Text(
                'Priority',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              Obx(() => Row(
                children: [
                  _priorityButton('Low', Icons.keyboard_arrow_down_rounded),
                  const SizedBox(width: 10),
                  _priorityButton('Medium', Icons.remove_rounded),
                  const SizedBox(width: 10),
                  _priorityButton('High', Icons.keyboard_arrow_up_rounded),
                ],
              )),

              const SizedBox(height: 35),

              // UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: controller.updateTask,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  icon: const Icon(Icons.save_rounded),
                  label: const Text(
                    'Update Task',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statusButton(String status, IconData icon) {
    final bool selected = controller.selectedStatus.value == status;
    final Color color;
    switch (status) {
      case 'Completed':
        color = Colors.green;
        break;
      case 'Progress':
        color = Colors.orange;
        break;
      default:
        color = primaryColor;
    }

    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changeStatus(status),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48,
          decoration: BoxDecoration(
            color: selected ? color : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? color : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 17,
                color: selected ? Colors.white : color,
              ),
              const SizedBox(width: 4),
              Text(
                status,
                style: TextStyle(
                  color: selected ? Colors.white : textColor,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _priorityButton(String priority, IconData icon) {
    final bool selected = controller.selectedPriority.value == priority;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changePriority(priority),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48,
          decoration: BoxDecoration(
            color: selected ? primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? primaryColor : Colors.transparent,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 19,
                color: selected ? Colors.white : primaryColor,
              ),
              const SizedBox(width: 5),
              Text(
                priority,
                style: TextStyle(
                  color: selected ? Colors.white : textColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}