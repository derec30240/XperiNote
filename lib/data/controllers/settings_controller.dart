// settings_controller.dart
// 应用设置控制器，负责主题色与主题模式的管理与持久化

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperinote/app/theme/app_theme.dart';

/// [SettingsController] 负责管理应用的主题色与主题模式，
/// 并将用户设置持久化到 SharedPreferences。
class SettingsController extends GetxController {
  /// 当前主色调，默认为蓝色
  final Rx<MaterialColor> _primaryColor = Colors.blue.obs;
  /// 当前主题模式，'system' | 'light' | 'dark'
  final RxString _themeMode = 'system'.obs;

  /// 获取当前主色调
  MaterialColor get primaryColor => _primaryColor.value;
  /// 获取当前主题模式字符串
  String get themeMode => _themeMode.value;
  /// 获取当前 ThemeMode 枚举值
  ThemeMode get currentThemeMode {
    switch (_themeMode.value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  /// 从 SharedPreferences 加载主题色与主题模式
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('primaryColor') ?? Colors.blue.toARGB32();
    _primaryColor.value = AppTheme.presetColors.firstWhere(
      (color) => color.toARGB32() == colorValue,
      orElse: () => Colors.blue,
    );
    _themeMode.value = prefs.getString('themeMode') ?? 'system';
  }

  /// 更新主色调并持久化
  void updatePrimaryColor(MaterialColor color) async {
    _primaryColor.value = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColor', color.toARGB32());
  }

  /// 更新主题模式并持久化，同时切换应用主题
  void updateThemeMode(String mode) async {
    _themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode);
    Get.changeThemeMode(currentThemeMode);
  }
}
