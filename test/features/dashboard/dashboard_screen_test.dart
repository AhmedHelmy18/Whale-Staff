import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:whale_staff/features/dashboard/presentation/bloc/dashboard_state.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();
  });

  testWidgets('DashboardScreen shows loading indicator when loading', (
    WidgetTester tester,
  ) async {
    when(env.dashboardCubit.state).thenReturn(DashboardLoading());

    await tester.pumpWidget(env.wrap(const DashboardScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DashboardScreen shows error message when error state occurs', (
    WidgetTester tester,
  ) async {
    const errorMessage = 'Failed to load dashboard data';
    when(
      env.dashboardCubit.state,
    ).thenReturn(const DashboardError(errorMessage));

    await tester.pumpWidget(env.wrap(const DashboardScreen()));

    expect(find.text(errorMessage), findsOneWidget);
  });

  testWidgets('DashboardScreen shows overview details when loaded', (
    WidgetTester tester,
  ) async {
    final birthdayEmployee = createDummyEmployee(
      name: 'Alice Smith',
      birthday: DateTime.now(),
    );
    final recentLeave = createDummyLeave(
      reason: 'Sabbatical',
      startDate: DateTime.now(),
    );

    final loadedState = DashboardLoaded(
      totalEmployees: 15,
      activeLeavesToday: 2,
      totalMonthlyPayroll: 45000.0,
      upcomingBirthdays: [birthdayEmployee],
      recentLeaves: [recentLeave],
      salaryByPosition: const {'Manager': 8000.0, 'Developer': 6000.0},
    );

    when(env.dashboardCubit.state).thenReturn(loadedState);

    await tester.pumpWidget(env.wrap(const DashboardScreen()));

    expect(find.text('Total Employees'), findsOneWidget);
    expect(find.text('15'), findsOneWidget);

    expect(find.text('On Leave (Today)'), findsOneWidget);
    expect(find.text('2'), findsOneWidget);

    expect(find.text('Total Payroll'), findsOneWidget);
    expect(find.text('\$45000'), findsOneWidget);

    expect(find.text('Salary Distribution by Position'), findsOneWidget);
    expect(find.text('Birthday Reminders'), findsOneWidget);
    expect(find.text('Recent Activity'), findsOneWidget);

    expect(find.textContaining('Alice Smith'), findsOneWidget);
    expect(find.textContaining('Leave: Sabbatical'), findsOneWidget);
  });
}
