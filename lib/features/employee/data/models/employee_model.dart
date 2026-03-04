// ignore_for_file: overridden_fields
import 'package:hive/hive.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends Employee {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String name;
  @override
  @HiveField(2)
  final String email;
  @override
  @HiveField(3)
  final String phone;
  @override
  @HiveField(4)
  final String position;
  @override
  @HiveField(5)
  final double baseSalary;
  @override
  @HiveField(6)
  final DateTime hireDate;
  @override
  @HiveField(7)
  final DateTime? birthday;
  @override
  @HiveField(8)
  final double bonusPercentage;

  const EmployeeModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.position,
    required this.baseSalary,
    required this.hireDate,
    this.birthday,
    required this.bonusPercentage,
  }) : super(
         id: id,
         name: name,
         email: email,
         phone: phone,
         position: position,
         baseSalary: baseSalary,
         hireDate: hireDate,
         birthday: birthday,
         bonusPercentage: bonusPercentage,
       );

  factory EmployeeModel.fromEntity(Employee employee) {
    return EmployeeModel(
      id: employee.id,
      name: employee.name,
      email: employee.email,
      phone: employee.phone,
      position: employee.position,
      baseSalary: employee.baseSalary,
      hireDate: employee.hireDate,
      birthday: employee.birthday,
      bonusPercentage: employee.bonusPercentage,
    );
  }
}
