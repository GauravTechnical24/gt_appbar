# gt_appbar

`gt_appbar` is a customizable AppBar widget for Flutter, offering enhanced features like bottom curveness and an optional divider for versatile app bar design.

## Features

 - Offers extensive options for styling, including colors, text styles, and widget placements.
 - Allows the AppBar to have a curved bottom edge for a distinct visual appeal.
 - Provides an optional divider below the AppBar to enhance content separation and UI clarity.
 - Ensures seamless integration with different themes and brightness modes for consistent app aesthetics.

## Getting started

To use this package, add gt_appbar as a dependency in your pubspec.yaml file.

## Usage

Minimal example:

```dart
     GTAppBar(
            title: "Global AppBar",
          ),
```

Custom settings:

```dart
   GTAppBar(
            title: "Global AppBar",
            backgroundColor: Colors.blueAccent.withOpacity(0.5),
            showDivider: true,
            bottomCurveness: 8.0,
            elevation: 8.0,
            centerTitle: false,
            titleSpacing: 0.0,
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                // Handle menu press
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Handle search press
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle notifications press
                },
                
              ),
              
            ],
          ),
```

## See also

 - [linkedin](https://www.linkedin.com/in/gauravtechnical24/)
