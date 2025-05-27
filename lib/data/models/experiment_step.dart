import 'package:hive/hive.dart';
import 'package:xperinote/data/models/attachment_model.dart';
import 'package:xperinote/data/models/experiment_step_data.dart'
    show ExperimentStepData;
part 'experiment_step.g.dart';

/// 实验步骤数据模型
///
/// 记录实验的单个步骤，包括标题、描述、顺序、时间、数据和附件。
@HiveType(typeId: 3)
class ExperimentStep {
  /// 步骤唯一标识
  @HiveField(0)
  final String id;

  /// 步骤标题
  @HiveField(1)
  final String title;

  /// 步骤描述，可选
  @HiveField(2)
  final String? description;

  /// 步骤顺序（从 0 开始）
  @HiveField(3)
  final int order;

  /// 步骤开始时间，可选
  @HiveField(4)
  final DateTime? startAt;

  /// 步骤结束时间，可选
  @HiveField(5)
  final DateTime? endAt;

  /// 步骤是否已完成
  @HiveField(6)
  final bool isCompleted;

  /// 步骤数据
  @HiveField(7)
  final ExperimentStepData? data;

  /// 步骤附件列表
  @HiveField(8)
  final List<Attachment>? attachments;

  /// 构造函数
  ///
  /// - [id] 步骤唯一标识
  /// - [title] 步骤标题
  /// - [description] 步骤描述
  /// - [order] 步骤顺序
  /// - [startAt] 步骤开始时间
  /// - [endAt] 步骤结束时间
  /// - [isCompleted] 是否完成
  /// - [data] 步骤数据
  /// - [attachments] 附件列表
  ExperimentStep({
    required this.id,
    required this.title,
    this.description,
    required this.order,
    this.startAt,
    this.endAt,
    this.isCompleted = false,
    this.data,
    this.attachments,
  });
}
