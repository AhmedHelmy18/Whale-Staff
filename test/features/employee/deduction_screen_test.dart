import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/employee/presentation/screens/deduction_screen.dart';
import 'package:whale_staff/features/employee/presentation/bloc/deduction_state.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();
  });

  testWidgets('DeductionScreen shows loading indicator when loading', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(env.deductionCubit.state).thenReturn(DeductionLoading());
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const DeductionScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('DeductionScreen shows empty state/SizedBox when error occurs', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(
      env.deductionCubit.state,
    ).thenReturn(const DeductionError('Error loading deductions'));
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const DeductionScreen()));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(DataTable), findsNothing);
  });

  testWidgets('DeductionScreen lists deductions when loaded', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp = createDummyEmployee(id: 'emp_b', name: 'Bob Johnson');
    final deduction = createDummyDeduction(
      id: 'deduction_1',
      employeeId: 'emp_b',
      amount: 120.0,
      reason: 'Late Check-in',
    );

    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
    when(
      env.deductionCubit.state,
    ).thenReturn(DeductionLoaded([deduction], allDeductions: [deduction]));

    await tester.pumpWidget(env.wrap(const DeductionScreen()));

    expect(find.text('Bob Johnson'), findsOneWidget);
    expect(find.text('-\$120.00'), findsOneWidget);
    expect(find.text('Late Check-in'), findsOneWidget);
  });

  testWidgets('DeductionScreen opens Add Deduction dialog', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));
    when(
      env.deductionCubit.state,
    ).thenReturn(const DeductionLoaded([], allDeductions: []));

    await tester.pumpWidget(env.wrap(const DeductionScreen()));

    final addButton = find.widgetWithText(ElevatedButton, 'Add Deduction');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('Add Deduction'), findsWidgets);
  });

  testWidgets(
    'DeductionScreen triggers removeDeduction when delete is tapped',
    (WidgetTester tester) async {
      setScreenSize(tester);
      final emp = createDummyEmployee(id: 'emp_b', name: 'Bob Johnson');
      final deduction = createDummyDeduction(
        id: 'deduction_to_delete',
        employeeId: 'emp_b',
        amount: 120.0,
        reason: 'Late Check-in',
      );

      when(
        env.employeeCubit.state,
      ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
      when(
        env.deductionCubit.state,
      ).thenReturn(DeductionLoaded([deduction], allDeductions: [deduction]));

      await tester.pumpWidget(env.wrap(const DeductionScreen()));

      final deleteButton = find.byIcon(Icons.delete_outline);
      expect(deleteButton, findsOneWidget);
      await tester.tap(deleteButton);
      await tester.pump();

      verify(
        env.deductionCubit.removeDeduction('deduction_to_delete'),
      ).called(1);
    },
  );
}
