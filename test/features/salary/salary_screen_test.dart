import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/salary/presentation/screens/salary_screen.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import 'package:whale_staff/features/salary/presentation/bloc/salary_state.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();
  });

  testWidgets('SalaryScreen shows default text when no salary is calculated', (
    WidgetTester tester,
  ) async {
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));
    when(env.salaryCubit.state).thenReturn(SalaryInitial());

    await tester.pumpWidget(env.wrap(const SalaryScreen()));

    expect(
      find.text('Select an employee to view salary calculation'),
      findsOneWidget,
    );
  });

  testWidgets('SalaryScreen taps employee to trigger salary calculation', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp = createDummyEmployee(id: 'emp_123', name: 'Bob Jones');
    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
    when(env.salaryCubit.state).thenReturn(SalaryInitial());

    await tester.pumpWidget(env.wrap(const SalaryScreen()));

    final listTile = find.text('Bob Jones');
    expect(listTile, findsOneWidget);
    await tester.tap(listTile);
    await tester.pump();

    verify(env.salaryCubit.calculateEmployeeSalary('emp_123')).called(1);
  });

  testWidgets('SalaryScreen displays breakdown when salary is calculated', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp = createDummyEmployee(id: 'emp_123', name: 'Bob Jones');
    final salary = createDummySalary(
      employeeId: 'emp_123',
      baseSalary: 6000.0,
      bonus: 800.0,
      deductions: 300.0,
      finalSalary: 6500.0,
    );

    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
    when(env.salaryCubit.state).thenReturn(SalaryCalculated(salary));

    await tester.pumpWidget(env.wrap(const SalaryScreen()));

    expect(find.text('Salary Breakdown'), findsOneWidget);
    expect(find.text('\$6000.00'), findsOneWidget);
    expect(find.text('\$800.00'), findsOneWidget);
    expect(find.text('-\$300.00'), findsOneWidget);
    expect(find.text('\$6500.00'), findsOneWidget);

    final saveButton = find.widgetWithText(ElevatedButton, 'Confirm & Save');
    expect(saveButton, findsOneWidget);
    await tester.tap(saveButton);

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pump();

    verify(env.salaryCubit.saveSalary(salary)).called(1);
  });
}
