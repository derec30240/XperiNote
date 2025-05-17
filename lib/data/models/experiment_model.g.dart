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
      startTime: fields[2] as DateTime,
      status: fields[3] as ExperimentStatus,
      progress: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Experiment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.startTime)
      ..writeByte(3)
      ..write(obj.status)
      ..writeByte(4)
      ..write(obj.progress);
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
        return ExperimentStatus.ongoing;
      case 1:
        return ExperimentStatus.completed;
      default:
        return ExperimentStatus.ongoing;
    }
  }

  @override
  void write(BinaryWriter writer, ExperimentStatus obj) {
    switch (obj) {
      case ExperimentStatus.ongoing:
        writer.writeByte(0);
        break;
      case ExperimentStatus.completed:
        writer.writeByte(1);
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
