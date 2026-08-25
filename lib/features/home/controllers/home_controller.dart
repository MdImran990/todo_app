import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_storage.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;

  String get fullName {
    return '${firstName.value} ${lastName.value}'.trim();
  }

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final info = await AuthStorage.getUserInfo();

    firstName.value =
        info['firstName']?.toString() ?? '';

    lastName.value =
        info['lastName']?.toString() ?? '';
  }

  void changeBottomNav(int index) {
    if (index == selectedIndex.value) {
      return;
    }

    switch (index) {
      case 0:
        selectedIndex.value = 0;

        Get.offNamed(
          AppRoutes.home,
        );
        break;

      case 1:
        selectedIndex.value = 1;

        Get.toNamed(
          AppRoutes.tasks,
        );
        break;

      case 2:
        selectedIndex.value = 2;

        Get.toNamed(
          AppRoutes.profile,
        );
        break;
    }
  }
}