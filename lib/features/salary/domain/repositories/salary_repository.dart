import '../entities/salary.dart';

abstract class SalaryRepository {
  Future<List<Salary>> getSalaryHistory(String employeeId);
  Future<void> saveSalary(Salary salary);
  Future<Salary?> getLatestSalary(String employeeId);
}
