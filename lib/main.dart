// main.dart
// XperiNote 应用程序入口文件
// 负责初始化依赖、数据库、控制器，并启动主应用

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
import 'package:xperinote/data/models/experiment_step.dart';
import 'package:xperinote/data/repositories/experiment_repository.dart';

/// 应用程序主入口。
/// 初始化依赖、数据库、控制器，并启动主界面。
Future<void> main() async {
  // 确保 Flutter 绑定已初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 SharedPreferences 作为全局依赖
  await Get.putAsync(() => SharedPreferences.getInstance());

  // 初始化 Hive 数据库及注册适配器
  await Hive.initFlutter();
  Hive.registerAdapter(ExperimentAdapter());
  Hive.registerAdapter(ExperimentStatusAdapter());
  Hive.registerAdapter(ExperimentStepAdapter());
  await Hive.openBox<Experiment>('experimentBox');

  // 依赖注入实验仓库与控制器
  Get.lazyPut<ExperimentRepository>(() => HiveExperimentRepository());
  Get.lazyPut<ExperimentController>(
    () => ExperimentController(Get.find<ExperimentRepository>()),
  );

  // 启动主应用
  runApp(MainApp());
}

/// 主应用组件，负责主题、路由等全局配置
class MainApp extends StatelessWidget {
  MainApp({super.key});

  /// 全局设置控制器，管理主题色与模式
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
