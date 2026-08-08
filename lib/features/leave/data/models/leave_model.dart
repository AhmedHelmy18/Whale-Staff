import 'package:hive/hive.dart';
import 'package:whale_staff/features/leave/domain/entities/leave.dart';

part 'leave_model.g.dart';

@HiveType(typeId: 2)
class LeaveModel extends Leave {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  final String employeeId;
  @override
  @HiveField(2)
  final DateTime startDate;
  @override
  @HiveField(3)
  final DateTime endDate;
  @override
  @HiveField(4)
  final String reason;
  @HiveField(5)
  final int statusIndex;
  @override
  @HiveField(6)
  final bool isPaid;

  LeaveModel({
    required this.id,
    required this.employeeId,
    required this.startDate,
    required this.endDate,
    required this.reason,
    required this.statusIndex,
    this.isPaid = false,
  }) : super(
         id: id,
         employeeId: employeeId,
         startDate: startDate,
         endDate: endDate,
         reason: reason,
         status: LeaveStatus.values[statusIndex],
         isPaid: isPaid,
       );

  factory LeaveModel.fromEntity(Leave leave) {
    return LeaveModel(
      id: leave.id,
      employeeId: leave.employeeId,
      startDate: leave.startDate,
      endDate: leave.endDate,
      reason: leave.reason,
      statusIndex: leave.status.index,
      isPaid: leave.isPaid,
    );
  }
}
