import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperinote/app/theme/app_theme.dart';
import 'package:xperinote/data/controllers/settings_controller.dart';

import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => SharedPreferences.getInstance());
  Get.putAsync(() => SharedPreferences.getInstance());

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final SettingsController _settings = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
      title: 'XperiNote',
      theme: AppTheme.lightTheme(_settings.primaryColor),
      darkTheme: AppTheme.darkTheme(_settings.primaryColor),
      themeMode: _settings.currentThemeMode,
      initialRoute: AppRoutes.home,
      getPages: AppPages.pages,
      debugShowCheckedModeBanner: false,
    ));
  }
}
