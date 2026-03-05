import 'package:equatable/equatable.dart';
import '../../domain/entities/leave.dart';

abstract class LeaveState extends Equatable {
  const LeaveState();
  @override
  List<Object?> get props => [];
}

class LeaveInitial extends LeaveState {}

class LeaveLoading extends LeaveState {}

class LeaveLoaded extends LeaveState {
  final List<Leave> leaves;
  final List<Leave> allLeaves;
  final String searchQuery;

  const LeaveLoaded(
    this.leaves, {
    this.allLeaves = const [],
    this.searchQuery = '',
  });

  @override
  List<Object?> get props => [leaves, allLeaves, searchQuery];
}

class LeaveError extends LeaveState {
  final String message;
  const LeaveError(this.message);
  @override
  List<Object?> get props => [message];
}
