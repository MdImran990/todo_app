import 'dart:async';

import 'package:get/get.dart';

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
    final hour =
    currentTime.value.hour.toString().padLeft(2, '0');

    final minute =
    currentTime.value.minute.toString().padLeft(2, '0');

    final second =
    currentTime.value.second.toString().padLeft(2, '0');

    return '$hour:$minute:$second';
  }

  String get formattedDate {
    const List<String> months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    final int day = currentTime.value.day;

    final String month =
    months[currentTime.value.month - 1];

    final int year = currentTime.value.year;

    return '$day $month $year';
  }

  String get dayName {
    const List<String> days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];

    return days[currentTime.value.weekday - 1];
  }

  String get greeting {
    final int hour = currentTime.value.hour;

    if (hour < 12) {
      return 'Good Morning';
    }

    if (hour < 17) {
      return 'Good Afternoon';
    }

    if (hour < 21) {
      return 'Good Evening';
    }

    return 'Good Night';
  }

  @override
  void onClose() {
    _timer?.cancel();

    super.onClose();
  }
}