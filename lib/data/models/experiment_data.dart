import 'package:hive/hive.dart';
import 'package:xperinote/data/models/experiment_step_data.dart'
    show ExperimentStepData;
part 'experiment_data.g.dart';

/// 实验数据汇总模型
///
/// 记录实验的所有步骤数据，便于整体数据管理与持久化。
@HiveType(typeId: 13)
class ExperimentData {
  /// 实验数据唯一标识
  @HiveField(0)
  final String id;

  /// 所有步骤的数据记录列表
  @HiveField(1)
  final List<ExperimentStepData> records;

  /// 构造函数
  /// [id] 数据唯一标识
  /// [records] 步骤数据记录列表
  ExperimentData({required this.id, required this.records});
}
