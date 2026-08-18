import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../app/routes/app_routes.dart';
class SplashController extends GetxController {
  Timer? _timer;
  @override
  void onInit() {
    super.onInit();
    debugPrint(
      'SPLASH CONTROLLER STARTED',
    );
    _timer = Timer(
      const Duration(seconds: 3),
          () {
        debugPrint(
          'GOING TO LOGIN',
        );

        Get.offNamed(AppRoutes.login);
      },
    );
  }
  @override
  void onClose() {
    debugPrint(
      'SPLASH CONTROLLER CLOSED',
    );

    _timer?.cancel();

    super.onClose();
  }
}