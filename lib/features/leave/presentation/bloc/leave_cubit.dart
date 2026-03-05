import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/leave.dart';
import '../../domain/repositories/leave_repository.dart';
import 'leave_state.dart';

class LeaveCubit extends Cubit<LeaveState> {
  final LeaveRepository leaveRepository;

  List<Leave> _allLeaves = [];

  LeaveCubit({required this.leaveRepository}) : super(LeaveInitial());

  Future<void> loadLeaves(String employeeId) async {
    emit(LeaveLoading());
    try {
      final leaves = await leaveRepository.getLeaves(employeeId);
      emit(LeaveLoaded(leaves, allLeaves: leaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  Future<void> loadAllLeaves() async {
    emit(LeaveLoading());
    try {
      _allLeaves = await leaveRepository.getAllLeaves();
      emit(LeaveLoaded(_allLeaves, allLeaves: _allLeaves));
    } catch (e) {
      emit(LeaveError(e.toString()));
    }
  }

  void searchLeaves(String query, Map<String, String> employeeNames) {
    if (state is LeaveLoaded) {
      if (query.isEmpty) {
        emit(LeaveLoaded(_allLeaves, allLeaves: _allLeaves));
      } else {
        final filtered = _allLeaves.where((leave) {
          final searchLower = query.toLowerCase();
          final employeeName = (employeeNames[leave.employeeId] ?? '')
              .toLowerCase();
          return leave.reason.toLowerCase().contains(searchLower) ||
              employeeName.contains(searchLower) ||
              leave.status.name.toLowerCase().contains(searchLower);
        }).toList();
        emit(LeaveLoaded(filtered, allLeaves: _allLeaves, searchQuery: query));
      }
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
