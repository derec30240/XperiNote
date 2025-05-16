import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xperinote/app/theme/app_theme.dart';

class SettingsController extends GetxController {
  final Rx<MaterialColor> _primaryColor = Colors.blue.obs;
  final RxString _themeMode = 'system'.obs;

  MaterialColor get primaryColor => _primaryColor.value;
  String get themeMode => _themeMode.value;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final colorValue = prefs.getInt('primaryColor') ?? Colors.blue.toARGB32();
    _primaryColor.value = AppTheme.presetColors.firstWhere(
      (color) => color.toARGB32() == colorValue,
      orElse: () => Colors.blue,
    );
    _themeMode.value = prefs.getString('themeMode') ?? 'system';
  }

  void updatePrimaryColor(MaterialColor color) async {
    _primaryColor.value = color;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('primaryColor', color.toARGB32());
  }

  void updateThemeMode(String mode) async {
    _themeMode.value = mode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', mode);
    Get.changeThemeMode(currentThemeMode);
  }

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
}
