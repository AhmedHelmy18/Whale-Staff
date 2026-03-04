import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider_windows/path_provider_windows.dart';
import 'package:whale_staff/core/theme/app_theme.dart';
import 'package:whale_staff/core/theme/theme_cubit.dart';
import 'package:whale_staff/core/theme/hive_service.dart';
import 'package:whale_staff/features/employee/data/repositories/employee_repository_impl.dart';
import 'package:whale_staff/features/employee/domain/use_cases/employee_use_cases.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/salary/data/repositories/salary_repository_impl.dart';
import 'package:whale_staff/features/salary/domain/use_cases/calculate_salary.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_cubit.dart';
import 'package:whale_staff/features/leave/data/repositories/leave_repository_impl.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_cubit.dart';
import 'package:whale_staff/features/dashboard/presentation/screens/main_shell.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    PathProviderWindows.registerWith();
  }
  await HiveService.init();

  // Repositories
  final employeeRepo = EmployeeRepositoryImpl();
  final salaryRepo = SalaryRepositoryImpl();
  final leaveRepo = LeaveRepositoryImpl();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(
          create: (context) => EmployeeCubit(
            getEmployeesUseCase: GetEmployees(employeeRepo),
            addEmployeeUseCase: AddEmployee(employeeRepo),
            updateEmployeeUseCase: UpdateEmployee(employeeRepo),
            deleteEmployeeUseCase: DeleteEmployee(employeeRepo),
          )..loadEmployees(),
        ),
        BlocProvider(
          create: (context) => SalaryCubit(
            calculateSalaryUseCase: CalculateSalary(salaryRepo, employeeRepo),
          ),
        ),
        BlocProvider(
          create: (context) =>
              LeaveCubit(leaveRepository: leaveRepo)..loadAllLeaves(),
        ),
      ],
      child: const WhaleStaffApp(),
    ),
  );
}

class WhaleStaffApp extends StatelessWidget {
  const WhaleStaffApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          title: 'Whale Staff',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          home: const MainShell(),
        );
      },
    );
  }
}
