import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/features/salary/domain/entities/salary.dart';
import 'package:whale_staff/features/salary/domain/use_cases/calculate_salary.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_state.dart';

class SalaryCubit extends Cubit<SalaryState> {
  final CalculateSalary calculateSalaryUseCase;

  SalaryCubit({required this.calculateSalaryUseCase}) : super(SalaryInitial());

  Future<void> calculateEmployeeSalary(
    String employeeId, {
    double bonus = 0,
  }) async {
    emit(SalaryLoading());
    try {
      final salary = await calculateSalaryUseCase(
        employeeId,
        extraBonus: bonus,
        shouldSave: false, // Don't save yet, wait for confirmation
      );
      emit(SalaryCalculated(salary));
    } catch (e) {
      emit(SalaryError(e.toString()));
    }
  }

  Future<void> saveSalary(Salary salary) async {
    try {
      await calculateSalaryUseCase.salaryRepository.saveSalary(salary);
      // We could emit a "Saved" state or just keep the current state
    } catch (e) {
      emit(SalaryError(e.toString()));
    }
  }
}
