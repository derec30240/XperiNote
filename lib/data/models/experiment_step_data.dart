import 'package:hive/hive.dart';
part 'experiment_step_data.g.dart';

/// 数据记录抽象基类
///
/// 所有实验步骤数据类型的基类，包含类型标识和记录时间。
abstract class DataRecord {
  /// 数据类型（如 numeric, text, bool, datetime, file, composite）
  final String type;

  /// 记录时间
  final DateTime recordAt;

  /// 构造函数
  /// - [type] 数据类型
  /// - [recordAt] 记录时间
  DataRecord({required this.type, required this.recordAt});
}

/// 实验步骤数据模型
///
/// 记录某一步骤下的所有数据项。
@HiveType(typeId: 6)
class ExperimentStepData {
  /// 步骤数据唯一标识
  @HiveField(0)
  final String id;

  /// 数据记录表，key 为字段名，value 为数据记录
  @HiveField(1)
  final Map<String, DataRecord> records;

  /// 构造函数
  ///
  /// - [id] 步骤数据唯一标识
  /// - [records] 数据记录表
  ExperimentStepData({required this.id, required this.records});
}

/// 数值型数据记录
@HiveType(typeId: 7)
class NumericDataRecord extends DataRecord {
  /// 数值
  @HiveField(2)
  final double value;

  /// 单位
  @HiveField(3)
  final String unit;

  /// 构造函数
  ///
  /// - [value] 数值
  /// - [unit] 单位
  NumericDataRecord({required this.value, required this.unit})
    : super(type: 'numeric', recordAt: DateTime.now());
}

/// 文本型数据记录
@HiveType(typeId: 8)
class TextDataRecord extends DataRecord {
  /// 文本内容
  @HiveField(2)
  final String text;

  /// 构造函数
  ///
  /// - [text] 文本内容
  TextDataRecord({required this.text})
    : super(type: 'text', recordAt: DateTime.now());
}

/// 布尔型数据记录
@HiveType(typeId: 9)
class BoolDataRecord extends DataRecord {
  /// 布尔值
  @HiveField(2)
  final bool value;

  /// 构造函数
  ///
  /// - [value] 布尔值
  BoolDataRecord({required this.value})
    : super(type: 'bool', recordAt: DateTime.now());
}

/// 日期时间型数据记录
@HiveType(typeId: 10)
class DateTimeDataRecord extends DataRecord {
  /// 日期时间
  @HiveField(2)
  final DateTime dateTime;

  /// 构造函数
  ///
  /// - [dateTime] 日期时间
  DateTimeDataRecord({required this.dateTime})
    : super(type: 'datetime', recordAt: DateTime.now());
}

/// 文件型数据记录
@HiveType(typeId: 11)
class FileDataRecord extends DataRecord {
  /// 文件路径
  @HiveField(2)
  final String filePath;

  /// 文件类型
  @HiveField(3)
  final String fileType;

  /// 构造函数
  ///
  /// - [filePath] 文件路径
  /// - [fileType] 文件类型
  FileDataRecord({required this.filePath, required this.fileType})
    : super(type: 'file', recordAt: DateTime.now());
}

/// 复合型数据记录（嵌套结构）
@HiveType(typeId: 12)
class CompositeDataRecord extends DataRecord {
  /// 子数据项，key 为字段名，value 为数据记录
  @HiveField(2)
  final Map<String, DataRecord> children;

  /// 构造函数
  ///
  /// - [children] 子数据项
  CompositeDataRecord({required this.children})
    : super(type: 'composite', recordAt: DateTime.now());
}
