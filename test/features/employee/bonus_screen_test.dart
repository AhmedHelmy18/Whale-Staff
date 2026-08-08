import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/employee/presentation/screens/bonus_screen.dart';
import 'package:whale_staff/features/employee/presentation/bloc/bonus_state.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();
  });

  testWidgets('BonusScreen shows loading indicator when loading', (
    WidgetTester tester,
  ) async {
    when(env.bonusCubit.state).thenReturn(BonusLoading());
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const BonusScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('BonusScreen shows empty state/SizedBox when error occurs', (
    WidgetTester tester,
  ) async {
    when(
      env.bonusCubit.state,
    ).thenReturn(const BonusError('Error loading bonuses'));
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const BonusScreen()));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(DataTable), findsNothing);
  });

  testWidgets('BonusScreen lists bonuses when loaded', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp = createDummyEmployee(id: 'emp_a', name: 'Alice Miller');
    final bonus = createDummyBonus(
      id: 'bonus_1',
      employeeId: 'emp_a',
      amount: 450.0,
      reason: 'Sales Target achieved',
    );

    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
    when(
      env.bonusCubit.state,
    ).thenReturn(BonusLoaded([bonus], allBonuses: [bonus]));

    await tester.pumpWidget(env.wrap(const BonusScreen()));

    expect(find.text('Alice Miller'), findsOneWidget);
    expect(find.text('\$450.00'), findsOneWidget);
    expect(find.text('Sales Target achieved'), findsOneWidget);
  });

  testWidgets('BonusScreen opens Add Bonus dialog', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));
    when(
      env.bonusCubit.state,
    ).thenReturn(const BonusLoaded([], allBonuses: []));

    await tester.pumpWidget(env.wrap(const BonusScreen()));

    final addButton = find.widgetWithText(ElevatedButton, 'Add Bonus');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('Add Bonus'), findsWidgets);
  });

  testWidgets('BonusScreen triggers removeBonus when delete is tapped', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp = createDummyEmployee(id: 'emp_a', name: 'Alice Miller');
    final bonus = createDummyBonus(
      id: 'bonus_to_delete',
      employeeId: 'emp_a',
      amount: 450.0,
      reason: 'Sales Target achieved',
    );

    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
    when(
      env.bonusCubit.state,
    ).thenReturn(BonusLoaded([bonus], allBonuses: [bonus]));

    await tester.pumpWidget(env.wrap(const BonusScreen()));

    final deleteButton = find.byIcon(Icons.delete_outline);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pump();

    verify(env.bonusCubit.removeBonus('bonus_to_delete')).called(1);
  });
}
