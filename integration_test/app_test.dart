import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:firebase_test_lab_flutter_demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Counter App Integration Tests', () {
    testWidgets('Complete user flow test', (WidgetTester tester) async {
      // Launch the app
      app.main();
      await tester.pumpAndSettle();

      // Verify app launched successfully
      expect(find.text('Firebase Test Lab Counter'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);

      // Test increment functionality
      final incrementButton = find.byKey(const Key('increment_button'));
      expect(incrementButton, findsOneWidget);

      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      await tester.tap(incrementButton);
      await tester.pumpAndSettle();
      expect(find.text('2'), findsOneWidget);

      // Test decrement functionality
      final decrementButton = find.byKey(const Key('decrement_button'));
      expect(decrementButton, findsOneWidget);

      await tester.tap(decrementButton);
      await tester.pumpAndSettle();
      expect(find.text('1'), findsOneWidget);

      // Test reset functionality
      final resetButton = find.byKey(const Key('reset_button'));
      expect(resetButton, findsOneWidget);

      await tester.tap(resetButton);
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('Rapid button tapping test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final incrementButton = find.byKey(const Key('increment_button'));

      // Rapidly tap increment button 10 times
      for (int i = 0; i < 10; i++) {
        await tester.tap(incrementButton);
        await tester.pump(const Duration(milliseconds: 100));
      }

      await tester.pumpAndSettle();
      expect(find.text('10'), findsOneWidget);
    });

    testWidgets('Negative counter test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final decrementButton = find.byKey(const Key('decrement_button'));

      // Decrement from 0 to negative
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();
      expect(find.text('-1'), findsOneWidget);

      await tester.tap(decrementButton);
      await tester.pumpAndSettle();
      expect(find.text('-2'), findsOneWidget);

      await tester.tap(decrementButton);
      await tester.pumpAndSettle();
      expect(find.text('-3'), findsOneWidget);
    });

    testWidgets('Mixed operations test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final incrementButton = find.byKey(const Key('increment_button'));
      final decrementButton = find.byKey(const Key('decrement_button'));
      final resetButton = find.byKey(const Key('reset_button'));

      // Increment to 5
      for (int i = 0; i < 5; i++) {
        await tester.tap(incrementButton);
        await tester.pumpAndSettle();
      }
      expect(find.text('5'), findsOneWidget);

      // Decrement to 3
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();
      await tester.tap(decrementButton);
      await tester.pumpAndSettle();
      expect(find.text('3'), findsOneWidget);

      // Increment to 7
      for (int i = 0; i < 4; i++) {
        await tester.tap(incrementButton);
        await tester.pumpAndSettle();
      }
      expect(find.text('7'), findsOneWidget);

      // Reset
      await tester.tap(resetButton);
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('UI elements visibility test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Verify all UI elements are visible and accessible
      expect(find.byType(AppBar), findsOneWidget);
      expect(find.text('Firebase Test Lab Counter'), findsOneWidget);
      expect(
        find.text('You have tapped the button this many times:'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('counter_text')), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
      expect(find.byIcon(Icons.remove), findsOneWidget);
      expect(find.byIcon(Icons.refresh), findsOneWidget);
    });

    testWidgets('Stress test - 100 operations', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      final incrementButton = find.byKey(const Key('increment_button'));
      final decrementButton = find.byKey(const Key('decrement_button'));

      // Perform 50 increments
      for (int i = 0; i < 50; i++) {
        await tester.tap(incrementButton);
        if (i % 10 == 0) {
          await tester.pumpAndSettle();
        }
      }
      await tester.pumpAndSettle();
      expect(find.text('50'), findsOneWidget);

      // Perform 50 decrements
      for (int i = 0; i < 50; i++) {
        await tester.tap(decrementButton);
        if (i % 10 == 0) {
          await tester.pumpAndSettle();
        }
      }
      await tester.pumpAndSettle();
      expect(find.text('0'), findsOneWidget);
    });
  });
}
