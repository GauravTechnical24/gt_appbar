import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gt_appbar/gt_appbar.dart';

void main() {
  testWidgets('GTAppBar has correct default corner radii', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          appBar: GTAppBar(
            title: 'Test Title',
            bottomCurveness: 10.0,
          ),
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

  testWidgets('GTAppBar has correct independent corner radii', (WidgetTester tester) async {
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
}
