import 'package:get/get.dart';
import '../controllers/add_task_controller.dart';
import '../controllers/task_controller.dart';

class AddTaskBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddTaskController>(
          () => AddTaskController(),
    );

    if (!Get.isRegistered<TaskController>()) {
      Get.put<TaskController>(
        TaskController(),
        permanent: true,
      );
    }
  }
}