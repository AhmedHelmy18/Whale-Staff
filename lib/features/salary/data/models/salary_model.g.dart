// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salary_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalaryModelAdapter extends TypeAdapter<SalaryModel> {
  @override
  final int typeId = 1;

  @override
  SalaryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalaryModel(
      id: fields[0] as String,
      employeeId: fields[1] as String,
      baseSalary: fields[2] as double,
      bonus: fields[3] as double,
      deductions: fields[4] as double,
      finalSalary: fields[5] as double,
      calculationDate: fields[6] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SalaryModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.employeeId)
      ..writeByte(2)
      ..write(obj.baseSalary)
      ..writeByte(3)
      ..write(obj.bonus)
      ..writeByte(4)
      ..write(obj.deductions)
      ..writeByte(5)
      ..write(obj.finalSalary)
      ..writeByte(6)
      ..write(obj.calculationDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalaryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
