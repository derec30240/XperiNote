import 'package:hive/hive.dart';
import 'package:xperinote/data/models/experiment_data.dart';
part 'experiment_history.g.dart';

/// 实验历史记录数据模型
///
/// 记录实验的历史执行信息，包括标题、描述、起止时间、时长和数据快照。
@HiveType(typeId: 4)
class ExperimentHistory {
  /// 历史记录唯一标识
  @HiveField(0)
  final String id;

  /// 历史标题
  @HiveField(1)
  final String title;

  /// 历史描述，可选
  @HiveField(2)
  final String? description;

  /// 历史开始时间
  @HiveField(3)
  final DateTime startAt;

  /// 历史结束时间
  @HiveField(4)
  final DateTime endAt;

  /// 历史持续时长
  @HiveField(5)
  final Duration duration;

  /// 历史数据快照
  @HiveField(6)
  final ExperimentData capturedData;

  /// 构造函数
  ///
  /// - [id] 历史唯一标识
  /// - [title] 标题
  /// - [description] 描述
  /// - [startAt] 开始时间
  /// - [endAt] 结束时间
  /// - [duration] 持续时长
  /// - [capturedData] 数据快照
  ExperimentHistory({
    required this.id,
    required this.title,
    this.description,
    required this.startAt,
    required this.endAt,
    required this.duration,
    required this.capturedData,
  });
}
