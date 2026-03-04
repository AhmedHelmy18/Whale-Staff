import 'package:equatable/equatable.dart';

class Salary extends Equatable {
  final String id;
  final String employeeId;
  final double baseSalary;
  final double bonus;
  final double deductions;
  final double finalSalary;
  final DateTime calculationDate;

  const Salary({
    required this.id,
    required this.employeeId,
    required this.baseSalary,
    required this.bonus,
    required this.deductions,
    required this.finalSalary,
    required this.calculationDate,
  });

  @override
  List<Object?> get props => [
    id,
    employeeId,
    baseSalary,
    bonus,
    deductions,
    finalSalary,
    calculationDate,
  ];
}
