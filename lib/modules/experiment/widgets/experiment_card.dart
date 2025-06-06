// experiment_card.dart
// 实验卡片组件，支持单选/多选操作与实验信息展示
// 包含可选卡片与实验信息卡片两部分，适配实验列表的交互与展示需求

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/data/controllers/experiment_controller.dart';

/// 可选实验卡片组件
///
/// 支持长按进入多选模式，点击切换选中状态，
/// 多选时右上角显示复选框。
class SelectableExperimentCard extends StatelessWidget {
  /// 当前实验对象
  final Experiment experiment;

  const SelectableExperimentCard({super.key, required this.experiment});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExperimentController>();

    return Obx(() {
      // 判断当前实验是否被选中
      final isSelected = controller.selectedIds.contains(experiment.id);

      return GestureDetector(
        // 长按进入多选模式并选中当前卡片
        onLongPress: () {
          if (!controller.isSelectionMode.value) {
            controller.isSelectionMode.value = true;
            controller.toggleSelection(experiment.id);
          }
        },
        // 点击：多选模式下切换选中，否则预留跳转详情
        onTap: () {
          if (controller.isSelectionMode.value) {
            controller.toggleSelection(experiment.id);
          } else {
            // Navigate to detail page
          }
        },
        child: Stack(
          children: [
            // 实验信息卡片
            ExperimentCard(experiment: experiment),
            // 多选模式下显示复选框
            if (controller.isSelectionMode.value)
              Positioned(
                top: 12.0,
                right: 12.0,
                child: Checkbox(
                  value: isSelected,
                  onChanged: (_) => controller.toggleSelection(experiment.id),
                ),
              ),
          ],
        ),
      );
    });
  }
}

/// 实验信息卡片组件
///
/// 展示实验标题、状态、进度、创建时间等信息，
/// 并支持点击跳转到实验详情页（待实现）。
class ExperimentCard extends StatelessWidget {
  const ExperimentCard({super.key, required this.experiment});

  /// 当前实验对象
  final Experiment experiment;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 实验标题
                Text(
                  experiment.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                _buildStatusIndicator(context),
              ],
            ),
            const SizedBox(height: 8.0),
            // 实验进度条
            LinearProgressIndicator(
              value: experiment.progress / 100,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(4.0),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 实验创建时间
                Text(
                  '开始时间: ${DateFormat('yyyy-MM-dd HH:mm').format(experiment.createAt)}',
                ),
                // 跳转详情按钮（待实现）
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () => _navigateToDetail(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 构建实验状态指示器
  Widget _buildStatusIndicator(BuildContext context) {
    return Chip(
      avatar: Icon(
        experiment.status == ExperimentStatus.ongoing
            ? Icons.access_time
            : Icons.check_circle,
      ),
      label: Text(experiment.status.name.toUpperCase()),
      backgroundColor:
          experiment.status == ExperimentStatus.ongoing
              ? Theme.of(context).colorScheme.secondaryContainer
              : Theme.of(context).colorScheme.tertiaryContainer,
    );
  }

  /// 跳转到实验详情页（待实现）
  void _navigateToDetail(BuildContext context) {
    // Implement navigation to experiment detail page
  }
}
