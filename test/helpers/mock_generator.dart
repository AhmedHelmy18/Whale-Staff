import 'package:mockito/annotations.dart';
import 'package:whale_staff/core/theme/theme_cubit.dart';
import 'package:whale_staff/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_cubit.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/deduction_cubit.dart';
import 'package:whale_staff/features/salary/domain/repositories/salary_repository.dart';
import 'package:whale_staff/features/salary/domain/use_cases/calculate_salary.dart';

@GenerateMocks([
  ThemeCubit,
  DashboardCubit,
  EmployeeCubit,
  SalaryCubit,
  LeaveCubit,
  BonusCubit,
  DeductionCubit,
  SalaryRepository,
  CalculateSalary,
])
void main() {}
