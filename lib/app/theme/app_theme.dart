import 'package:flutter/material.dart';

class AppTheme {
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

  static ThemeData lightTheme(MaterialColor primaryColor) {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
    );
  }

  static ThemeData darkTheme(MaterialColor primaryColor) {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        brightness: Brightness.dark,
      ),
    );
  }
}
