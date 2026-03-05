import '../repositories/employee_repository.dart';
import '../entities/employee.dart';

class AddEmployee {
  final EmployeeRepository repository;
  AddEmployee(this.repository);

  Future<void> call(Employee employee) async {
    return await repository.addEmployee(employee);
  }
}

class GetEmployees {
  final EmployeeRepository repository;
  GetEmployees(this.repository);

  Future<List<Employee>> call() async {
    return await repository.getEmployees();
  }
}

class UpdateEmployee {
  final EmployeeRepository repository;
  UpdateEmployee(this.repository);

  Future<void> call(Employee employee) async {
    return await repository.updateEmployee(employee);
  }
}

class DeleteEmployee {
  final EmployeeRepository repository;
  DeleteEmployee(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteEmployee(id);
  }
}
