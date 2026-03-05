import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';
import 'package:whale_staff/features/employee/domain/use_cases/employee_use_cases.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final GetEmployees getEmployeesUseCase;
  final AddEmployee addEmployeeUseCase;
  final UpdateEmployee updateEmployeeUseCase;
  final DeleteEmployee deleteEmployeeUseCase;

  List<Employee> _allEmployees = [];

  EmployeeCubit({
    required this.getEmployeesUseCase,
    required this.addEmployeeUseCase,
    required this.updateEmployeeUseCase,
    required this.deleteEmployeeUseCase,
  }) : super(EmployeeInitial());

  Future<void> loadEmployees() async {
    emit(EmployeeLoading());
    try {
      _allEmployees = await getEmployeesUseCase();
      emit(EmployeeLoaded(_allEmployees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  void searchEmployees(String query) {
    if (state is EmployeeLoaded) {
      if (query.isEmpty) {
        emit(EmployeeLoaded(_allEmployees));
      } else {
        final filtered = _allEmployees.where((employee) {
          final searchLower = query.toLowerCase();
          return employee.name.toLowerCase().contains(searchLower) ||
              employee.email.toLowerCase().contains(searchLower) ||
              employee.position.toLowerCase().contains(searchLower);
        }).toList();
        emit(EmployeeLoaded(filtered, searchQuery: query));
      }
    }
  }

  Future<void> addEmployee(Employee employee) async {
    emit(EmployeeLoading());
    try {
      await addEmployeeUseCase(employee);
      await loadEmployees();
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  Future<void> updateEmployee(Employee employee) async {
    emit(EmployeeLoading());
    try {
      await updateEmployeeUseCase(employee);
      await loadEmployees();
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  Future<void> deleteEmployee(String id) async {
    emit(EmployeeLoading());
    try {
      await deleteEmployeeUseCase(id);
      await loadEmployees();
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }
}
