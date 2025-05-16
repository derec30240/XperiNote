import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xperinote/app/routes/app_routes.dart';
import 'package:xperinote/app/widgets/custom_app_bar.dart';
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
      appBar: CustomAppBar(title: '研记'),
      drawer: _buildDrawer(context),
      drawerEnableOpenDragGesture: Get.currentRoute == AppRoutes.home,
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.science), label: '实验'),
          BottomNavigationBarItem(icon: Icon(Icons.library_books), label: '模板'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '社区'),
        ],
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
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
