import 'package:hive/hive.dart';
import '../models/employee_model.dart';
import '../../domain/repositories/employee_repository.dart';
import '../../domain/entities/employee.dart';

class EmployeeRepositoryImpl implements EmployeeRepository {
  static const String boxName = 'employees';

  @override
  Future<void> addEmployee(Employee employee) async {
    final box = await Hive.openBox<EmployeeModel>(boxName);
    await box.put(employee.id, EmployeeModel.fromEntity(employee));
  }

  @override
  Future<void> deleteEmployee(String id) async {
    final box = await Hive.openBox<EmployeeModel>(boxName);
    await box.delete(id);
  }

  @override
  Future<Employee?> getEmployeeById(String id) async {
    final box = await Hive.openBox<EmployeeModel>(boxName);
    return box.get(id);
  }

  @override
  Future<List<Employee>> getEmployees() async {
    final box = await Hive.openBox<EmployeeModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<void> updateEmployee(Employee employee) async {
    final box = await Hive.openBox<EmployeeModel>(boxName);
    await box.put(employee.id, EmployeeModel.fromEntity(employee));
  }
}
