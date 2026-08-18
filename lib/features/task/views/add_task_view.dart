import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({super.key});

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
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
          ),
        ),

        title: const Text(
          'Add New Task',
          style: TextStyle(
            color: textColor,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'Create a new task',
                style: TextStyle(
                  color: textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Add the details of your task below.',
                style: TextStyle(
                  color: mutedColor,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

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
                maxLines: 5,
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

              const Text(
                'Priority',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              Obx(
                    () => Row(
                  children: [
                    _priorityButton(
                      title: 'Low',
                      icon: Icons.keyboard_arrow_down_rounded,
                      selected: controller.selectedPriority.value == 'Low',
                    ),
                    const SizedBox(width: 10),
                    _priorityButton(
                      title: 'Medium',
                      icon: Icons.remove_rounded,
                      selected: controller.selectedPriority.value == 'Medium',
                    ),
                    const SizedBox(width: 10),
                    _priorityButton(
                      title: 'High',
                      icon: Icons.keyboard_arrow_up_rounded,
                      selected: controller.selectedPriority.value == 'High',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: controller.createTask, // ✅ ঠিক করা হয়েছে
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  icon: const Icon(Icons.add_task_rounded),
                  label: const Text(
                    'Create Task',
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

  Widget _priorityButton({
    required String title,
    required IconData icon,
    required bool selected,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          controller.changePriority(title);
        },
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
                title,
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