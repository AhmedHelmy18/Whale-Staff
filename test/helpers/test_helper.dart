import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/core/theme/theme_cubit.dart';
import 'package:whale_staff/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:whale_staff/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:whale_staff/features/employee/domain/entities/employee.dart';
import 'package:whale_staff/features/employee/domain/entities/bonus.dart';
import 'package:whale_staff/features/employee/domain/entities/deduction.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_state.dart';
import 'package:whale_staff/features/employee/presentation/bloc/deduction_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/deduction_state.dart';
import 'package:whale_staff/features/leave/domain/entities/leave.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_cubit.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_state.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_cubit.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_state.dart';
import 'package:whale_staff/features/salary/domain/entities/salary.dart';
import 'mock_generator.mocks.dart';

Employee createDummyEmployee({
  String id = '1',
  String name = 'John Doe',
  String email = 'john@example.com',
  String phone = '1234567890',
  String position = 'Developer',
  double baseSalary = 5000.0,
  DateTime? hireDate,
  DateTime? birthday,
  double bonusPercentage = 10.0,
}) {
  return Employee(
    id: id,
    name: name,
    email: email,
    phone: phone,
    position: position,
    baseSalary: baseSalary,
    hireDate: hireDate ?? DateTime(2020, 1, 1),
    birthday: birthday ?? DateTime(1990, 5, 15),
    bonusPercentage: bonusPercentage,
  );
}

Leave createDummyLeave({
  String id = '1',
  String employeeId = '1',
  DateTime? startDate,
  DateTime? endDate,
  String reason = 'Vacation',
  LeaveStatus status = LeaveStatus.pending,
  bool isPaid = false,
}) {
  return Leave(
    id: id,
    employeeId: employeeId,
    startDate: startDate ?? DateTime.now(),
    endDate: endDate ?? DateTime.now().add(const Duration(days: 2)),
    reason: reason,
    status: status,
    isPaid: isPaid,
  );
}

Bonus createDummyBonus({
  String id = '1',
  String employeeId = '1',
  double amount = 500.0,
  String reason = 'Performance',
  DateTime? date,
}) {
  return Bonus(
    id: id,
    employeeId: employeeId,
    amount: amount,
    reason: reason,
    date: date ?? DateTime.now(),
  );
}

Deduction createDummyDeduction({
  String id = '1',
  String employeeId = '1',
  double amount = 200.0,
  String reason = 'Late',
  DateTime? date,
}) {
  return Deduction(
    id: id,
    employeeId: employeeId,
    amount: amount,
    reason: reason,
    date: date ?? DateTime.now(),
  );
}

Salary createDummySalary({
  String id = '1',
  String employeeId = '1',
  double baseSalary = 5000.0,
  double bonus = 500.0,
  double deductions = 200.0,
  double finalSalary = 5300.0,
  DateTime? calculationDate,
}) {
  return Salary(
    id: id,
    employeeId: employeeId,
    baseSalary: baseSalary,
    bonus: bonus,
    deductions: deductions,
    finalSalary: finalSalary,
    calculationDate: calculationDate ?? DateTime.now(),
  );
}

class MockEnvironment {
  final themeCubit = MockThemeCubit();
  final dashboardCubit = MockDashboardCubit();
  final employeeCubit = MockEmployeeCubit();
  final salaryCubit = MockSalaryCubit();
  final leaveCubit = MockLeaveCubit();
  final bonusCubit = MockBonusCubit();
  final deductionCubit = MockDeductionCubit();
  final calculateSalary = MockCalculateSalary();
  final salaryRepository = MockSalaryRepository();

  MockEnvironment() {
    when(themeCubit.state).thenReturn(ThemeMode.light);
    when(themeCubit.stream).thenAnswer((_) => Stream.value(themeCubit.state));
    when(themeCubit.close()).thenAnswer((_) => Future.value());

    when(dashboardCubit.state).thenReturn(DashboardInitial());
    when(
      dashboardCubit.stream,
    ).thenAnswer((_) => Stream.value(dashboardCubit.state));
    when(dashboardCubit.close()).thenAnswer((_) => Future.value());

    when(employeeCubit.state).thenReturn(EmployeeInitial());
    when(
      employeeCubit.stream,
    ).thenAnswer((_) => Stream.value(employeeCubit.state));
    when(employeeCubit.close()).thenAnswer((_) => Future.value());

    when(salaryCubit.state).thenReturn(SalaryInitial());
    when(salaryCubit.stream).thenAnswer((_) => Stream.value(salaryCubit.state));
    when(salaryCubit.close()).thenAnswer((_) => Future.value());
    when(salaryCubit.calculateSalaryUseCase).thenReturn(calculateSalary);

    when(leaveCubit.state).thenReturn(LeaveInitial());
    when(leaveCubit.stream).thenAnswer((_) => Stream.value(leaveCubit.state));
    when(leaveCubit.close()).thenAnswer((_) => Future.value());

    when(bonusCubit.state).thenReturn(BonusInitial());
    when(bonusCubit.stream).thenAnswer((_) => Stream.value(bonusCubit.state));
    when(bonusCubit.close()).thenAnswer((_) => Future.value());

    when(deductionCubit.state).thenReturn(DeductionInitial());
    when(
      deductionCubit.stream,
    ).thenAnswer((_) => Stream.value(deductionCubit.state));
    when(deductionCubit.close()).thenAnswer((_) => Future.value());

    when(calculateSalary.salaryRepository).thenReturn(salaryRepository);
  }

  Widget wrap(Widget child) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: themeCubit),
        BlocProvider<DashboardCubit>.value(value: dashboardCubit),
        BlocProvider<EmployeeCubit>.value(value: employeeCubit),
        BlocProvider<SalaryCubit>.value(value: salaryCubit),
        BlocProvider<LeaveCubit>.value(value: leaveCubit),
        BlocProvider<BonusCubit>.value(value: bonusCubit),
        BlocProvider<DeductionCubit>.value(value: deductionCubit),
      ],
      child: MaterialApp(
        builder: (context, widget) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(disableAnimations: true),
            child: widget!,
          );
        },
        home: Scaffold(body: child),
      ),
    );
  }
}

void setScreenSize(
  WidgetTester tester, {
  double width = 1200,
  double height = 800,
}) {
  final view = tester.view;
  view.physicalSize = Size(width, height);
  view.devicePixelRatio = 1.0;
  tester.binding.addPostFrameCallback((_) {});
  addTearDown(() {
    view.resetPhysicalSize();
    view.resetDevicePixelRatio();
  });
}
