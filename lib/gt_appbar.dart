library gt_appbar;

import 'package:flutter/material.dart';

/// A customizable AppBar with additional features like bottom curveness and optional divider.
class GTAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// Key for the AppBar widget.
  final Key? appBarKey;

  /// The title text to display in the AppBar.
  final String title;

  /// Optional style for the title text.
  final TextStyle? titleTextStyle;

  /// Optional widget to display at the start of the AppBar.
  final Widget? leading;

  /// Whether to automatically add a leading widget if [leading] is null.
  final bool? automaticallyImplyLeading;

  /// List of widgets to display at the end of the AppBar.
  final List<Widget>? actions;

  /// Background color of the AppBar.
  final Color? backgroundColor;

  /// Elevation (shadow) of the AppBar.
  final double? elevation;

  /// Elevation when the AppBar is scrolled under another widget.
  final double? scrolledUnderElevation;

  /// Whether to center the title.
  final bool centerTitle;

  /// Optional widget to display at the bottom of the AppBar (e.g., TabBar).
  final PreferredSizeWidget? bottom;

  /// Opacity of the bottom widget.
  final double? bottomOpacity;

  /// Shadow color of the AppBar.
  final Color? shadowColor;

  /// Surface tint color of the AppBar.
  final Color? surfaceTintColor;

  /// Foreground color for title and icons.
  final Color? foregroundColor;

  /// Custom width for the leading widget.
  final double? leadingWidth;

  /// Opacity of the toolbar.
  final double? toolbarOpacity;

  /// Bottom border radius for the AppBar.
  final double bottomCurveness;

  /// Spacing between the leading widget and the title.
  final double? titleSpacing;

  /// Whether to show a divider below the AppBar.
  final bool showDivider;

  /// Color of the divider.
  final Color? dividerColor;

  /// Constructor for GTAppBar.
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
    this.bottomCurveness = 0.0,
    this.titleSpacing,
    this.showDivider = false,
    this.dividerColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          key: appBarKey,
          title: Text(
            title,
            style: titleTextStyle ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading ?? true,
          actions: actions,
          backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
          elevation: elevation ?? 4.0,
          scrolledUnderElevation: scrolledUnderElevation,
          centerTitle: centerTitle,
          bottom: bottom != null
              ? PreferredSize(
                  preferredSize: bottom!.preferredSize,
                  child: Opacity(
                    opacity: bottomOpacity ?? 1.0,
                    child: bottom!,
                  ),
                )
              : null,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          foregroundColor: foregroundColor,
          leadingWidth: leadingWidth,
          toolbarOpacity: toolbarOpacity ?? 1.0,
          titleSpacing: titleSpacing,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(bottomCurveness), // Apply bottom border radius
            ),
          ),
        ),
        if (showDivider) // Display divider if showDivider is true
          Divider(
            color: dividerColor ?? Theme.of(context).dividerColor,
            height: 1,
            thickness: 1,
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        (bottom == null ? kToolbarHeight : kToolbarHeight + bottom!.preferredSize.height)
        + (showDivider ? 1 : 0), // Include divider height if enabled
      );
}
