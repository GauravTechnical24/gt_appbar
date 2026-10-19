# gt_appbar

[![pub package](https://img.shields.io/pub/v/gt_appbar.svg)](https://pub.dev/packages/gt_appbar)
[![License: GPL-3.0](https://img.shields.io/badge/License-GPL--3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)
[![Flutter](https://img.shields.io/badge/Flutter-%3E%3D3.47.7-blue.svg)](https://flutter.dev)

A customizable, production-ready `AppBar` and `CupertinoNavigationBar` widget library for Flutter. `gt_appbar` enhances standard navigation bars with curved bottom corners (with independent left and right corner control), custom bottom dividers, deep layout customization, and clean separation between Material 3 and Cupertino iOS designs.

---

## ✨ Features

- 📐 **Custom Bottom Curveness** – Render smooth curved bottom corners on your app bars.
- 🎛️ **Independent Corner Control** – Configure left and right bottom corner radii independently.
- ➖ **Optional Divider** – Easily toggle and style a divider line directly beneath the curved edge.
- 🍏 **Cupertino Separation** – Native iOS-style `GTCupertinoNavigationBar` and `GTCupertinoAppBar` built without Material dependencies.
- 🎨 **Material 3 Support** – Fully compatible with modern Material Design color schemes, elevations, and theme tokens.
- 🌐 **Cross-Platform & WASM-Ready** – Works out-of-the-box on Android, iOS, Web, macOS, Windows, and Linux.

---

## 📱 Platform Support

| Android | iOS | macOS | Linux | Windows | Web / WASM |
| :---: | :---: | :---: | :---: | :---: | :---: |
| ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

---

## 🚀 Getting Started

### Installation

Add `gt_appbar` to your `pubspec.yaml` dependencies:

```yaml
dependencies:
  gt_appbar: ^1.3.0
```

Then run:

```bash
flutter pub get
```

Import the package in your Dart code:

```dart
import 'package:gt_appbar/gt_appbar.dart';
```

---

## 📖 Usage

### 1. Material 3 Minimal Example

```dart
import 'package:flutter/material.dart';
import 'package:gt_appbar/gt_appbar.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: GTAppBar(
        title: 'Simple AppBar',
        bottomCurveness: 20.0,
      ),
      body: Center(
        child: Text('Hello GTAppBar!'),
      ),
    );
  }
}
```

### 2. Material 3 Advanced Customization

```dart
GTAppBar(
  title: 'Custom Curved AppBar',
  backgroundColor: Colors.indigo.shade700,
  foregroundColor: Colors.white,
  titleTextStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
  centerTitle: true,
  elevation: 6.0,
  bottomLeftRadius: 28.0,
  bottomRightRadius: 28.0,
  showDivider: true,
  dividerColor: Colors.white24,
  dividerThickness: 1.5,
  leading: IconButton(
    icon: const Icon(Icons.menu),
    onPressed: () {},
  ),
  actions: [
    IconButton(
      icon: const Icon(Icons.search),
      onPressed: () {},
    ),
    IconButton(
      icon: const Icon(Icons.notifications_none),
      onPressed: () {},
    ),
  ],
)
```

### 3. Cupertino iOS NavigationBar

```dart
import 'package:flutter/cupertino.dart';
import 'package:gt_appbar/gt_appbar.dart';

class CupertinoPageExample extends StatelessWidget {
  const CupertinoPageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: GTCupertinoNavigationBar(
        title: 'iOS Navigation',
        bottomCurveness: 18.0,
        showDivider: true,
        trailing: CupertinoButton(
          padding: EdgeInsets.zero,
          child: const Icon(CupertinoIcons.settings),
          onPressed: () {},
        ),
      ),
      child: const SafeArea(
        child: Center(
          child: Text('Cupertino Content'),
        ),
      ),
    );
  }
}
```

---

## 📋 API Reference

### `GTAppBar` (Material)

| Parameter | Type | Default | Description |
|---|---|---|---|
| `title` | `String` | **Required** | Title text displayed in the AppBar. |
| `titleTextStyle` | `TextStyle?` | `null` | Custom typography style for the title text. |
| `backgroundColor` | `Color?` | `Theme.of(context).primaryColor` | Background color of the AppBar. |
| `foregroundColor` | `Color?` | `null` | Foreground color applied to title and action icons. |
| `elevation` | `double?` | `4.0` | Controls shadow elevation under the AppBar. |
| `scrolledUnderElevation` | `double?` | `null` | Elevation when another widget is scrolled underneath. |
| `bottomCurveness` | `double` | `0.0` | Default fallback radius for both bottom corners. |
| `bottomLeftRadius` | `double?` | `bottomCurveness` | Corner radius for the bottom-left corner. |
| `bottomRightRadius` | `double?` | `bottomCurveness` | Corner radius for the bottom-right corner. |
| `showDivider` | `bool` | `false` | When true, renders a horizontal divider below the curve. |
| `dividerColor` | `Color?` | `Theme.of(context).dividerColor` | Color of the bottom divider. |
| `dividerThickness` | `double` | `1.0` | Thickness of the bottom divider. |
| `toolbarHeight` | `double?` | `kToolbarHeight` | Height of the toolbar component. |
| `centerTitle` | `bool` | `false` | Whether to center the title horizontally. |
| `leading` | `Widget?` | `null` | Widget placed before the title. |
| `automaticallyImplyLeading` | `bool?` | `true` | Whether to automatically imply the leading widget. |
| `actions` | `List<Widget>?` | `null` | Widgets displayed in a row after the title. |
| `bottom` | `PreferredSizeWidget?` | `null` | Optional bottom widget (e.g. a `TabBar`). |
| `shape` | `ShapeBorder?` | `null` | Optional custom shape border override. |

### `GTCupertinoNavigationBar` (Cupertino)

| Parameter | Type | Default | Description |
|---|---|---|---|
| `title` | `String?` | `null` | Title string placed in the middle. |
| `middle` | `Widget?` | `null` | Custom widget placed in the middle. |
| `leading` | `Widget?` | `null` | Custom widget placed at the start. |
| `trailing` | `Widget?` | `null` | Custom widget placed at the end. |
| `backgroundColor` | `Color?` | `null` | Background color with Cupertino translucency. |
| `bottomCurveness` | `double` | `0.0` | Default fallback radius for both bottom corners. |
| `bottomLeftRadius` | `double?` | `bottomCurveness` | Corner radius for the bottom-left corner. |
| `bottomRightRadius` | `double?` | `bottomCurveness` | Corner radius for the bottom-right corner. |
| `showDivider` | `bool` | `false` | When true, renders a horizontal divider below the bar. |
| `dividerColor` | `Color?` | `CupertinoColors.separator` | Color of the bottom divider. |
| `dividerThickness` | `double` | `1.0` | Thickness of the bottom divider. |
| `height` | `double` | `44.0` | Standard navigation bar height. |

---

## 🤝 Contributing

Contributions and feedback are welcome! Please feel free to open issues or submit pull requests on the [GitHub Repository](https://github.com/GauravTechnical24/gt_appbar).

## 📄 License

This package is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.
