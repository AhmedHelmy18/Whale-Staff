// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bonus_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BonusModelAdapter extends TypeAdapter<BonusModel> {
  @override
  final int typeId = 3;

  @override
  BonusModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BonusModel(
      id: fields[0] as String,
      employeeId: fields[1] as String,
      amount: fields[2] as double,
      reason: fields[3] as String,
      date: fields[4] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BonusModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employeeId)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.reason)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BonusModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
