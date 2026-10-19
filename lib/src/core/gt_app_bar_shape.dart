import 'package:flutter/widgets.dart';

/// Utility methods for computing shape and dimensions for GT app bars.
class GTAppBarShape {
  const GTAppBarShape._();

  /// Default toolbar height (56.0 dp), matching Flutter's standard Material toolbar height.
  static const double defaultToolbarHeight = 56.0;

  /// Default Cupertino navigation bar height (44.0 dp), matching Apple's standard height.
  static const double defaultCupertinoBarHeight = 44.0;

  /// Resolves the [BorderRadius] for the bottom corners based on
  /// [bottomCurveness], [bottomLeftRadius], and [bottomRightRadius].
  ///
  /// If either [bottomLeftRadius] or [bottomRightRadius] is not specified,
  /// it falls back to [bottomCurveness]. Negative values are clamped to 0.0.
  static BorderRadius resolveBottomBorderRadius({
    double bottomCurveness = 0.0,
    double? bottomLeftRadius,
    double? bottomRightRadius,
  }) {
    final effectiveLeft = (bottomLeftRadius ?? bottomCurveness).clamp(
      0.0,
      double.infinity,
    );
    final effectiveRight = (bottomRightRadius ?? bottomCurveness).clamp(
      0.0,
      double.infinity,
    );

    return BorderRadius.only(
      bottomLeft: Radius.circular(effectiveLeft),
      bottomRight: Radius.circular(effectiveRight),
    );
  }

  /// Computes the total preferred height including toolbar height,
  /// optional bottom widget height, and optional divider height.
  static double calculateTotalHeight({
    double toolbarHeight = defaultToolbarHeight,
    Size? bottomPreferredSize,
    bool showDivider = false,
    double dividerThickness = 1.0,
  }) {
    final bottomHeight = bottomPreferredSize?.height ?? 0.0;
    final dividerHeight = showDivider ? dividerThickness : 0.0;
    return toolbarHeight + bottomHeight + dividerHeight;
  }
}
