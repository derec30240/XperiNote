// experiment_model.dart
// 实验数据模型，定义实验对象及其状态的结构和 Hive 持久化配置
// 支持实验的唯一标识、标题、创建时间、状态、进度等属性

import 'package:hive/hive.dart';
part 'experiment_model.g.dart';

/// 实验对象的数据模型
///
/// 通过 HiveType 进行持久化，包含实验的唯一 id、标题、创建时间、状态和进度。
@HiveType(typeId: 1)
class Experiment {
  /// 实验唯一标识
  @HiveField(0)
  final String id;

  /// 实验标题
  @HiveField(1)
  final String title;

  /// 实验创建时间
  @HiveField(2)
  final DateTime createAt;

  /// 实验当前状态（进行中/已完成）
  @HiveField(3)
  final ExperimentStatus status;

  /// 实验进度（0-100）
  @HiveField(4)
  final int progress;

  /// 构造函数，默认状态为 ongoing，进度为 0
  Experiment({
    required this.id,
    required this.title,
    required this.createAt,
    this.status = ExperimentStatus.ongoing,
    this.progress = 0,
  });
}

/// 实验状态枚举
/// ongoing: 进行中，completed: 已完成
@HiveType(typeId: 2)
enum ExperimentStatus {
  /// 进行中
  @HiveField(0)
  ongoing,

  /// 已完成
  @HiveField(1)
  completed,
}
