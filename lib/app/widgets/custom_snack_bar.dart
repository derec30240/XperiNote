// custom_snack_bar.dart
// 自定义 SnackBar 工具类，统一应用内消息提示的样式与调用方式
// 便于全局调用，支持浮动样式与关闭按钮

import 'package:flutter/material.dart';

/// CustomSnackBar 提供全局静态方法用于显示自定义 SnackBar。
///
/// 通过浮动样式和关闭按钮，提升用户体验。
class CustomSnackBar {
  /// 显示自定义 SnackBar
  /// 
  /// - [context]：上下文
  /// - [message]：提示内容
  static void show(BuildContext context, String message) {
    // 隐藏当前 SnackBar，避免重复堆叠
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating, // 浮动样式
        showCloseIcon: true, // 显示关闭按钮
      ),
    );
  }
}
