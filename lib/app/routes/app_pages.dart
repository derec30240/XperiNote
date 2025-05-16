import 'package:get/get.dart';
import 'package:xperinote/app/layout/main_navigation_wrapper.dart';
import 'package:xperinote/modules/about/about_view.dart';
import 'package:xperinote/modules/community/community_view.dart';
import 'package:xperinote/modules/experiment/experiment_view.dart';
import 'package:xperinote/modules/settings/settings_view.dart';
import 'package:xperinote/modules/template/template_view.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.home;

  static final pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => MainNavigationWrapper(),
      participatesInRootNavigator: true, // 标记为根路由
    ),
    GetPage(
      name: AppRoutes.experiment,
      page: () => ExperimentView(),
    ),
    GetPage(
      name: AppRoutes.template,
      page: () => TemplateView(),
    ),
    GetPage(
      name: AppRoutes.community,
      page: () => CommunityView(),
    ),
    GetPage(
      name: AppRoutes.settings,
      page: () => SettingsView(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutView(),
    ),
  ];
}
