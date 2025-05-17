import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:xperinote/data/models/experiment_model.dart';

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
