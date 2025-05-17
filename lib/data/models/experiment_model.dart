import 'package:hive/hive.dart';
part 'experiment_model.g.dart';

@HiveType(typeId: 1)
class Experiment {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime startTime;

  @HiveField(3)
  final ExperimentStatus status;

  @HiveField(4)
  final int progress;

  Experiment({
    required this.id,
    required this.title,
    required this.startTime,
    this.status = ExperimentStatus.ongoing,
    this.progress = 0,
  });
}

@HiveType(typeId: 2)
enum ExperimentStatus {
  @HiveField(0)
  ongoing,
  @HiveField(1)
  completed,
}
