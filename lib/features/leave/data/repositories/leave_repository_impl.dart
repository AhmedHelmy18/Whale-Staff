import 'package:hive/hive.dart';
import '../models/leave_model.dart';
import '../../domain/repositories/leave_repository.dart';
import '../../domain/entities/leave.dart';

class LeaveRepositoryImpl implements LeaveRepository {
  static const String boxName = 'leaves';

  @override
  Future<void> applyLeave(Leave leave) async {
    final box = await Hive.openBox<LeaveModel>(boxName);
    await box.put(leave.id, LeaveModel.fromEntity(leave));
  }

  @override
  Future<void> deleteLeave(String id) async {
    final box = await Hive.openBox<LeaveModel>(boxName);
    await box.delete(id);
  }

  @override
  Future<List<Leave>> getAllLeaves() async {
    final box = await Hive.openBox<LeaveModel>(boxName);
    return box.values.toList();
  }

  @override
  Future<List<Leave>> getLeaves(String employeeId) async {
    final box = await Hive.openBox<LeaveModel>(boxName);
    return box.values.where((l) => l.employeeId == employeeId).toList();
  }

  @override
  Future<void> updateLeaveStatus(String id, LeaveStatus status) async {
    final box = await Hive.openBox<LeaveModel>(boxName);
    final model = box.get(id);
    if (model != null) {
      final updated = LeaveModel(
        id: model.id,
        employeeId: model.employeeId,
        startDate: model.startDate,
        endDate: model.endDate,
        reason: model.reason,
        statusIndex: status.index,
        isPaid: model.isPaid,
      );
      await box.put(id, updated);
    }
  }
}
