import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
import '../../../core/services/auth_storage.dart';

class SplashController extends GetxController {
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    debugPrint('SPLASH CONTROLLER STARTED');

    _timer = Timer(
      const Duration(seconds: 3),
          () async {
        final bool hasToken = await AuthStorage.hasToken();

        if (hasToken) {
          debugPrint('TOKEN FOUND → GOING TO HOME');
          Get.offNamed(AppRoutes.home);
        } else {
          debugPrint('NO TOKEN → GOING TO LOGIN');
          Get.offNamed(AppRoutes.login);
        }
      },
    );
  }

  @override
  void onClose() {
    debugPrint('SPLASH CONTROLLER CLOSED');
    _timer?.cancel();
    super.onClose();
  }
}