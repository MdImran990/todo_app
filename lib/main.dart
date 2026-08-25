import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/app.dart';
import 'core/services/notification_service.dart';
import 'core/services/theme_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ENV
  await dotenv.load(fileName: '.env');

  // Storage
  await GetStorage.init();

  // Notifications
  await NotificationService.init();

  // Theme Service
  Get.put(
    ThemeService(),
    permanent: true,
  );

  runApp(const App());
}