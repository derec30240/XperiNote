import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xperinote/app/routes/app_routes.dart';
import 'package:xperinote/modules/community/community_view.dart';
import 'package:xperinote/modules/experiment/experiment_view.dart';
import 'package:xperinote/modules/template/template_view.dart';

class MainNavigationWrapper extends StatefulWidget {
  const MainNavigationWrapper({super.key});

  @override
  State<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends State<MainNavigationWrapper> {
  int _selectedIndex = 0;
  static final List<Widget> _pages = [
    ExperimentView(),
    TemplateView(),
    CommunityView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('设置'),
            onTap: () => Get.toNamed(AppRoutes.settings),
          ),
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
      drawer: _buildDrawer(context),
      drawerEnableOpenDragGesture: Get.currentRoute == AppRoutes.home,
      body: IndexedStack(index: _selectedIndex, children: _pages),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating action button press
        },
        tooltip: '新建记录',
        child: Icon(Icons.add),
      ),
    );
  }
}
