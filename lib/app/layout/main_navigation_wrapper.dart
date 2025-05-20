// main_navigation_wrapper.dart
// 主导航包装组件，负责底部导航栏与侧边抽屉的集成与页面切换逻辑
// 包含实验、模板、社区三个主页面，并提供设置和关于页面的入口

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xperinote/app/routes/app_routes.dart';
import 'package:xperinote/modules/community/community_view.dart';
import 'package:xperinote/modules/experiment/experiment_view.dart';
import 'package:xperinote/modules/template/template_view.dart';

/// 主导航包装组件
///
/// 负责集成底部导航栏、侧边抽屉，并根据选中项切换主页面。
/// 支持页面切换、侧边栏导航（设置、关于）等功能。
class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

/// 主导航包装组件的状态类
class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  /// 当前选中的底部导航索引
  int _selectedIndex = 0;

  /// 主页面列表：实验、模板、社区
  static final List<Widget> _pages = [
    ExperimentView(),
    TemplateView(),
    CommunityView(),
  ];

  /// 底部导航栏点击事件，切换页面
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// 构建侧边抽屉，包含用户信息、设置和关于入口
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              '研究员',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            accountEmail: Text(
              'researcher@example.com',
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                'R',
                style: TextStyle(fontSize: 40.0, color: Colors.blue),
              ),
            ),
          ),
          // 设置入口
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: () => Get.toNamed(AppRoutes.settings),
          ),
          // 关于入口
          ListTile(
            leading: Icon(Icons.info),
            title: Text('关于'),
            onTap: () => Get.toNamed(AppRoutes.about),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 侧边抽屉，仅在首页可拖拽打开
      drawer: _buildDrawer(context),
      drawerEnableOpenDragGesture: Get.currentRoute == AppRoutes.home,
      // 主体内容，使用 IndexedStack 保持页面状态
      body: IndexedStack(index: _selectedIndex, children: _pages),
      // 底部导航栏
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.science_outlined),
            label: '实验',
            selectedIcon: Icon(Icons.science),
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books_outlined),
            label: '模板',
            selectedIcon: Icon(Icons.library_books),
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outlined),
            label: '社区',
            selectedIcon: Icon(Icons.people),
          ),
        ],
      ),
    );
  }
}
