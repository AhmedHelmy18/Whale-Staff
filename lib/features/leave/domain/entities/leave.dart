import 'package:equatable/equatable.dart';

enum LeaveStatus { pending, approved, rejected }

class Leave extends Equatable {
  final String id;
  final String employeeId;
  final DateTime startDate;
  final DateTime endDate;
  final String reason;
  final LeaveStatus status;
  final bool isPaid;

  const Leave({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.status,
    this.isPaid = false,
  });

  int get durationInDays => endDate.difference(startDate).inDays + 1;

  @override
  List<Object?> get props => [
    id,
    employeeId,
    startDate,
    endDate,
    reason,
    status,
    isPaid,
  ];
}
