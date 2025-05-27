import 'package:hive/hive.dart';
part 'attachment_model.g.dart';

/// 附件数据模型
///
/// 用于描述实验相关的文件信息，如图片、文档等。
@HiveType(typeId: 14)
class Attachment {
  /// 文件名
  @HiveField(0)
  final String fileName;

  /// 文件路径
  @HiveField(1)
  final String filePath;

  /// 文件类型（如 jpg, pdf, docx 等）
  @HiveField(2)
  final String fileType;

  /// 构造函数
  ///
  /// - [fileName] 文件名
  /// - [filePath] 文件路径
  /// - [fileType] 文件类型
  Attachment({
    required this.fileName,
    required this.filePath,
    required this.fileType,
  });
}
