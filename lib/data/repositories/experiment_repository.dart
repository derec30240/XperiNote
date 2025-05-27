// experiment_repository.dart
// 实验数据仓库接口与 Hive 实现，负责实验数据的持久化与操作
// 提供实验的增删查改、批量删除等功能，并定义相关异常

import 'package:hive/hive.dart';
import 'package:xperinote/data/models/experiment_model.dart';

/// 实验数据仓库抽象接口
///
/// 统一定义实验数据的增删查改等操作，便于扩展不同存储实现
abstract class ExperimentRepository {
  /// 获取所有实验列表
  Future<List<Experiment>> getAllExperiments();

  /// 根据 id 获取单个实验
  Future<Experiment?> getExperimentById(String id);

  /// 添加实验
  Future<void> addExperiment(Experiment experiment);

  /// 更新指定 id 的实验
  Future<void> updateExperiment(String id, Experiment experiment);

  /// 删除指定 id 的实验
  Future<void> deleteExperiment(String id);

  /// 批量删除实验
  Future<void> deleteExperiments(List<String> ids);
}

/// Hive 实现的实验数据仓库
///
/// 通过 Hive 进行本地持久化存储，实现所有接口方法
class HiveExperimentRepository implements ExperimentRepository {
  /// Hive 实验数据盒子
  final Box<Experiment> _experimentBox;

  /// 构造函数，获取名为 'experimentBox' 的 Hive 盒子
  HiveExperimentRepository()
    : _experimentBox = Hive.box<Experiment>('experimentBox');

  @override
  Future<List<Experiment>> getAllExperiments() async {
    try {
      // 返回所有实验对象列表
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
    // 先检查实验是否存在
    final exist = await getExperimentById(id);
    final update = Experiment(
      id: exist!.id,
      title: experiment.title,
      description: experiment.description,
      createAt: experiment.createAt,
      startAt: experiment.startAt,
      lastModifiedAt: DateTime.now(),
      status: experiment.status,
      steps: experiment.steps,
      history: experiment.history,
      data: experiment.data,
      tags: experiment.tags,
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
    // 检查所有 id 是否存在，若有不存在则抛出异常
    for (String id in ids) {
      if (!_experimentBox.containsKey(id)) {
        throw ExperimentNotFoundException(id);
      }
    }
    await _experimentBox.deleteAll(ids);
  }
}

/// 实验数据仓库通用异常
class ExperimentRepositoryException implements Exception {
  final String message;
  ExperimentRepositoryException(this.message);
}

/// 未找到指定实验时抛出的异常
class ExperimentNotFoundException extends ExperimentRepositoryException {
  ExperimentNotFoundException(String id) : super('未找到ID为 $id 的实验');
}
