import 'package:whale_staff/features/employee/domain/repositories/employee_repository.dart';
import 'package:whale_staff/features/salary/domain/entities/salary.dart';
import 'package:whale_staff/features/salary/domain/repositories/salary_repository.dart';

class CalculateSalary {
  final SalaryRepository salaryRepository;
  final EmployeeRepository employeeRepository;

  CalculateSalary(this.salaryRepository, this.employeeRepository);

  Future<Salary> call(String employeeId, {double extraBonus = 0}) async {
    final employee = await employeeRepository.getEmployeeById(employeeId);
    if (employee == null) throw Exception('Employee not found');

    // Business Logic for Salary Calculation
    double finalSalary =
        employee.baseSalary +
        (employee.baseSalary * employee.bonusPercentage / 100) +
        extraBonus;

    final salary = Salary(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      employeeId: employeeId,
      baseSalary: employee.baseSalary,
      bonus:
          (employee.baseSalary * employee.bonusPercentage / 100) + extraBonus,
      deductions: 0, // Logic for deductions can be added here
      finalSalary: finalSalary,
      calculationDate: DateTime.now(),
    );

    await salaryRepository.saveSalary(salary);
    return salary;
  }
}
