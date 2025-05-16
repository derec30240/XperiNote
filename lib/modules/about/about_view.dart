import 'package:flutter/material.dart';
import 'package:xperinote/app/widgets/custom_app_bar.dart';

class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: '关于'),
      body: Center(
        child: Text('About'),
      ),
    );
  }
}
