import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      // App Information
      title: 'TaskFlow',

      // Global Theme
      theme: AppTheme.lightTheme,

      // Initial Route
      initialRoute: AppRoutes.splash,

      // GetX Routes
      getPages: AppPages.routes,
    );
  }
}