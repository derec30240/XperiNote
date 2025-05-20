// app_pages.dart
// 路由页面配置文件，集中管理应用所有页面的路由映射
// 采用 GetX 路由管理，支持主导航、实验、模板、社区、设置、关于等页面

import 'package:get/get.dart';
import 'package:xperinote/app/layout/main_navigation_wrapper.dart';
import 'package:xperinote/modules/about/about_view.dart';
import 'package:xperinote/modules/community/community_view.dart';
import 'package:xperinote/modules/experiment/experiment_view.dart';
import 'package:xperinote/modules/settings/settings_view.dart';
import 'package:xperinote/modules/template/template_view.dart';

import 'app_routes.dart';

/// AppPages 负责集中管理所有页面的路由配置
///
/// - [initial]：应用启动时的初始路由
/// - [pages]：所有页面的路由映射列表
class AppPages {
  /// 应用初始路由（首页）
  static const initial = AppRoutes.home;

  /// 所有页面的路由配置
  ///
  /// 包含主导航包装页、实验、模板、社区、设置、关于等页面
  static final pages = [
    // 主导航包装页，作为根路由
    GetPage(
      name: AppRoutes.home,
      page: () => MainNavigationWrapper(),
      participatesInRootNavigator: true, // 标记为根路由
    ),
    // 实验页面
    GetPage(name: AppRoutes.experiment, page: () => ExperimentView()),
    // 模板页面
    GetPage(name: AppRoutes.template, page: () => TemplateView()),
    // 社区页面
    GetPage(name: AppRoutes.community, page: () => CommunityView()),
    // 设置页面
    GetPage(name: AppRoutes.settings, page: () => SettingsView()),
    // 关于页面
    GetPage(name: AppRoutes.about, page: () => const AboutView()),
  ];
}
