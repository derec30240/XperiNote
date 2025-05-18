import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:intl/intl.dart';
import 'package:xperinote/data/models/experiment_model.dart';
import 'package:xperinote/data/controllers/experiment_controller.dart';

class SelectableExperimentCard extends StatelessWidget {
  final Experiment experiment;

  const SelectableExperimentCard({super.key, required this.experiment});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExperimentController>();

    return Obx(() {
      final isSelected = controller.selectedIds.contains(experiment.id);

      return GestureDetector(
        onLongPress: () {
          if (!controller.isSelectionMode.value) {
            controller.isSelectionMode.value = true;
            controller.toggleSelection(experiment.id);
          }
        },
        onTap: () {
          if (controller.isSelectionMode.value) {
            controller.toggleSelection(experiment.id);
          } else {
            // Navigate to detail page
          }
        },
        child: Stack(
          children: [
            ExperimentCard(experiment: experiment),
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

class ExperimentCard extends StatelessWidget {
  const ExperimentCard({super.key, required this.experiment});

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
                Text(
                  experiment.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                _buildStatusIndicator(context),
              ],
            ),
            const SizedBox(height: 8.0),
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
                Text(
                  '开始时间: ${DateFormat('yyyy-MM-dd HH:mm').format(experiment.createAt)}',
                ),
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

  void _navigateToDetail(BuildContext context) {
    // Implement navigation to experiment detail page
  }
}
