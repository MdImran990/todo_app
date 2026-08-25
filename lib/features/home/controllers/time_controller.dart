import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class TimeController extends GetxController {
  final Rx<DateTime> currentTime = DateTime.now().obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        currentTime.value = DateTime.now();
      },
    );
  }

  String get formattedTime {
    return DateFormat(
      'hh:mm:ss a',
    ).format(currentTime.value);
  }

  String get formattedDate {
    return DateFormat(
      'dd MMMM yyyy',
    ).format(currentTime.value);
  }

  String get dayName {
    return DateFormat(
      'EEEE',
    ).format(currentTime.value);
  }

  String get greeting {
    final hour = currentTime.value.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}