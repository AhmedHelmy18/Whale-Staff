import 'package:equatable/equatable.dart';
import '../../domain/entities/employee.dart';

abstract class EmployeeState extends Equatable {
  const EmployeeState();
  @override
  List<Object?> get props => [];
}

class EmployeeInitial extends EmployeeState {}

class EmployeeLoading extends EmployeeState {}

class EmployeeLoaded extends EmployeeState {
  final List<Employee> employees;
  final List<Employee> allEmployees;
  final String? _searchQuery;

  String get searchQuery => _searchQuery ?? '';

  const EmployeeLoaded(
    this.employees, {
    this.allEmployees = const [],
    String searchQuery = '',
  }) : _searchQuery = searchQuery;

  @override
  List<Object?> get props => [employees, allEmployees, searchQuery];
}

class EmployeeError extends EmployeeState {
  final String message;
  const EmployeeError(this.message);
  @override
  List<Object?> get props => [message];
}

class EmployeeOperationSuccess extends EmployeeState {}
