import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';
import 'package:gt_appbar/gt_appbar.dart';

void main() {
  testWidgets(
    'ExampleApp smoke test - switches styles and toggles theme modes',
    (WidgetTester tester) async {
      await tester.pumpWidget(const ExampleApp());
      await tester.pumpAndSettle();

      // Verify Material GTAppBar is visible initially
      expect(find.text('Material GTAppBar'), findsOneWidget);
      expect(find.byType(GTAppBar), findsOneWidget);

      // Verify Theme toggle buttons exist
      expect(find.text('Dark'), findsOneWidget);
      expect(find.text('Light'), findsOneWidget);

      // Tap Dark theme segment
      await tester.tap(find.text('Dark'));
      await tester.pumpAndSettle();

      // Tap Cupertino segment to switch views
      final cupertinoSegmentFinder = find.text('Cupertino');
      expect(cupertinoSegmentFinder, findsOneWidget);
      await tester.tap(cupertinoSegmentFinder);
      await tester.pumpAndSettle();

      // Verify Cupertino GTCupertinoNavigationBar is now rendered
      expect(find.text('Cupertino GTNavBar'), findsOneWidget);
      expect(find.byType(GTCupertinoNavigationBar), findsOneWidget);

      // Switch back to Light theme
      await tester.tap(find.text('Light'));
      await tester.pumpAndSettle();
      expect(find.byType(GTCupertinoNavigationBar), findsOneWidget);
    },
  );
}
