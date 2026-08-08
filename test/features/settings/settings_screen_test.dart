import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whale_staff/features/settings/presentation/screens/settings_screen.dart';
import '../../helpers/test_helper.dart';

void main() {
  late MockEnvironment env;

  setUp(() {
    env = MockEnvironment();
  });

  testWidgets(
    'SettingsScreen renders successfully and displays dark mode and about tiles',
    (WidgetTester tester) async {
      setScreenSize(tester);
      when(env.themeCubit.state).thenReturn(ThemeMode.light);

      await tester.pumpWidget(env.wrap(const SettingsScreen()));

      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Dark Mode'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
      expect(find.text('Whale Staff HRMS v1.0.0'), findsOneWidget);

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isFalse);
    },
  );

  testWidgets(
    'SettingsScreen displays dark mode switch as checked when ThemeMode is dark',
    (WidgetTester tester) async {
      setScreenSize(tester);
      when(env.themeCubit.state).thenReturn(ThemeMode.dark);

      await tester.pumpWidget(env.wrap(const SettingsScreen()));

      final switchWidget = tester.widget<Switch>(find.byType(Switch));
      expect(switchWidget.value, isTrue);
    },
  );

  testWidgets('Toggling dark mode switch triggers toggleTheme on ThemeCubit', (
    WidgetTester tester,
  ) async {
    setScreenSize(tester);
    when(env.themeCubit.state).thenReturn(ThemeMode.light);

    await tester.pumpWidget(env.wrap(const SettingsScreen()));

    final switchFinder = find.byType(Switch);
    expect(switchFinder, findsOneWidget);
    await tester.tap(switchFinder);
    await tester.pump();

    verify(env.themeCubit.toggleTheme()).called(1);
  });
}
