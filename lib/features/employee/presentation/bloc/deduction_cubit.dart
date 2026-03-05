import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/employee/domain/entities/deduction.dart';
import 'package:whale_staff/features/employee/domain/repositories/deduction_repository.dart';
import 'deduction_state.dart';

class DeductionCubit extends Cubit<DeductionState> {
  final DeductionRepository repository;

  DeductionCubit(this.repository) : super(DeductionInitial());

  Future<void> loadDeductions() async {
    emit(DeductionLoading());
    try {
      final deductions = await repository.getEmployeeDeductions('');
      emit(DeductionLoaded(deductions));
    } catch (e) {
      emit(DeductionError(e.toString()));
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
