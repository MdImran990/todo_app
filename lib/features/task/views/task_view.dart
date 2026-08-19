import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_card.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  static const Color primaryColor = Color(0xFF5B5FEF);
  static const Color backgroundColor = Color(0xFFF7F8FC);
  static const Color textColor = Color(0xFF171725);
  static const Color mutedColor = Color(0xFF8C8C9A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'My Tasks',
              style: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 3),
            Text(
              'Manage your tasks',
              style: TextStyle(
                color: mutedColor,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),

      // =====================================================
      // ADD BUTTON
      // =====================================================

      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Get.toNamed(AppRoutes.addTask);
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            20,
          ),
          child: Column(
            children: [
              // =================================================
              // FILTER
              // =================================================

              SizedBox(
                height: 44,
                child: Obx(
                      () {
                    final int selected =
                        controller.selectedFilter.value;

                    const List<String> filters = [
                      'All',
                      'New',
                      'Progress',
                      'Completed',
                    ];

                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: filters.length,
                      itemBuilder: (context, index) {
                        final bool isSelected =
                            selected == index;

                        return GestureDetector(
                          onTap: () {
                            controller.changeFilter(index);
                          },
                          child: AnimatedContainer(
                            duration:
                            const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(
                              right: 10,
                            ),
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? primaryColor
                                  : Colors.white,
                              borderRadius:
                              BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                filters[index],
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : textColor,
                                  fontSize: 13,
                                  fontWeight:
                                  FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 22),

              // =================================================
              // TASK LIST
              // =================================================

              Expanded(
                child: Obx(
                      () {
                    final taskList =
                        controller.filteredTasks;

                    if (taskList.isEmpty) {
                      return _emptyState();
                    }

                    return ListView.separated(
                      physics:
                      const BouncingScrollPhysics(),
                      itemCount: taskList.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final task = taskList[index];

                        return TaskCard(
                          id: task['id'].toString(),
                          title:
                          task['title']?.toString() ?? '',
                          subtitle:
                          task['subtitle']?.toString() ?? '',
                          status:
                          task['status']?.toString() ?? '',
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: const BoxDecoration(
              color: Color(0xFFEDEEFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.task_alt_rounded,
              color: primaryColor,
              size: 42,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            'No Tasks Found',
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'You don\'t have any tasks here yet.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: mutedColor,
              fontSize: 13,
            ),
          ),

          const SizedBox(height: 22),

          ElevatedButton.icon(
            onPressed: () {
              Get.toNamed(AppRoutes.addTask);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              elevation: 0,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(14),
              ),
            ),
            icon: const Icon(Icons.add_rounded),
            label: const Text(
              'Create Task',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}