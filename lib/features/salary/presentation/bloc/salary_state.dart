import 'package:equatable/equatable.dart';
import '../../domain/entities/salary.dart';

abstract class SalaryState extends Equatable {
  const SalaryState();
  @override
  List<Object?> get props => [];
}

class SalaryInitial extends SalaryState {}

class SalaryLoading extends SalaryState {}

class SalaryLoaded extends SalaryState {
  final List<Salary> salaries;
  const SalaryLoaded(this.salaries);
  @override
  List<Object?> get props => [salaries];
}

class SalaryCalculated extends SalaryState {
  final Salary salary;
  const SalaryCalculated(this.salary);
  @override
  List<Object?> get props => [salary];
}

class SalaryError extends SalaryState {
  final String message;
  const SalaryError(this.message);
  @override
  List<Object?> get props => [message];
}
