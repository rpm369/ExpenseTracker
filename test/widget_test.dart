// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/main.dart';

void main() {
  testWidgets('Authentication screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(false));

    // Verify that our auth screen loads and displays the login header.
    expect(find.text("Hey,\nWelcome Back"), findsOneWidget);
    expect(find.text("Login now to track all your expenses"), findsOneWidget);
  });
}
