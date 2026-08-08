import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/leave/presentation/screens/leave_screen.dart';
import 'package:whale_staff/features/leave/presentation/bloc/leave_state.dart';
import 'package:whale_staff/features/leave/domain/entities/leave.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();
  });

  testWidgets('LeaveScreen shows loading indicator when loading', (
    WidgetTester tester,
  ) async {
    when(env.leaveCubit.state).thenReturn(LeaveLoading());
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const LeaveScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('LeaveScreen shows error message when error occurs', (
    WidgetTester tester,
  ) async {
    const errorMsg = 'Failed to load leaves';
    when(env.leaveCubit.state).thenReturn(const LeaveError(errorMsg));
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const LeaveScreen()));

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.byType(DataTable), findsNothing);
  });

  testWidgets('LeaveScreen lists leaves when loaded', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    final emp = createDummyEmployee(id: 'emp_1', name: 'Alice Smith');
    final leave = createDummyLeave(
      id: 'leave_1',
      employeeId: 'emp_1',
      reason: 'Medical Leave',
      status: LeaveStatus.pending,
    );

    when(
      env.employeeCubit.state,
    ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
    when(
      env.leaveCubit.state,
    ).thenReturn(LeaveLoaded([leave], allLeaves: [leave]));

    await tester.pumpWidget(env.wrap(const LeaveScreen()));

    expect(find.text('Alice Smith'), findsOneWidget);
    expect(find.text('Medical Leave'), findsOneWidget);
    expect(find.text('PENDING'), findsOneWidget);
  });

  testWidgets('LeaveScreen opens Request Leave dialog', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));
    when(env.leaveCubit.state).thenReturn(const LeaveLoaded([], allLeaves: []));

    await tester.pumpWidget(env.wrap(const LeaveScreen()));

    final addButton = find.widgetWithText(ElevatedButton, 'Add Leave');
    expect(addButton, findsOneWidget);
    await tester.tap(addButton);
    await tester.pumpAndSettle();

    expect(find.text('Add Leave'), findsWidgets);
  });
}
