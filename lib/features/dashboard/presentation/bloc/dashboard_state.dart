import 'package:equatable/equatable.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';
import 'package:whale_staff/features/leave/domain/entities/leave.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final int totalEmployees;
  final int activeLeavesToday;
  final double totalMonthlyPayroll;
  final List<Employee> upcomingBirthdays;
  final List<Leave> recentLeaves;
  final Map<String, double> salaryByPosition;

  const DashboardLoaded({
    required this.totalEmployees,
    required this.activeLeavesToday,
    required this.totalMonthlyPayroll,
    required this.upcomingBirthdays,
    required this.recentLeaves,
    required this.salaryByPosition,
  });

  @override
  List<Object?> get props => [
    totalEmployees,
    activeLeavesToday,
    totalMonthlyPayroll,
    upcomingBirthdays,
    recentLeaves,
    salaryByPosition,
  ];
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
