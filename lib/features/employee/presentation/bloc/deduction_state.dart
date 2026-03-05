import 'package:equatable/equatable.dart';
import 'package:whale_staff/features/employee/domain/entities/deduction.dart';

abstract class DeductionState extends Equatable {
  const DeductionState();

  @override
  List<Object?> get props => [];
}

class DeductionInitial extends DeductionState {}

class DeductionLoading extends DeductionState {}

class DeductionLoaded extends DeductionState {
  final List<Deduction> deductions;

  const DeductionLoaded(this.deductions);

  @override
  List<Object?> get props => [deductions];
}

class DeductionError extends DeductionState {
  final String message;

  const DeductionError(this.message);

  @override
  List<Object?> get props => [message];
}
