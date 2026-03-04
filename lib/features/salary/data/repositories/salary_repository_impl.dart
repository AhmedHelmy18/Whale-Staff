import 'package:hive/hive.dart';
import '../models/salary_model.dart';
import '../../domain/repositories/salary_repository.dart';
import '../../domain/entities/salary.dart';

class SalaryRepositoryImpl implements SalaryRepository {
  static const String boxName = 'salaries';

  @override
  Future<List<Salary>> getSalaryHistory(String employeeId) async {
    final box = await Hive.openBox<SalaryModel>(boxName);
    return box.values.where((s) => s.employeeId == employeeId).toList();
  }

  @override
  Future<void> saveSalary(Salary salary) async {
    final box = await Hive.openBox<SalaryModel>(boxName);
    await box.put(salary.id, SalaryModel.fromEntity(salary));
  }

  @override
  Future<Salary?> getLatestSalary(String employeeId) async {
    final box = await Hive.openBox<SalaryModel>(boxName);
    final history = box.values
        .where((s) => s.employeeId == employeeId)
        .toList();
    if (history.isEmpty) return null;
    history.sort((a, b) => b.calculationDate.compareTo(a.calculationDate));
    return history.first;
  }
}
