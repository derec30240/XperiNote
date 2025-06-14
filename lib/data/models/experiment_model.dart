// experiment_model.dart
// 实验数据模型，定义实验对象及其状态的结构和 Hive 持久化配置
// 支持实验的唯一标识、标题、创建时间、状态、进度等属性

import 'package:hive/hive.dart';
import 'package:xperinote/data/models/experiment_data.dart';
import 'package:xperinote/data/models/experiment_history.dart';
import 'package:xperinote/data/models/experiment_step.dart';
part 'experiment_model.g.dart';

/// 实验对象的数据模型
///
/// 通过 HiveType 进行持久化，包含实验的唯一 id、标题、描述、创建时间、状态、步骤、历史、数据等属性。
@HiveType(typeId: 1)
class Experiment {
  /// 实验唯一标识
  @HiveField(0)
  final String id;

  /// 实验标题
  @HiveField(1)
  final String title;

  /// 实验描述，可选
  @HiveField(2)
  final String? description;

  /// 实验创建时间
  @HiveField(3)
  final DateTime createAt;

  /// 实验开始时间，可选
  @HiveField(4)
  final DateTime? startAt;

  /// 实验最后编辑时间
  @HiveField(5)
  final DateTime lastModifiedAt;

  /// 实验当前状态（草稿/进行中/暂停/已完成）
  @HiveField(6)
  final ExperimentStatus status;

  /// 实验步骤列表
  @HiveField(7)
  final List<ExperimentStep>? steps;

  /// 实验历史记录列表
  @HiveField(8)
  final List<ExperimentHistory>? history;

  /// 实验数据汇总
  @HiveField(9)
  final ExperimentData? data;

  /// 实验标签列表
  @HiveField(10)
  final List<String>? tags;

  /// 构造函数，默认状态为 draft，步骤为空
  ///
  /// - [id] 实验唯一标识
  /// - [title] 实验标题
  /// - [description] 实验描述
  /// - [createAt] 创建时间
  /// - [startAt] 开始时间
  /// - [lastModifiedAt] 最后编辑时间
  /// - [status] 实验状态，默认为 draft
  /// - [steps] 实验步骤
  /// - [history] 实验历史
  /// - [data] 实验数据
  /// - [tags] 实验标签
  Experiment({
    required this.id,
    required this.title,
    this.description,
    required this.createAt,
    this.startAt,
    required this.lastModifiedAt,
    this.status = ExperimentStatus.draft,
    this.steps,
    this.history,
    this.data,
    this.tags,
  });

  Experiment copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createAt,
    DateTime? startAt,
    DateTime? lastModifiedAt,
    ExperimentStatus? status,
    List<ExperimentStep>? steps,
    List<ExperimentHistory>? history,
    ExperimentData? data,
    List<String>? tags,
  }) {
    return Experiment(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createAt: createAt ?? this.createAt,
      startAt: startAt ?? this.startAt,
      lastModifiedAt: lastModifiedAt ?? this.lastModifiedAt,
      status: status ?? this.status,
      steps: steps ?? this.steps,
      history: history ?? this.history,
      data: data ?? this.data,
      tags: tags ?? this.tags,
    );
  }
}

/// 实验状态枚举
///
/// draft: 草稿，ongoing: 进行中，paused: 暂停，completed: 已完成
@HiveType(typeId: 2)
enum ExperimentStatus {
  /// 草稿
  @HiveField(0)
  draft,

  /// 进行中
  @HiveField(1)
  ongoing,

  /// 暂停
  @HiveField(2)
  paused,

  /// 已完成
  @HiveField(3)
  completed,
}
