import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../controllers/time_controller.dart';
import '../../task/controllers/task_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );

    Get.lazyPut<TimeController>(
          () => TimeController(),
    );
    Get.lazyPut<TaskController>(
          () => TaskController(),
    );

    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}