// app_theme.dart
// 应用主题配置文件，集中管理主题色、亮色/暗色主题等全局样式设置
// 提供主题色预设、亮色主题和暗色主题的生成方法

import 'package:flutter/material.dart';

/// AppTheme 负责应用全局主题的配置与生成
///
/// 包含主题色预设列表、亮色主题和暗色主题的生成方法，
/// 支持根据主色调动态生成主题。
class AppTheme {
  /// 主题色预设列表，供用户选择
  static final List<MaterialColor> presetColors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.cyan,
  ];

  /// 生成亮色主题
  /// 
  /// - [primaryColor] ：主题主色调
  static ThemeData lightTheme(MaterialColor primaryColor) {
    return ThemeData.light().copyWith(
      // 使用主色调生成色板
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    );
  }

  /// 生成暗色主题
  /// 
  /// - [primaryColor] ：主题主色调
  static ThemeData darkTheme(MaterialColor primaryColor) {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
