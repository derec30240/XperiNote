import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperinote/app/routes/app_pages.dart';
import 'package:xperinote/app/routes/app_routes.dart';
import 'package:xperinote/app/theme/app_theme.dart';
import 'package:xperinote/data/controllers/experiment_controller.dart';
import 'package:xperinote/data/controllers/settings_controller.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/data/repositories/experiment_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Get.putAsync(() => SharedPreferences.getInstance());

  await Hive.initFlutter();
  Hive.registerAdapter(ExperimentAdapter());
  await Hive.openBox<Experiment>('experimentBox');

  Get.lazyPut<ExperimentRepository>(() => HiveExperimentRepository());
  Get.lazyPut<ExperimentController>(() => ExperimentController(Get.find<ExperimentRepository>()));

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final SettingsController _settings = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        title: 'XperiNote',
        theme: AppTheme.lightTheme(_settings.primaryColor),
        darkTheme: AppTheme.darkTheme(_settings.primaryColor),
        themeMode: _settings.currentThemeMode,
        initialRoute: AppRoutes.home,
        getPages: AppPages.pages,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
