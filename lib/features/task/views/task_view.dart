import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../controllers/task_controller.dart';
import '../widgets/task_card.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final cardColor = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = isDark ? Colors.white : const Color(0xFF171725);
    final mutedColor = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF8C8C9A);

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Obx(() => controller.isSearching.value
            ? TextField(
          autofocus: true,
          onChanged: controller.onSearchChanged,
          decoration: InputDecoration(
            hintText: 'Search tasks...',
            hintStyle: TextStyle(color: mutedColor),
            border: InputBorder.none,
          ),
          style: TextStyle(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        )
            : Column(
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
            const SizedBox(height: 3),
            Text(
              'Manage your tasks',
              style: TextStyle(
                color: mutedColor,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        )),

        actions: [
          Obx(() => IconButton(
            onPressed: controller.toggleSearch,
            icon: Icon(
              controller.isSearching.value
                  ? Icons.close_rounded
                  : Icons.search_rounded,
              color: textColor,
            ),
          )),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.primary,
        elevation: 5,
        onPressed: () {
          Get.toNamed(AppRoutes.addTask)?.then((_) {
            controller.tasks.refresh();
          });
        },
        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
          size: 30,
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [

              // ── FILTER ───────────────────────────────────
              SizedBox(
                height: 44,
                child: Obx(() {
                  final int selected = controller.selectedFilter.value;
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
                      final bool isSelected = selected == index;

                      return GestureDetector(
                        onTap: () => controller.changeFilter(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: isSelected ? colorScheme.primary : cardColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              filters[index],
                              style: TextStyle(
                                color: isSelected ? Colors.white : textColor,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),

              const SizedBox(height: 22),

              // ── TASK LIST ─────────────────────────────────
              Expanded(
                child: Obx(() {
                  final List<Map<String, dynamic>> tasks =
                      controller.searchedTasks;

                  if (tasks.isEmpty) {
                    return _emptyState(context);
                  }

                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: tasks.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return TaskCard(
                        id: task['id']?.toString() ?? '',
                        title: task['title']?.toString() ?? '',
                        subtitle: task['subtitle']?.toString() ?? '',
                        status: task['status']?.toString() ?? '',
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emptyState(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : const Color(0xFF171725);
    final mutedColor = isDark ? const Color(0xFFB0B0B0) : const Color(0xFF8C8C9A);
    final iconBgColor = isDark ? const Color(0xFF2C2C3E) : const Color(0xFFEDEEFF);

    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.task_alt_rounded,
                color: colorScheme.primary,
                size: 42,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'No Tasks Found',
              style: TextStyle(
                color: textColor,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'You don\'t have any tasks here yet.',
              textAlign: TextAlign.center,
              style: TextStyle(color: mutedColor, fontSize: 13),
            ),
            const SizedBox(height: 22),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.addTask)?.then((_) {
                  controller.tasks.refresh();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colorScheme.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 13,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.add_rounded, size: 20),
              label: const Text(
                'Create Task',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}