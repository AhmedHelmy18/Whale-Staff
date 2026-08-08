import 'package:whale_staff/features/employee/domain/repositories/employee_repository.dart';
import 'package:whale_staff/features/employee/domain/repositories/bonus_repository.dart';
import 'package:whale_staff/features/employee/domain/repositories/deduction_repository.dart';
import 'package:whale_staff/features/salary/domain/entities/salary.dart';
import 'package:whale_staff/features/salary/domain/repositories/salary_repository.dart';

class CalculateSalary {
  final SalaryRepository salaryRepository;
  final EmployeeRepository employeeRepository;
  final BonusRepository bonusRepository;
  final DeductionRepository deductionRepository;

  CalculateSalary(
    this.salaryRepository,
    this.employeeRepository,
    this.bonusRepository,
    this.deductionRepository,
  );

  Future<Salary> call(
    String employeeId, {
    double extraBonus = 0,
    bool shouldSave = true,
  }) async {
    final employee = await employeeRepository.getEmployeeById(employeeId);
    if (employee == null) throw Exception('Employee not found');

    final manualBonuses = await bonusRepository.getEmployeeBonuses(employeeId);
    final totalManualBonus = manualBonuses.fold<double>(
      0,
      (sum, b) => sum + b.amount,
    );

    final manualDeductions = await deductionRepository.getEmployeeDeductions(
      employeeId,
    );
    final totalDeduction = manualDeductions.fold<double>(
      0,
      (sum, d) => sum + d.amount,
    );

    double bonusAmount =
        (employee.baseSalary * employee.bonusPercentage / 100) +
        totalManualBonus +
        extraBonus;

    double finalSalary = employee.baseSalary + bonusAmount - totalDeduction;

    final salary = Salary(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      employeeId: employeeId,
      baseSalary: employee.baseSalary,
      bonus: bonusAmount,
      deductions: totalDeduction,
      finalSalary: finalSalary,
      calculationDate: DateTime.now(),
    );

    if (shouldSave) {
      await salaryRepository.saveSalary(salary);
    }
    return salary;
  }
}
