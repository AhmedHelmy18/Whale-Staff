import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whale_staff/main.dart';
import 'package:whale_staff/core/theme/theme_cubit.dart';
import 'package:whale_staff/features/dashboard/presentation/bloc/dashboard_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_cubit.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_cubit.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_cubit.dart';
import 'package:whale_staff/features/employee/presentation/bloc/deduction_cubit.dart';
import 'helpers/test_helper.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    final env = MockEnvironment();
    setScreenSize(tester);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<ThemeCubit>.value(value: env.themeCubit),
          BlocProvider<DashboardCubit>.value(value: env.dashboardCubit),
          BlocProvider<EmployeeCubit>.value(value: env.employeeCubit),
          BlocProvider<SalaryCubit>.value(value: env.salaryCubit),
          BlocProvider<LeaveCubit>.value(value: env.leaveCubit),
          BlocProvider<BonusCubit>.value(value: env.bonusCubit),
          BlocProvider<DeductionCubit>.value(value: env.deductionCubit),
        ],
        child: const WhaleStaffApp(),
      ),
    );

    expect(find.byType(WhaleStaffApp), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
