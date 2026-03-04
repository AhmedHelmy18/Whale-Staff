import '../entities/leave.dart';

abstract class LeaveRepository {
  Future<List<Leave>> getLeaves(String employeeId);
  Future<List<Leave>> getAllLeaves();
  Future<void> applyLeave(Leave leave);
  Future<void> updateLeaveStatus(String id, LeaveStatus status);
  Future<void> deleteLeave(String id);
}
