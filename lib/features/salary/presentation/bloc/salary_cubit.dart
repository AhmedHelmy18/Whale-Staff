import 'package:flutter_bloc/flutter_bloc.dart';
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
      );
      emit(SalaryCalculated(salary));
    } catch (e) {
      emit(SalaryError(e.toString()));
    }
  }
}
