import 'package:get/get.dart';

import '../../../core/services/auth_storage.dart';

class HomeController extends GetxController {
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
}