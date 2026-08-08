import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/report/presentation/screens/report_screen.dart';
import 'package:whale_staff/features/employee/presentation/bloc/employee_state.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();

    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('file_saver'), (
          MethodCall methodCall,
        ) async {
          if (methodCall.method == 'saveFile') {
            return 'mocked_file_path';
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(const MethodChannel('file_saver'), null);
  });

  testWidgets('ReportScreen renders successfully and shows report cards', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(
      env.employeeCubit.state,
    ).thenReturn(const EmployeeLoaded([], allEmployees: []));

    await tester.pumpWidget(env.wrap(const ReportScreen()));

    expect(find.text('Reports'), findsOneWidget);
    expect(find.text('Employee List'), findsOneWidget);
    expect(find.text('Salary Report'), findsOneWidget);
  });

  testWidgets(
    'Tapping Employee List card exports employees and shows success toast',
    (WidgetTester tester) async {
      setScreenSize(tester);
      final emp = createDummyEmployee(id: 'emp_x', name: 'Charlie Green');

      when(
        env.employeeCubit.state,
      ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));

      await tester.pumpWidget(env.wrap(const ReportScreen()));

      final employeeCard = find.text('Employee List');
      await tester.tap(employeeCard);

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();

      expect(find.text('Employee list exported successfully'), findsNothing);
    },
  );

  testWidgets(
    'Tapping Salary Report card shows info toast if no salaries exist',
    (WidgetTester tester) async {
      setScreenSize(tester);
      final emp = createDummyEmployee(id: 'emp_x', name: 'Charlie Green');

      when(
        env.employeeCubit.state,
      ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
      when(
        env.salaryRepository.getAllSalaries(),
      ).thenAnswer((_) => Future.value([]));

      await tester.pumpWidget(env.wrap(const ReportScreen()));

      final salaryCard = find.text('Salary Report');
      await tester.tap(salaryCard);
      await tester.pump();

      await tester.pump(const Duration(milliseconds: 100));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();

      expect(
        find.text(
          'No salaries found to export. Please calculate and save some salaries first.',
        ),
        findsNothing,
      );
    },
  );

  testWidgets(
    'Tapping Salary Report card exports salaries and shows success toast when salaries exist',
    (WidgetTester tester) async {
      setScreenSize(tester);
      final emp = createDummyEmployee(id: 'emp_x', name: 'Charlie Green');
      final sal = createDummySalary(id: 'sal_1', employeeId: 'emp_x');

      when(
        env.employeeCubit.state,
      ).thenReturn(EmployeeLoaded([emp], allEmployees: [emp]));
      when(
        env.salaryRepository.getAllSalaries(),
      ).thenAnswer((_) => Future.value([sal]));

      await tester.pumpWidget(env.wrap(const ReportScreen()));

      final salaryCard = find.text('Salary Report');
      await tester.tap(salaryCard);
      await tester.pump();

      await tester.pump(const Duration(milliseconds: 100));

      await tester.pump();
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pump();

      expect(find.text('Salary report exported successfully'), findsNothing);
    },
  );
}
