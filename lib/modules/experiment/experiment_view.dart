import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xperinote/data/controllers/experiment_controller.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/modules/experiment/widgets/experiment_card.dart';

class ExperimentView extends GetView<ExperimentController> {
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
          bottom: TabBar(tabs: const [Tab(text: '进行中'), Tab(text: '已完成')]),
        ),
        body: Obx(() => _buildContent()),
      ),
    );
  }

  Widget _buildContent() {
    return switch (controller.status) {
      AsyncStatus.loading => const Center(child: CircularProgressIndicator()),
      AsyncStatus.success => TabBarView(
        children: [
          _buildExperimentList(controller.ongoingExperiments),
          _buildExperimentList(controller.completedExperiments),
        ],
      ),
      AsyncStatus.error => _buildErrorState(),
    };
  }

  Widget _buildExperimentList(List<Experiment> experiments) {
    if (experiments.isEmpty) {
      return const Center(child: Text('没有实验'));
    }
    return ListView.builder(
      itemCount: experiments.length,
      itemBuilder: (context, index) {
        return ExperimentCard(experiment: experiments[index]);
      },
    );
  }

  Widget _buildErrorState() {
    return const Center(child: Text('数据加载失败'));
  }
}
