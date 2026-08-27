import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/add_task_controller.dart';

class AddTaskView extends GetView<AddTaskController> {
  const AddTaskView({super.key});

  static const Color primaryColor = Color(0xFF5B5FEF);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF171725);
    final mutedColor = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF8C8C9A);
    final borderColor = isDark ? const Color(0xFF2C2C2C) : Colors.transparent;

    return Scaffold(
      backgroundColor: bgColor,

      //APP BAR
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: textColor,
          ),
        ),

        title: Text(
          'Add New Task',
          style: TextStyle(
            color: textColor,
            fontSize: 21,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      //BODY
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // HEADER
              Text(
                'Create a new task',
                style: TextStyle(
                  color: textColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Add the details of your task below.',
                style: TextStyle(
                  color: mutedColor,
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 30),

              // TASK TITLE
              Text(
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
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Enter task title',
                  hintStyle: TextStyle(color: mutedColor),
                  prefixIcon: const Icon(
                    Icons.task_alt_rounded,
                    color: primaryColor,
                  ),
                  filled: true,
                  fillColor: cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: primaryColor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 17,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // DESCRIPTION
              Text(
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
                style: TextStyle(color: textColor),
                decoration: InputDecoration(
                  hintText: 'Write something about this task...',
                  hintStyle: TextStyle(color: mutedColor),
                  filled: true,
                  fillColor: cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: borderColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: primaryColor,
                      width: 1.5,
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),

              const SizedBox(height: 24),

              // PRIORITY
              Text(
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
                      cardColor: cardColor,
                      textColor: textColor,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 10),
                    _priorityButton(
                      title: 'Medium',
                      icon: Icons.remove_rounded,
                      selected: controller.selectedPriority.value == 'Medium',
                      cardColor: cardColor,
                      textColor: textColor,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                    const SizedBox(width: 10),
                    _priorityButton(
                      title: 'High',
                      icon: Icons.keyboard_arrow_up_rounded,
                      selected: controller.selectedPriority.value == 'High',
                      cardColor: cardColor,
                      textColor: textColor,
                      borderColor: borderColor,
                      isDark: isDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              // CREATE TASK BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: controller.createTask,
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

  //PRIORITY BUTTON
  Widget _priorityButton({
    required String title,
    required IconData icon,
    required bool selected,
    required Color cardColor,
    required Color textColor,
    required Color borderColor,
    required bool isDark,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.changePriority(title),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 48,
          decoration: BoxDecoration(
            color: selected ? primaryColor : cardColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: selected ? primaryColor : borderColor,
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