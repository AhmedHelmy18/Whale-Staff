import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/employee/presentation/screens/employee_list_screen.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();
  });

  testWidgets('EmployeeListScreen shows loading indicator when loading', (
    WidgetTester tester,
  ) async {
    when(env.employeeCubit.state).thenReturn(EmployeeLoading());

    await tester.pumpWidget(env.wrap(const EmployeeListScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('EmployeeListScreen shows error message when error occurs', (
    WidgetTester tester,
  ) async {
    const errorMsg = 'Failed to fetch employees';
    when(env.employeeCubit.state).thenReturn(const EmployeeError(errorMsg));

    await tester.pumpWidget(env.wrap(const EmployeeListScreen()));

    expect(find.textContaining('Error: $errorMsg'), findsOneWidget);
  });

  testWidgets('EmployeeListScreen shows list of employees when loaded', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp1 = createDummyEmployee(
      id: '1',
      name: 'John Doe',
      position: 'Manager',
    );
    final emp2 = createDummyEmployee(
      id: '2',
      name: 'Jane Smith',
      position: 'Developer',
    );

    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp1, emp2], allEmployees: [emp1, emp2]));

    await tester.pumpWidget(env.wrap(const EmployeeListScreen()));

    expect(find.text('John Doe'), findsOneWidget);
    expect(find.text('Jane Smith'), findsOneWidget);
    expect(find.text('Manager'), findsOneWidget);
    expect(find.text('Developer'), findsOneWidget);
  });

  testWidgets('EmployeeListScreen can trigger add employee dialog', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const EmployeeListScreen()));

    final addButton = find.widgetWithText(ElevatedButton, 'Add Employee');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('Add Employee'), findsWidgets);
  });

  testWidgets('EmployeeListScreen can trigger delete employee', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp = createDummyEmployee(id: 'delete_me', name: 'John Doe');
    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));

    await tester.pumpWidget(env.wrap(const EmployeeListScreen()));

    final deleteButton = find.byIcon(Icons.delete_outline);
    expect(deleteButton, findsOneWidget);
    await tester.tap(deleteButton);
    await tester.pump();

    verify(env.employeeCubit.deleteEmployee('delete_me')).called(1);
  });
}
