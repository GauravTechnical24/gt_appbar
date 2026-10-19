import 'package:flutter/material.dart';

import '../core/gt_app_bar_shape.dart';

/// A customizable Material [AppBar] widget offering enhanced features like
/// curved bottom corners (with independent left and right corner control)
/// and an optional bottom divider.
class GTAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Key specifically passed to the underlying [AppBar] widget.
  final Key? appBarKey;

  /// The title text to display in the AppBar.
  final String title;

  /// Optional typography style for the title text.
  final TextStyle? titleTextStyle;

  /// Optional widget to display before the [title].
  final Widget? leading;

  /// Whether to automatically imply the leading widget if [leading] is null.
  final bool? automaticallyImplyLeading;

  /// A list of Widgets to display in a row after the [title] widget.
  final List<Widget>? actions;

  /// Background color of the AppBar. Falls back to `Theme.of(context).primaryColor`
  /// if not provided.
  final Color? backgroundColor;

  /// Elevation (z-coordinate shadow) of the AppBar. Defaults to `4.0`.
  final double? elevation;

  /// Elevation when the AppBar is scrolled under another widget.
  final double? scrolledUnderElevation;

  /// Whether the [title] should be centered. Defaults to `false`.
  final bool centerTitle;

  /// Optional widget to display across the bottom of the AppBar (e.g. a [TabBar]).
  final PreferredSizeWidget? bottom;

  /// Opacity of the [bottom] widget. Defaults to `1.0`.
  final double? bottomOpacity;

  /// Shadow color of the AppBar.
  final Color? shadowColor;

  /// Surface tint color of the AppBar when elevation is greater than 0 in Material 3.
  final Color? surfaceTintColor;

  /// Foreground color applied to title and action icons.
  final Color? foregroundColor;

  /// Custom width boundary for the [leading] widget.
  final double? leadingWidth;

  /// Opacity of the toolbar portion of the AppBar. Defaults to `1.0`.
  final double? toolbarOpacity;

  /// Custom toolbar height for the AppBar. Defaults to [kToolbarHeight].
  final double? toolbarHeight;

  /// Bottom corner curveness radius applied to both bottom-left and bottom-right corners.
  /// Defaults to `0.0`.
  final double bottomCurveness;

  /// Bottom-left corner radius for the AppBar. If null, falls back to [bottomCurveness].
  final double? bottomLeftRadius;

  /// Bottom-right corner radius for the AppBar. If null, falls back to [bottomCurveness].
  final double? bottomRightRadius;

  /// The spacing around [title] content on the horizontal axis.
  final double? titleSpacing;

  /// Whether to render a horizontal divider below the AppBar. Defaults to `false`.
  final bool showDivider;

  /// Color of the divider when [showDivider] is true.
  final Color? dividerColor;

  /// Thickness of the divider when [showDivider] is true. Defaults to `1.0`.
  final double dividerThickness;

  /// Custom shape border for the AppBar. If null, a [RoundedRectangleBorder] is created
  /// from [bottomLeftRadius], [bottomRightRadius], and [bottomCurveness].
  final ShapeBorder? shape;

  /// Creates a customizable Material [GTAppBar].
  const GTAppBar({
    super.key,
    this.appBarKey,
    required this.title,
    this.titleTextStyle,
    this.leading,
    this.automaticallyImplyLeading,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.scrolledUnderElevation,
    this.centerTitle = false,
    this.bottom,
    this.bottomOpacity,
    this.shadowColor,
    this.surfaceTintColor,
    this.foregroundColor,
    this.leadingWidth,
    this.toolbarOpacity,
    this.toolbarHeight,
    this.bottomCurveness = 0.0,
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.titleSpacing,
    this.showDivider = false,
    this.dividerColor,
    this.dividerThickness = 1.0,
    this.shape,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveShape =
        shape ??
        RoundedRectangleBorder(
          borderRadius: GTAppBarShape.resolveBottomBorderRadius(
            bottomCurveness: bottomCurveness,
            bottomLeftRadius: bottomLeftRadius,
            bottomRightRadius: bottomRightRadius,
          ),
        );

    final effectiveToolbarHeight = toolbarHeight ?? kToolbarHeight;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          key: appBarKey,
          title: Text(
            title,
            style:
                titleTextStyle ??
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading ?? true,
          actions: actions,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          elevation: elevation ?? 4.0,
          scrolledUnderElevation: scrolledUnderElevation,
          centerTitle: centerTitle,
          toolbarHeight: effectiveToolbarHeight,
          bottom: bottom != null
              ? PreferredSize(
                  preferredSize: bottom!.preferredSize,
                  child: Opacity(opacity: bottomOpacity ?? 1.0, child: bottom!),
                )
              : null,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          foregroundColor: foregroundColor,
          leadingWidth: leadingWidth,
          toolbarOpacity: toolbarOpacity ?? 1.0,
          titleSpacing: titleSpacing,
          shape: effectiveShape,
        ),
        if (showDivider)
          Divider(
            color: dividerColor ?? Theme.of(context).dividerColor,
            height: dividerThickness,
            thickness: dividerThickness,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    GTAppBarShape.calculateTotalHeight(
      toolbarHeight: toolbarHeight ?? kToolbarHeight,
      bottomPreferredSize: bottom?.preferredSize,
      showDivider: showDivider,
      dividerThickness: dividerThickness,
    ),
  );
}
