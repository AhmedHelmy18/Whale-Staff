import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String position;
  final double baseSalary;
  final DateTime hireDate;
  final DateTime? birthday;
  final double bonusPercentage;

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.position,
    required this.baseSalary,
    required this.hireDate,
    this.birthday,
    required this.bonusPercentage,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    phone,
    position,
    baseSalary,
    hireDate,
    birthday,
    bonusPercentage,
  ];
}
