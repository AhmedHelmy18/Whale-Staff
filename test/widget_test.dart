import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:whale_staff/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Basic test to verify the app starts
    await tester.pumpWidget(const WhaleStaffApp());
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
