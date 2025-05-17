import 'package:flutter/material.dart';

class ExperimentView extends StatelessWidget {
  const ExperimentView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
          title: Text('实验'),
          bottom: TabBar(
            tabs: const [
              Tab(text: '进行中'),
              Tab(text: '已完成'),
            ],
          ),
        ),
        body: TabBarView(
          children: const [
            Center(child: Text('进行中内容')),
            Center(child: Text('已完成内容')),
          ],
        ),
      ),
    );
  }
}
