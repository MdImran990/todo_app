import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../core/services/auth_storage.dart';

class TaskController extends GetxController {
  // =====================================================
  // STORAGE
  // =====================================================

  final GetStorage _storage = GetStorage();

  // =====================================================
  // FILTER
  // =====================================================

  final RxInt selectedFilter = 0.obs;

  // =====================================================
  // SEARCH
  // =====================================================

  final RxString searchQuery = ''.obs;
  final RxBool isSearching = false.obs;

  // =====================================================
  // TASK LIST
  // =====================================================

  final RxList<Map<String, dynamic>> tasks =
      <Map<String, dynamic>>[].obs;

  // =====================================================
  // INIT
  // =====================================================

  @override
  void onInit() {
    super.onInit();

    loadTasks();
  }

  // =====================================================
  // STORAGE KEY
  // =====================================================

  Future<String> _getStorageKey() async {
    final String email =
    await AuthStorage.getCurrentEmail();

    if (email.isEmpty) {
      return 'tasks_guest';
    }

    final String safeEmail = email
        .trim()
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]'), '_');

    return 'tasks_$safeEmail';
  }

  // =====================================================
  // LOAD TASKS
  // =====================================================

  Future<void> loadTasks() async {
    final String storageKey =
    await _getStorageKey();

    final dynamic storedTasks =
    _storage.read(storageKey);

    tasks.clear();

    if (storedTasks != null &&
        storedTasks is List) {
      for (final task in storedTasks) {
        if (task is Map) {
          tasks.add(
            Map<String, dynamic>.from(task),
          );
        }
      }
    }

    tasks.refresh();
  }

  // =====================================================
  // SAVE TASKS
  // =====================================================

  Future<void> _saveTasks() async {
    final String storageKey =
    await _getStorageKey();

    final List<Map<String, dynamic>> taskList =
    tasks
        .map(
          (task) =>
      Map<String, dynamic>.from(task),
    )
        .toList();

    await _storage.write(
      storageKey,
      taskList,
    );
  }

  // =====================================================
  // CHANGE FILTER
  // =====================================================

  void changeFilter(int index) {
    selectedFilter.value = index;
  }

  // =====================================================
  // SEARCH
  // =====================================================

  void toggleSearch() {
    isSearching.value = !isSearching.value;

    if (!isSearching.value) {
      searchQuery.value = '';
    }
  }

  void onSearchChanged(String query) {
    searchQuery.value =
        query.trim().toLowerCase();
  }

  void searchTask(String value) {
    searchQuery.value =
        value.trim().toLowerCase();
  }

  void clearSearch() {
    searchQuery.value = '';
  }

  // =====================================================
  // FILTERED TASKS
  // =====================================================

  List<Map<String, dynamic>> get filteredTasks {
    List<Map<String, dynamic>> result =
    tasks.toList();

    if (selectedFilter.value != 0) {
      const List<String> statusList = [
        'New',
        'Progress',
        'Completed',
      ];

      final String selectedStatus =
      statusList[selectedFilter.value - 1];

      result = result.where((task) {
        return task['status']
            ?.toString() ==
            selectedStatus;
      }).toList();
    }

    return result;
  }

  // =====================================================
  // SEARCHED TASKS
  // =====================================================

  List<Map<String, dynamic>> get searchedTasks {
    if (searchQuery.value.isEmpty) {
      return filteredTasks;
    }

    return filteredTasks.where((task) {
      final String title =
          task['title']
              ?.toString()
              .toLowerCase() ??
              '';

      final String description =
          task['description']
              ?.toString()
              .toLowerCase() ??
              '';

      return title.contains(
        searchQuery.value,
      ) ||
          description.contains(
            searchQuery.value,
          );
    }).toList();
  }

  // =====================================================
  // STATISTICS
  // =====================================================

  int get totalTasks => tasks.length;

  int get newTasks =>
      tasks.where(
            (task) =>
        task['status'] == 'New',
      ).length;

  int get progressTasks =>
      tasks.where(
            (task) =>
        task['status'] == 'Progress',
      ).length;

  int get completedTasks =>
      tasks.where(
            (task) =>
        task['status'] == 'Completed',
      ).length;

  double get completionRate {
    if (totalTasks == 0) {
      return 0;
    }

    return completedTasks / totalTasks;
  }

  // =====================================================
  // GET TASK BY ID
  // =====================================================

  Map<String, dynamic>? getTaskById(
      String id,
      ) {
    try {
      return tasks.firstWhere(
            (task) =>
        task['id']?.toString() == id,
      );
    } catch (_) {
      return null;
    }
  }

  // =====================================================
  // ADD TASK
  // =====================================================

  Future<void> addTask({
    required String title,
    required String description,
    required String priority,
  }) async {
    final String id =
    DateTime.now()
        .microsecondsSinceEpoch
        .toString();

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

    await _saveTasks();
  }

  // =====================================================
  // UPDATE TASK
  // =====================================================

  Future<bool> updateTask({
    required String id,
    required String title,
    required String description,
    required String priority,
  }) async {
    final int index =
    tasks.indexWhere(
          (task) =>
      task['id']?.toString() == id,
    );

    if (index == -1) {
      return false;
    }

    tasks[index] = {
      ...tasks[index],
      'title': title,
      'description': description,
      'priority': priority,
      'subtitle':
      'Today • $priority Priority',
    };

    tasks.refresh();

    await _saveTasks();

    return true;
  }

  // =====================================================
  // UPDATE STATUS
  // =====================================================

  Future<bool> updateTaskStatus({
    required String id,
    required String newStatus,
  }) async {
    final int index =
    tasks.indexWhere(
          (task) =>
      task['id']?.toString() == id,
    );

    if (index == -1) {
      return false;
    }

    tasks[index] = {
      ...tasks[index],
      'status': newStatus,
    };

    tasks.refresh();

    await _saveTasks();

    return true;
  }

  // =====================================================
  // DELETE TASK
  // =====================================================

  Future<bool> deleteTask(
      String id,
      ) async {
    final int oldLength = tasks.length;

    tasks.removeWhere(
          (task) =>
      task['id']?.toString() == id,
    );

    tasks.refresh();

    await _saveTasks();

    return tasks.length < oldLength;
  }
}