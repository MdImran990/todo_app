import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/task_controller.dart';

class TaskView extends GetView<TaskController> {
  const TaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'My Tasks',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: RefreshIndicator(
        onRefresh: controller.getTasks,

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.fromLTRB(
            20,
            10,
            20,
            100,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =================================================
              // HEADER
              // =================================================

              const Text(
                'Manage your tasks',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // =================================================
              // FILTER
              // =================================================

              SizedBox(
                height: 42,

                child: Obx(
                      () => ListView.separated(
                    scrollDirection: Axis.horizontal,

                    itemCount:
                    controller.statusFilters.length,

                    separatorBuilder: (_, __) =>
                    const SizedBox(width: 10),

                    itemBuilder: (context, index) {
                      final status =
                      controller.statusFilters[index];

                      final isSelected =
                          controller.selectedStatus.value ==
                              status;

                      return GestureDetector(
                        onTap: () {
                          controller.changeStatus(status);
                        },

                        child: AnimatedContainer(
                          duration:
                          const Duration(milliseconds: 200),

                          padding:
                          const EdgeInsets.symmetric(
                            horizontal: 18,
                          ),

                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFF5B5FEF)
                                : Colors.white,

                            borderRadius:
                            BorderRadius.circular(14),

                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFF5B5FEF)
                                  : Colors.black12,
                            ),
                          ),

                          child: Text(
                            status,

                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.black87,

                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // =================================================
              // TASK LIST
              // =================================================

              Obx(
                    () {
                  if (controller.isLoading.value) {
                    return const Padding(
                      padding: EdgeInsets.only(top: 80),

                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (controller.tasks.isEmpty) {
                    return _emptyState();
                  }

                  return Column(
                    children: controller.tasks
                        .map(
                          (task) => Padding(
                        padding:
                        const EdgeInsets.only(
                          bottom: 12,
                        ),

                        child: _taskCard(task),
                      ),
                    )
                        .toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),

      // =====================================================
      // ADD TASK BUTTON
      // =====================================================

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF5B5FEF),

        onPressed: () {
          // Add Task screen next.
        },

        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),
    );
  }

  // =========================================================
  // TASK CARD
  // =========================================================

  Widget _taskCard(
      Map<String, dynamic> task,
      ) {
    final String title =
        task['title']?.toString() ?? 'Untitled Task';

    final String description =
        task['description']?.toString() ?? '';

    final String status =
        task['status']?.toString() ?? 'New';

    return Container(
      width: double.infinity,

      padding: const EdgeInsets.all(17),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color:
            Colors.black.withValues(alpha: 0.04),

            blurRadius: 15,

            offset:
            const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          // ===================================================
          // ICON
          // ===================================================

          Container(
            width: 50,
            height: 50,

            decoration: BoxDecoration(
              color:
              const Color(0xFFEEF0FF),

              borderRadius:
              BorderRadius.circular(15),
            ),

            child: const Icon(
              Icons.task_alt_rounded,
              color:
              Color(0xFF5B5FEF),
            ),
          ),

          const SizedBox(width: 14),

          // ===================================================
          // CONTENT
          // ===================================================

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                Text(
                  title,

                  maxLines: 1,

                  overflow:
                  TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                if (description.isNotEmpty) ...[
                  const SizedBox(height: 6),

                  Text(
                    description,

                    maxLines: 2,

                    overflow:
                    TextOverflow.ellipsis,

                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                ],

                const SizedBox(height: 10),

                _statusBadge(status),
              ],
            ),
          ),

          const SizedBox(width: 8),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 15,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // =========================================================
  // STATUS BADGE
  // =========================================================

  Widget _statusBadge(String status) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 5,
      ),

      decoration: BoxDecoration(
        color: const Color(0xFFEEF0FF),
        borderRadius:
        BorderRadius.circular(8),
      ),

      child: Text(
        status,

        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5B5FEF),
        ),
      ),
    );
  }

  // =========================================================
  // EMPTY STATE
  // =========================================================

  Widget _emptyState() {
    return Padding(
      padding:
      const EdgeInsets.only(top: 70),

      child: Center(
        child: Column(
          children: [

            Container(
              width: 80,
              height: 80,

              decoration: BoxDecoration(
                color:
                const Color(0xFFEEF0FF),

                borderRadius:
                BorderRadius.circular(25),
              ),

              child: const Icon(
                Icons.task_outlined,
                size: 40,
                color:
                Color(0xFF5B5FEF),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'No Tasks Found',

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'You don’t have any tasks yet.',

              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}