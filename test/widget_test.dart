import 'package:firebase_test_lab_flutter_demo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Counter App Widget Tests', () {
    testWidgets('Counter starts at 0', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Verify counter starts at 0
      expect(find.text('0'), findsOneWidget);
      expect(find.text('1'), findsNothing);
    });

    testWidgets('Increment button increases counter', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Verify initial state
      expect(find.text('0'), findsOneWidget);

      // Tap the increment button
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();

      // Verify counter increased
      expect(find.text('0'), findsNothing);
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Decrement button decreases counter', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Tap increment twice to set counter to 2
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);

      // Tap the decrement button
      await tester.tap(find.byKey(const Key('decrement_button')));
      await tester.pump();

      // Verify counter decreased
      expect(find.text('1'), findsOneWidget);
    });

    testWidgets('Reset button resets counter to 0', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Increment counter multiple times
      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byKey(const Key('increment_button')));
        await tester.pump();
      }

      expect(find.text('5'), findsOneWidget);

      // Tap reset button
      await tester.tap(find.byKey(const Key('reset_button')));
      await tester.pump();

      // Verify counter is back to 0
      expect(find.text('0'), findsOneWidget);
      expect(find.text('5'), findsNothing);
    });

    testWidgets('Counter can go negative', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Tap decrement button
      await tester.tap(find.byKey(const Key('decrement_button')));
      await tester.pump();

      // Verify counter is negative
      expect(find.text('-1'), findsOneWidget);
    });

    testWidgets('All three buttons are present', (WidgetTester tester) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Verify all buttons exist
      expect(find.byKey(const Key('increment_button')), findsOneWidget);
      expect(find.byKey(const Key('decrement_button')), findsOneWidget);
      expect(find.byKey(const Key('reset_button')), findsOneWidget);
    });

    testWidgets('App title is displayed correctly', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Verify app title
      expect(find.text('Firebase Test Lab Counter'), findsOneWidget);
    });

    testWidgets('Multiple operations work correctly', (
      WidgetTester tester,
    ) async {
      // Build the app
      await tester.pumpWidget(const MyApp());

      // Perform multiple operations
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();
      await tester.tap(find.byKey(const Key('increment_button')));
      await tester.pump();

      expect(find.text('3'), findsOneWidget);

      await tester.tap(find.byKey(const Key('decrement_button')));
      await tester.pump();

      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byKey(const Key('reset_button')));
      await tester.pump();

      expect(find.text('0'), findsOneWidget);
    });
  });
}
