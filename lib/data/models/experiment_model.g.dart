// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'experiment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExperimentAdapter extends TypeAdapter<Experiment> {
  @override
  final int typeId = 1;

  @override
  Experiment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Experiment(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String?,
      createAt: fields[3] as DateTime,
      startAt: fields[4] as DateTime?,
      lastModifiedAt: fields[5] as DateTime,
      status: fields[6] as ExperimentStatus,
      steps: (fields[7] as List?)?.cast<ExperimentStep>(),
      history: (fields[8] as List?)?.cast<ExperimentHistory>(),
      data: fields[9] as ExperimentData?,
      tags: (fields[10] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, Experiment obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.createAt)
      ..writeByte(4)
      ..write(obj.startAt)
      ..writeByte(5)
      ..write(obj.lastModifiedAt)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.steps)
      ..writeByte(8)
      ..write(obj.history)
      ..writeByte(9)
      ..write(obj.data)
      ..writeByte(10)
      ..write(obj.tags);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperimentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ExperimentStatusAdapter extends TypeAdapter<ExperimentStatus> {
  @override
  final int typeId = 2;

  @override
  ExperimentStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ExperimentStatus.draft;
      case 1:
        return ExperimentStatus.ongoing;
      case 2:
        return ExperimentStatus.paused;
      case 3:
        return ExperimentStatus.completed;
      default:
        return ExperimentStatus.draft;
    }
  }

  @override
  void write(BinaryWriter writer, ExperimentStatus obj) {
    switch (obj) {
      case ExperimentStatus.draft:
        writer.writeByte(0);
        break;
      case ExperimentStatus.ongoing:
        writer.writeByte(1);
        break;
      case ExperimentStatus.paused:
        writer.writeByte(2);
        break;
      case ExperimentStatus.completed:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExperimentStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
