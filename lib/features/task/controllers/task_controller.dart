import 'package:get/get.dart';

class TaskController extends GetxController {
  final RxInt selectedFilter = 0.obs;

  final RxList<Map<String, dynamic>> tasks = <Map<String, dynamic>>[
    {
      'title': 'Complete Flutter Project',
      'subtitle': 'Today • High Priority',
      'status': 'New',
    },
    {
      'title': 'Review API Integration',
      'subtitle': 'Tomorrow • Medium Priority',
      'status': 'Progress',
    },
    {
      'title': 'Update Profile',
      'subtitle': 'Friday • Low Priority',
      'status': 'Completed',
    },
  ].obs;

  void changeFilter(int index) {
    selectedFilter.value = index;
  }

  void addTask(Map<String, dynamic> task) {
    tasks.add(task);
  }

  List<Map<String, dynamic>> get filteredTasks {
    if (selectedFilter.value == 0) {
      return tasks;
    }

    final statusList = [
      'New',
      'Progress',
      'Completed',
    ];

    final selectedStatus = statusList[selectedFilter.value - 1];
    return tasks
        .where(
          (task) => task['status'] == selectedStatus,
    )
        .toList();
  }
}