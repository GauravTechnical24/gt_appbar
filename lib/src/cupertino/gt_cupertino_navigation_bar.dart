import 'package:flutter/cupertino.dart';

import '../core/gt_app_bar_shape.dart';

/// A customizable Cupertino-style navigation bar widget offering iOS-native
/// aesthetics, frosted glass translucency, curved bottom corners, and an optional divider.
///
/// Designed specifically for iOS/Cupertino user interfaces, this widget imports
/// exclusively from `package:flutter/cupertino.dart` without Material dependencies.
class GTCupertinoNavigationBar extends StatelessWidget
    implements ObstructingPreferredSizeWidget {
  /// Key specifically passed to the underlying [CupertinoNavigationBar] widget.
  final Key? navBarKey;

  /// The title text to display in the middle of the navigation bar.
  /// If provided alongside [middle], [middle] takes precedence.
  final String? title;

  /// A custom widget placed in the middle of the navigation bar.
  final Widget? middle;

  /// A custom widget placed at the start of the navigation bar.
  final Widget? leading;

  /// Whether to automatically imply the leading widget if [leading] is null.
  final bool automaticallyImplyLeading;

  /// Whether to automatically imply the middle widget if [middle] and [title] are null.
  final bool automaticallyImplyMiddle;

  /// Controls the "back" button label when automatically implied.
  final String? previousPageTitle;

  /// A custom widget placed at the end of the navigation bar.
  final Widget? trailing;

  /// The background color of the navigation bar.
  /// Defaults to [CupertinoTheme]'s bar background color.
  final Color? backgroundColor;

  /// The brightness of the status bar text.
  final Brightness? brightness;

  /// Padding for the contents of the navigation bar.
  final EdgeInsetsDirectional? padding;

  /// The border drawn at the bottom of the navigation bar before clipping.
  final Border? border;

  /// Whether to transition between routes when used inside CupertinoPageRoute.
  final bool transitionBetweenRoutes;

  /// Bottom corner curveness radius applied to both bottom-left and bottom-right corners.
  /// Defaults to `0.0`.
  final double bottomCurveness;

  /// Bottom-left corner radius for the navigation bar. If null, falls back to [bottomCurveness].
  final double? bottomLeftRadius;

  /// Bottom-right corner radius for the navigation bar. If null, falls back to [bottomCurveness].
  final double? bottomRightRadius;

  /// Whether to render a horizontal divider below the navigation bar. Defaults to `false`.
  final bool showDivider;

  /// Color of the divider when [showDivider] is true.
  final Color? dividerColor;

  /// Thickness of the divider when [showDivider] is true. Defaults to `1.0`.
  final double dividerThickness;

  /// Standard navigation bar height in Cupertino design (default 44.0).
  final double height;

  /// Creates a customizable Cupertino-style navigation bar.
  const GTCupertinoNavigationBar({
    super.key,
    this.navBarKey,
    this.title,
    this.middle,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.automaticallyImplyMiddle = true,
    this.previousPageTitle,
    this.trailing,
    this.backgroundColor,
    this.brightness,
    this.padding,
    this.border,
    this.transitionBetweenRoutes = true,
    this.bottomCurveness = 0.0,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.showDivider = false,
    this.dividerColor,
    this.dividerThickness = 1.0,
    this.height = 44.0,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = GTAppBarShape.resolveBottomBorderRadius(
      bottomCurveness: bottomCurveness,
      bottomLeftRadius: bottomLeftRadius,
      bottomRightRadius: bottomRightRadius,
    );

    final Widget? effectiveMiddle =
        middle ??
        (title != null
            ? Text(title!, style: const TextStyle(fontWeight: FontWeight.w600))
            : null);

    final navBar = CupertinoNavigationBar(
      key: navBarKey,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
      automaticallyImplyMiddle: automaticallyImplyMiddle,
      previousPageTitle: previousPageTitle,
      middle: effectiveMiddle,
      trailing: trailing,
      backgroundColor: backgroundColor,
      brightness: brightness,
      padding: padding,
      border: border,
      transitionBetweenRoutes: transitionBetweenRoutes,
    );

    final Widget clippedNavBar = ClipRRect(
      borderRadius: borderRadius,
      child: navBar,
    );

    if (!showDivider) {
      return clippedNavBar;
    }

    final effectiveDividerColor =
        dividerColor ?? CupertinoColors.separator.resolveFrom(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        clippedNavBar,
        Container(height: dividerThickness, color: effectiveDividerColor),
      ],
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (showDivider ? dividerThickness : 0.0));

  @override
  bool shouldFullyObstruct(BuildContext context) {
    // If rounded corners or translucency are used, do not fully obstruct.
    if (bottomCurveness > 0 ||
        (bottomLeftRadius ?? 0) > 0 ||
        (bottomRightRadius ?? 0) > 0) {
      return false;
    }
    final Color effectiveColor =
        backgroundColor ?? CupertinoTheme.of(context).barBackgroundColor;
    return effectiveColor.a == 1.0;
  }
}

/// Convenience alias for [GTCupertinoNavigationBar].
typedef GTCupertinoAppBar = GTCupertinoNavigationBar;
