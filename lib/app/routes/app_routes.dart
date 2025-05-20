// app_routes.dart
// 路由常量定义文件，集中管理所有页面的路由路径，便于统一维护和调用

/// AppRoutes 用于集中定义应用内所有页面的路由路径常量。
///
/// 通过静态常量字符串，保证路由命名统一、易于维护和重构。
abstract class AppRoutes {
  /// 首页（主导航包装页）
  static const String home = '/';
  /// 实验页面
  static const String experiment = '/experiment';
  /// 模板页面
  static const String template = '/template';
  /// 社区页面
  static const String community = '/community';
  /// 设置页面
  static const String settings = '/settings';
  /// 关于页面
  static const String about = '/about';
}
