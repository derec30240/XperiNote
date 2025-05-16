import 'package:flutter/material.dart';
import 'package:xperinote/app/widgets/custom_app_bar.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '设置'),
      body: Center(
        child: Text('Settings'),
      ),
    );
  }
}
