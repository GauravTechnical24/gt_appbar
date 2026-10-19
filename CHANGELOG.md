# Changelog

## 1.3.0 - 2026-10-19

### Added
- **Cupertino Architecture Separation**: Introduced `GTCupertinoNavigationBar` and `GTCupertinoAppBar` built purely with `package:flutter/cupertino.dart` without Material dependencies.
- **Shared Core Shape Layer**: Extracted `GTAppBarShape` to cleanly encapsulate corner radius calculations and preferred height computations.
- **Enhanced Customization**: Added `toolbarHeight`, `shape`, and custom `dividerThickness` properties to `GTAppBar`.
- **Interactive Showcase Example**: Redesigned the example application to include an interactive control panel allowing live switching between Material 3 and Cupertino styles, dynamic curveness sliders, and divider toggles.
- **Comprehensive Test Suite**: Added complete widget and unit tests for Material, Cupertino, and core shape calculations with 100% test pass rate.

### Changed
- **pub.dev 160/160 Optimization**: Streamlined package description to 171 characters (within the optimal 60-180 range) and added library-level documentation comments to achieve full pub points.
- **Modern Dependencies**: Upgraded `flutter_lints` to `^6.0.0`.
- **Android Native Modernization**: Updated example application to Gradle 9.1.0, Android Gradle Plugin 9.0.1, Kotlin 2.4.0, and Java 17 compatibility.
- **Documentation Overhaul**: Updated README with accurate GPL-3.0 licensing, comprehensive API reference tables, and side-by-side Material and Cupertino guides.

### Fixed
- Fixed formatting across all library and test files to strictly comply with `dart format`.
- Fixed clamping for negative corner radius inputs in `GTAppBar` and `GTCupertinoNavigationBar`.
- Fixed outdated example widget test that failed on default counter assertions.

### Compatibility
- Minimum supported Flutter version: `>=3.47.7`
- Minimum supported Dart SDK: `^3.13.5`

## 1.2.0 - 2026-06-18

### Changed
- Updated target constraints to Flutter `3.44.2` and Dart `3.12.2`.
- Realighed example application SDK constraints.

## 1.1.1 - 2026-03-28

### Added
- Added `bottomLeftRadius` and `bottomRightRadius` for independent bottom corner radius control.

### Changed
- Updated SDK constraints to Flutter `3.41.0` and Dart `3.11.0`.
- Maintained `bottomCurveness` as default fallback for corner radii.

## 1.0.1 - 2025-01-04

### Added
- Initial release of `gt_appbar` with customizable curved bottom AppBar and divider support.
