import 'package:get/get.dart';

class TaskController extends GetxController {
  // =====================================================
  // FILTER
  // =====================================================

  final RxInt selectedFilter = 0.obs;

  // =====================================================
  // TASK LIST
  // =====================================================

  final RxList<Map<String, dynamic>> tasks =
      <Map<String, dynamic>>[
        {
          'id': '1',
          'title': 'Complete Flutter Project',
          'subtitle': 'Today • High Priority',
          'description': 'Complete the Flutter TaskFlow project.',
          'status': 'New',
          'priority': 'High',
        },
        {
          'id': '2',
          'title': 'Review API Integration',
          'subtitle': 'Tomorrow • Medium Priority',
          'description': 'Review and test REST API integration.',
          'status': 'Progress',
          'priority': 'Medium',
        },
        {
          'id': '3',
          'title': 'Update Profile',
          'subtitle': 'Friday • Low Priority',
          'description': 'Update profile information.',
          'status': 'Completed',
          'priority': 'Low',
        },
      ].obs;

  // =====================================================
  // CHANGE FILTER
  // =====================================================

  void changeFilter(int index) {
    selectedFilter.value = index;
  }

  // =====================================================
  // FILTERED TASKS
  // =====================================================

  List<Map<String, dynamic>> get filteredTasks {
    if (selectedFilter.value == 0) {
      return tasks.toList();
    }

    const statusList = [
      'New',
      'Progress',
      'Completed',
    ];

    final selectedStatus =
    statusList[selectedFilter.value - 1];

    return tasks
        .where(
          (task) =>
      task['status']?.toString() == selectedStatus,
    )
        .toList();
  }

  // =====================================================
  // GET TASK BY ID
  // =====================================================

  Map<String, dynamic>? getTaskById(String id) {
    try {
      return tasks.firstWhere(
            (task) => task['id']?.toString() == id,
      );
    } catch (_) {
      return null;
    }
  }

  // =====================================================
  // ADD TASK
  // =====================================================

  void addTask({
    required String title,
    required String description,
    required String priority,
  }) {
    final String id =
    DateTime.now().microsecondsSinceEpoch.toString();

    final String subtitle =
        'Today • $priority Priority';

    tasks.add({
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'description': description,
      'status': 'New',
      'priority': priority,
    });

    tasks.refresh();
  }

  // =====================================================
  // UPDATE TASK
  // =====================================================

  bool updateTask({
    required String id,
    required String title,
    required String description,
    required String priority,
  }) {
    final int index = tasks.indexWhere(
          (task) => task['id']?.toString() == id,
    );

    if (index == -1) {
      return false;
    }

    tasks[index] = {
      ...tasks[index],
      'title': title,
      'description': description,
      'priority': priority,
      'subtitle': 'Today • $priority Priority',
    };

    tasks.refresh();

    return true;
  }

  // =====================================================
  // UPDATE STATUS
  // =====================================================

  bool updateTaskStatus({
    required String id,
    required String newStatus,
  }) {
    final int index = tasks.indexWhere(
          (task) => task['id']?.toString() == id,
    );

    if (index == -1) {
      return false;
    }

    tasks[index] = {
      ...tasks[index],
      'status': newStatus,
    };

    tasks.refresh();

    return true;
  }

  // =====================================================
  // DELETE TASK
  // =====================================================

  bool deleteTask(String id) {
    final int oldLength = tasks.length;

    tasks.removeWhere(
          (task) => task['id']?.toString() == id,
    );

    tasks.refresh();

    return tasks.length < oldLength;
  }
}