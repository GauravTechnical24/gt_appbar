import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gt_appbar/gt_appbar.dart';

void main() {
  group('GTAppBar Material tests', () {
    testWidgets('GTAppBar has correct default corner radii', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GTAppBar(title: 'Test Title', bottomCurveness: 10.0),
          ),
        ),
      );

      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final AppBar appBar = tester.widget(appBarFinder);
      final shape = appBar.shape as RoundedRectangleBorder;
      final borderRadius = shape.borderRadius as BorderRadius;

      expect(borderRadius.bottomLeft, const Radius.circular(10.0));
      expect(borderRadius.bottomRight, const Radius.circular(10.0));
    });

    testWidgets('GTAppBar has correct independent corner radii', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GTAppBar(
              title: 'Test Title',
              bottomLeftRadius: 20.0,
              bottomRightRadius: 5.0,
            ),
          ),
        ),
      );

      final appBarFinder = find.byType(AppBar);
      final AppBar appBar = tester.widget(appBarFinder);
      final shape = appBar.shape as RoundedRectangleBorder;
      final borderRadius = shape.borderRadius as BorderRadius;

      expect(borderRadius.bottomLeft, const Radius.circular(20.0));
      expect(borderRadius.bottomRight, const Radius.circular(5.0));
    });

    testWidgets('GTAppBar clamps negative radii to 0.0', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GTAppBar(
              title: 'Negative Radii',
              bottomLeftRadius: -10.0,
              bottomRightRadius: -5.0,
            ),
          ),
        ),
      );

      final appBarFinder = find.byType(AppBar);
      final AppBar appBar = tester.widget(appBarFinder);
      final shape = appBar.shape as RoundedRectangleBorder;
      final borderRadius = shape.borderRadius as BorderRadius;

      expect(borderRadius.bottomLeft, const Radius.circular(0.0));
      expect(borderRadius.bottomRight, const Radius.circular(0.0));
    });

    testWidgets('GTAppBar renders divider when showDivider is true', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GTAppBar(
              title: 'Divider Test',
              showDivider: true,
              dividerColor: Colors.red,
              dividerThickness: 2.0,
            ),
          ),
        ),
      );

      final dividerFinder = find.byType(Divider);
      expect(dividerFinder, findsOneWidget);

      final Divider divider = tester.widget(dividerFinder);
      expect(divider.color, Colors.red);
      expect(divider.thickness, 2.0);
    });

    testWidgets('GTAppBar hides divider when showDivider is false', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GTAppBar(title: 'No Divider', showDivider: false),
          ),
        ),
      );

      expect(find.byType(Divider), findsNothing);
    });

    testWidgets('GTAppBar calculates preferredSize accurately', (
      WidgetTester tester,
    ) async {
      const basicBar = GTAppBar(title: 'Basic Size');
      expect(basicBar.preferredSize.height, kToolbarHeight);

      const barWithDivider = GTAppBar(
        title: 'Size With Divider',
        showDivider: true,
        dividerThickness: 2.0,
      );
      expect(barWithDivider.preferredSize.height, kToolbarHeight + 2.0);

      const barWithBottom = GTAppBar(
        title: 'Size With Bottom',
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(48.0),
          child: SizedBox(height: 48.0),
        ),
        showDivider: true,
        dividerThickness: 1.0,
      );
      expect(barWithBottom.preferredSize.height, kToolbarHeight + 48.0 + 1.0);

      const customHeightBar = GTAppBar(
        title: 'Custom Height',
        toolbarHeight: 70.0,
      );
      expect(customHeightBar.preferredSize.height, 70.0);
    });

    testWidgets('GTAppBar renders title, leading, and actions', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GTAppBar(
              title: 'Full Bar',
              leading: Icon(Icons.arrow_back),
              actions: [Icon(Icons.more_vert)],
            ),
          ),
        ),
      );

      expect(find.text('Full Bar'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('GTAppBar respects custom shape parameter', (
      WidgetTester tester,
    ) async {
      const customShape = BeveledRectangleBorder();
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: GTAppBar(title: 'Custom Shape', shape: customShape),
          ),
        ),
      );

      final appBarFinder = find.byType(AppBar);
      final AppBar appBar = tester.widget(appBarFinder);
      expect(appBar.shape, customShape);
    });
  });

  group('GTCupertinoNavigationBar tests', () {
    testWidgets(
      'GTCupertinoNavigationBar renders with rounded bottom corners',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const CupertinoApp(
            home: CupertinoPageScaffold(
              navigationBar: GTCupertinoNavigationBar(
                title: 'Cupertino Bar',
                bottomCurveness: 16.0,
              ),
              child: SizedBox.shrink(),
            ),
          ),
        );

        expect(find.text('Cupertino Bar'), findsOneWidget);

        final clipRRectFinder = find.byType(ClipRRect);
        expect(clipRRectFinder, findsOneWidget);

        final ClipRRect clipRRect = tester.widget(clipRRectFinder);
        final borderRadius = clipRRect.borderRadius as BorderRadius;
        expect(borderRadius.bottomLeft, const Radius.circular(16.0));
        expect(borderRadius.bottomRight, const Radius.circular(16.0));
      },
    );

    testWidgets('GTCupertinoNavigationBar renders divider when requested', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const CupertinoApp(
          home: CupertinoPageScaffold(
            navigationBar: GTCupertinoNavigationBar(
              title: 'Cupertino Divider',
              showDivider: true,
              dividerColor: CupertinoColors.activeBlue,
              dividerThickness: 2.0,
            ),
            child: SizedBox.shrink(),
          ),
        ),
      );

      final containerFinder = find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.color == CupertinoColors.activeBlue &&
            widget.constraints?.maxHeight == 2.0,
      );
      expect(containerFinder, findsOneWidget);
    });

    testWidgets(
      'GTCupertinoNavigationBar shouldFullyObstruct returns false when curved',
      (WidgetTester tester) async {
        const curvedBar = GTCupertinoNavigationBar(
          title: 'Curved',
          bottomCurveness: 10.0,
        );

        await tester.pumpWidget(
          const CupertinoApp(
            home: CupertinoPageScaffold(
              navigationBar: curvedBar,
              child: SizedBox.shrink(),
            ),
          ),
        );

        final BuildContext context = tester.element(
          find.byType(CupertinoPageScaffold),
        );
        expect(curvedBar.shouldFullyObstruct(context), isFalse);
      },
    );

    testWidgets('GTCupertinoNavigationBar preferredSize calculates correctly', (
      WidgetTester tester,
    ) async {
      const bar = GTCupertinoNavigationBar(
        title: 'Size',
        height: 44.0,
        showDivider: true,
        dividerThickness: 1.5,
      );

      expect(bar.preferredSize.height, 44.0 + 1.5);
    });
  });

  group('GTAppBarShape unit tests', () {
    test(
      'resolveBottomBorderRadius returns equal radii for bottomCurveness',
      () {
        final radius = GTAppBarShape.resolveBottomBorderRadius(
          bottomCurveness: 12.0,
        );
        expect(radius.bottomLeft, const Radius.circular(12.0));
        expect(radius.bottomRight, const Radius.circular(12.0));
      },
    );

    test('resolveBottomBorderRadius prioritizes independent corner radii', () {
      final radius = GTAppBarShape.resolveBottomBorderRadius(
        bottomCurveness: 10.0,
        bottomLeftRadius: 18.0,
        bottomRightRadius: 6.0,
      );
      expect(radius.bottomLeft, const Radius.circular(18.0));
      expect(radius.bottomRight, const Radius.circular(6.0));
    });

    test('calculateTotalHeight handles zero divider and zero bottom', () {
      final height = GTAppBarShape.calculateTotalHeight(
        toolbarHeight: 56.0,
        bottomPreferredSize: null,
        showDivider: false,
      );
      expect(height, 56.0);
    });

    test('calculateTotalHeight accumulates bottom height and divider', () {
      final height = GTAppBarShape.calculateTotalHeight(
        toolbarHeight: 56.0,
        bottomPreferredSize: const Size.fromHeight(30.0),
        showDivider: true,
        dividerThickness: 2.0,
      );
      expect(height, 88.0);
    });
  });
}
