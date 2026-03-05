import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/leave.dart';
import '../../domain/repositories/leave_repository.dart';
import 'leave_state.dart';

class LeaveCubit extends Cubit<LeaveState> {
  final LeaveRepository leaveRepository;

  LeaveCubit({required this.leaveRepository}) : super(LeaveInitial());

  Future<void> loadLeaves(String employeeId) async {
    emit(LeaveLoading());
    try {
      final leaves = await leaveRepository.getLeaves(employeeId);
      emit(LeaveLoaded(leaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  Future<void> loadAllLeaves() async {
    emit(LeaveLoading());
    try {
      final leaves = await leaveRepository.getAllLeaves();
      emit(LeaveLoaded(leaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  Future<void> applyLeave(Leave leave) async {
    emit(LeaveLoading());
    try {
      await leaveRepository.applyLeave(leave);
      await loadAllLeaves();
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  Future<void> updateLeaveStatus(String id, LeaveStatus status) async {
    emit(LeaveLoading());
    try {
      await leaveRepository.updateLeaveStatus(id, status);
      await loadAllLeaves();
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }
}
