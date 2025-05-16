import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xperinote/app/routes/app_routes.dart';

class CustomAppBar extends AppBar {
  static Widget? _buildLeading() {
    // 仅在根路由显示菜单按钮
    if (Get.currentRoute == AppRoutes.home) {
      return Builder(
        builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          );
        },
      );
    }
    // 其他路由显示返回按钮
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Get.back(),
    );
  }

  CustomAppBar({required String title, super.key})
    : super(
        title: Text(title),
        leading: _buildLeading(),
        automaticallyImplyLeading: false,
      );
}
