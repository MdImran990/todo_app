import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),

      // =====================================================
      // APP BAR
      // =====================================================

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        title: const Text(
          'TaskFlow',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_none_rounded,
            ),
          ),

          const SizedBox(width: 8),
        ],
      ),

      // =====================================================
      // BODY
      // =====================================================

      body: RefreshIndicator(
        onRefresh: controller.getTaskStatusCount,

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              // =================================================
              // GREETING
              // =================================================

              const Text(
                'Good Morning 👋',

                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Let’s manage your tasks',

                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 24),

              // =================================================
              // TOTAL TASK CARD
              // =================================================

              Obx(
                    () => Container(
                  width: double.infinity,

                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF5B5FEF),
                        Color(0xFF7B61FF),
                      ],
                    ),

                    borderRadius: BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        color: const Color(
                          0xFF5B5FEF,
                        ).withValues(alpha: 0.25),

                        blurRadius: 20,

                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      const Text(
                        'Your Tasks',

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 15,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // TOTAL TASKS
                      Text(
                        '${controller.totalTasks.value}',

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      const Text(
                        'Total tasks assigned',

                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =================================================
              // OVERVIEW
              // =================================================

              const Text(
                'Overview',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // =================================================
              // PENDING + COMPLETED
              // =================================================

              Row(
                children: [

                  Expanded(
                    child: Obx(
                          () => _summaryCard(
                        icon:
                        Icons.pending_actions_rounded,

                        title: 'New',

                        value:
                        '${controller.newTasks.value}',
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Obx(
                          () => _summaryCard(
                        icon:
                        Icons.check_circle_outline_rounded,

                        title: 'Completed',

                        value:
                        '${controller.completedTasks.value}',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // =================================================
              // PROGRESS + CANCELLED
              // =================================================

              Row(
                children: [

                  Expanded(
                    child: Obx(
                          () => _summaryCard(
                        icon:
                        Icons.timelapse_rounded,

                        title: 'Progress',

                        value:
                        '${controller.progressTasks.value}',
                      ),
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Obx(
                          () => _summaryCard(
                        icon:
                        Icons.cancel_outlined,

                        title: 'Cancelled',

                        value:
                        '${controller.cancelledTasks.value}',
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              // =================================================
              // RECENT TASKS
              // =================================================

              const Text(
                'Recent Tasks',

                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // -------------------------------------------------
              // TEMPORARY TASKS
              // -------------------------------------------------

              _taskCard(
                title: 'Complete Flutter Project',

                subtitle:
                'Today • High Priority',

                icon: Icons.code_rounded,
              ),

              const SizedBox(height: 12),

              _taskCard(
                title: 'Review API Integration',

                subtitle:
                'Tomorrow • Medium Priority',

                icon: Icons.api_rounded,
              ),

              const SizedBox(height: 12),

              _taskCard(
                title: 'Update Profile',

                subtitle:
                'Friday • Low Priority',

                icon:
                Icons.person_outline_rounded,
              ),
            ],
          ),
        ),
      ),

      // =====================================================
      // ADD TASK BUTTON
      // =====================================================

      floatingActionButton: FloatingActionButton(
        onPressed: () {},

        backgroundColor:
        const Color(0xFF5B5FEF),

        child: const Icon(
          Icons.add_rounded,
          color: Colors.white,
        ),
      ),

      // =====================================================
      // BOTTOM NAVIGATION
      // =====================================================

      bottomNavigationBar: Obx(
            () => NavigationBar(
          selectedIndex:
          controller.selectedIndex.value,

          onDestinationSelected:
          controller.changeBottomNav,

          destinations: const [

            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
              ),

              selectedIcon: Icon(
                Icons.home_rounded,
              ),

              label: 'Home',
            ),

            NavigationDestination(
              icon: Icon(
                Icons.task_outlined,
              ),

              selectedIcon: Icon(
                Icons.task_rounded,
              ),

              label: 'Tasks',
            ),

            NavigationDestination(
              icon: Icon(
                Icons.person_outline_rounded,
              ),

              selectedIcon: Icon(
                Icons.person_rounded,
              ),

              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  // =========================================================
  // SUMMARY CARD
  // =========================================================

  Widget _summaryCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.05),

            blurRadius: 15,

            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Icon(
            icon,

            size: 30,

            color: const Color(
              0xFF5B5FEF,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            value,

            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,

            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // =========================================================
  // TASK CARD
  // =========================================================

  Widget _taskCard({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
        BorderRadius.circular(18),

        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withValues(alpha: 0.04),

            blurRadius: 12,

            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: Row(
        children: [

          Container(
            width: 48,
            height: 48,

            decoration: BoxDecoration(
              color: const Color(
                0xFFEEF0FF,
              ),

              borderRadius:
              BorderRadius.circular(14),
            ),

            child: Icon(
              icon,

              color: const Color(
                0xFF5B5FEF,
              ),
            ),
          ),

          const SizedBox(width: 14),

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
                    fontSize: 15,
                    fontWeight:
                    FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  subtitle,

                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,

            size: 15,

            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}