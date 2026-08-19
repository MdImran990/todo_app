import 'package:get/get.dart';

import '../../../core/services/auth_storage.dart';

class HomeController extends GetxController {
  final RxInt selectedIndex = 0.obs;

  // ✅ User info
  final RxString firstName = ''.obs;
  final RxString lastName = ''.obs;

  String get fullName => '${firstName.value} ${lastName.value}'.trim();

  @override
  void onInit() {
    super.onInit();
    loadUserInfo();
  }

  Future<void> loadUserInfo() async {
    final info = await AuthStorage.getUserInfo();
    firstName.value = info['firstName'] ?? '';
    lastName.value = info['lastName'] ?? '';
  }

  void changeBottomNav(int index) {
    selectedIndex.value = index;
  }
}