// ignore_for_file: overridden_fields
import 'package:hive/hive.dart';
import 'package:whale_staff/features/salary/domain/entities/salary.dart';

part 'salary_model.g.dart';

@HiveType(typeId: 1)
class SalaryModel extends Salary {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String employeeId;
  @override
  @HiveField(2)
  final double baseSalary;
  @override
  @HiveField(3)
  final double bonus;
  @override
  @HiveField(4)
  final double deductions;
  @override
  @HiveField(5)
  final double finalSalary;
  @override
  @HiveField(6)
  final DateTime calculationDate;

  const SalaryModel({
    required this.id,
    required this.employeeId,
    required this.baseSalary,
    required this.bonus,
    required this.deductions,
    required this.finalSalary,
    required this.calculationDate,
  }) : super(
         id: id,
         employeeId: employeeId,
         baseSalary: baseSalary,
         bonus: bonus,
         deductions: deductions,
         finalSalary: finalSalary,
         calculationDate: calculationDate,
       );

  factory SalaryModel.fromEntity(Salary salary) {
    return SalaryModel(
      id: salary.id,
      employeeId: salary.employeeId,
      baseSalary: salary.baseSalary,
      bonus: salary.bonus,
      deductions: salary.deductions,
      finalSalary: salary.finalSalary,
      calculationDate: salary.calculationDate,
    );
  }
}
