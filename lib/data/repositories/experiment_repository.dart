import 'package:hive/hive.dart';
import 'package:xperinote/data/models/experiment_model.dart';

abstract class ExperimentRepository {
  Future<List<Experiment>> getAllExperiments();
  Future<Experiment?> getExperimentById(String id);
  Future<void> addExperiment(Experiment experiment);
  Future<void> updateExperiment(String id, Experiment experiment);
  Future<void> deleteExperiment(String id);
  Future<void> deleteExperiments(List<String> ids);
}

class HiveExperimentRepository implements ExperimentRepository {
  final Box<Experiment> _experimentBox;
  HiveExperimentRepository()
    : _experimentBox = Hive.box<Experiment>('experimentBox');

  @override
  Future<List<Experiment>> getAllExperiments() async {
    try {
      return _experimentBox.values.toList();
    } on HiveError catch (e) {
      throw Exception('获取实验列表失败: $e');
    }
  }

  @override
  Future<Experiment?> getExperimentById(String id) async {
    final experiment = _experimentBox.get(id);
    if (experiment == null) {
      throw ExperimentNotFoundException(id);
    }
    return experiment;
  }

  @override
  Future<void> addExperiment(Experiment experiment) async {
    await _experimentBox.put(experiment.id, experiment);
  }

  @override
  Future<void> updateExperiment(String id, Experiment experiment) async {
    final exist = await getExperimentById(id);
    final update = Experiment(
      id: exist!.id,
      title: experiment.title,
      createAt: experiment.createAt,
      status: experiment.status,
      progress: experiment.progress,
    );
    await _experimentBox.put(id, update);
  }

  @override
  Future<void> deleteExperiment(String id) async {
    if (!_experimentBox.containsKey(id)) {
      throw ExperimentNotFoundException(id);
    }
    await _experimentBox.delete(id);
  }

  @override
  Future<void> deleteExperiments(List<String> ids) async {
    for (String id in ids) {
      if (!_experimentBox.containsKey(id)) {
        throw ExperimentNotFoundException(id);
      }
    }
    await _experimentBox.deleteAll(ids);
  }
}

class ExperimentRepositoryException implements Exception {
  final String message;
  ExperimentRepositoryException(this.message);
}

class ExperimentNotFoundException extends ExperimentRepositoryException {
  ExperimentNotFoundException(String id) : super('未找到ID为 $id 的实验');
}
