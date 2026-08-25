import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/services/theme_service.dart';
import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'theme/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeService.to.themeMode,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    ));
  }
}