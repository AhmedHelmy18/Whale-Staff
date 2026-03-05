import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/domain/entities/deduction.dart';
import 'package:whale_staff/features/employee/domain/repositories/deduction_repository.dart';
import 'deduction_state.dart';

class DeductionCubit extends Cubit<DeductionState> {
  final DeductionRepository repository;

  List<Deduction> _allDeductions = [];

  DeductionCubit(this.repository) : super(DeductionInitial());

  Future<void> loadDeductions() async {
    emit(DeductionLoading());
    try {
      _allDeductions = await repository.getEmployeeDeductions('');
      emit(DeductionLoaded(_allDeductions, allDeductions: _allDeductions));
    } catch (e) {
      emit(DeductionError(e.toString()));
    }
  }

  void searchDeductions(String query, Map<String, String> employeeNames) {
    if (state is DeductionLoaded) {
      if (query.isEmpty) {
        emit(DeductionLoaded(_allDeductions, allDeductions: _allDeductions));
      } else {
        final filtered = _allDeductions.where((deduction) {
          final searchLower = query.toLowerCase();
          final employeeName = (employeeNames[deduction.employeeId] ?? '')
              .toLowerCase();
          return deduction.reason.toLowerCase().contains(searchLower) ||
              employeeName.contains(searchLower) ||
              deduction.amount.toString().contains(searchLower);
        }).toList();
        emit(
          DeductionLoaded(
            filtered,
            allDeductions: _allDeductions,
            searchQuery: query,
          ),
        );
      }
    }
  }

  Future<void> addDeduction(Deduction deduction) async {
    try {
      await repository.addDeduction(deduction);
      await loadDeductions();
    } catch (e) {
      emit(DeductionError(e.toString()));
    }
  }

  Future<void> removeDeduction(String id) async {
    try {
      await repository.deleteDeduction(id);
      await loadDeductions();
    } catch (e) {
      emit(DeductionError(e.toString()));
    }
  }
}
