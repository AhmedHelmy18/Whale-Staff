// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LeaveModelAdapter extends TypeAdapter<LeaveModel> {
  @override
  final int typeId = 2;

  @override
  LeaveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LeaveModel(
      id: fields[0] as String,
      employeeId: fields[1] as String,
      startDate: fields[2] as DateTime,
      endDate: fields[3] as DateTime,
      reason: fields[4] as String,
      statusIndex: fields[5] as int,
      isPaid: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LeaveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employeeId)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.reason)
      ..writeByte(5)
      ..write(obj.statusIndex)
      ..writeByte(6)
      ..write(obj.isPaid);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeaveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
