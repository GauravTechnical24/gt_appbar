import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gt_appbar/gt_appbar.dart';

void main() {
  runApp(const ExampleApp());
}

/// The root widget of the example application featuring dynamic theme switching.
class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _themeMode = ThemeMode.system;

  void _toggleTheme() {
    setState(() {
      if (_themeMode == ThemeMode.light) {
        _themeMode = ThemeMode.dark;
      } else if (_themeMode == ThemeMode.dark) {
        _themeMode = ThemeMode.light;
      } else {
        final brightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;
        _themeMode = brightness == Brightness.dark
            ? ThemeMode.light
            : ThemeMode.dark;
      }
    });
  }

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    const seedColor = Color(0xFF6366F1); // Indigo accent

    return MaterialApp(
      title: 'GT AppBar Modern Showcase',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
        cardTheme: CardThemeData(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFE2E8F0)),
          ),
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        cardTheme: CardThemeData(
          elevation: 0,
          color: const Color(0xFF1E293B),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFF334155)),
          ),
        ),
      ),
      home: ShowcaseHomeScreen(
        themeMode: _themeMode,
        onToggleTheme: _toggleTheme,
        onSetThemeMode: _setThemeMode,
      ),
    );
  }
}

/// Interactive showcase demonstrating GTAppBar (Material 3) and GTCupertinoNavigationBar.
class ShowcaseHomeScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;
  final ValueChanged<ThemeMode> onSetThemeMode;

  const ShowcaseHomeScreen({
    super.key,
    required this.themeMode,
    required this.onToggleTheme,
    required this.onSetThemeMode,
  });

  @override
  State<ShowcaseHomeScreen> createState() => _ShowcaseHomeScreenState();
}

class _ShowcaseHomeScreenState extends State<ShowcaseHomeScreen> {
  int _selectedStyle = 0; // 0 = Material 3, 1 = Cupertino
  bool _independentCorners = false;
  double _bottomCurveness = 24.0;
  double _bottomLeftRadius = 32.0;
  double _bottomRightRadius = 0.0;
  double _elevation = 4.0;
  bool _showDivider = true;
  double _dividerThickness = 1.5;
  bool _centerTitle = true;

  // Color palette for quick styling
  int _selectedColorIndex = 0;
  static const List<Color> _palette = [
    Color(0xFF6366F1), // Indigo
    Color(0xFF8B5CF6), // Purple
    Color(0xFF0EA5E9), // Sky Blue
    Color(0xFF10B981), // Emerald
    Color(0xFFF43F5E), // Rose
  ];

  Color get _activeColor => _palette[_selectedColorIndex];

  bool _isDarkMode(BuildContext context) {
    if (widget.themeMode == ThemeMode.dark) return true;
    if (widget.themeMode == ThemeMode.light) return false;
    return MediaQuery.platformBrightnessOf(context) == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = _isDarkMode(context);

    return _selectedStyle == 0
        ? _buildMaterialView(isDark)
        : _buildCupertinoView(isDark);
  }

  // ==========================================
  // MATERIAL 3 VIEW
  // ==========================================
  Widget _buildMaterialView(bool isDark) {
    final effectiveLeft = _independentCorners
        ? _bottomLeftRadius
        : _bottomCurveness;
    final effectiveRight = _independentCorners
        ? _bottomRightRadius
        : _bottomCurveness;

    return Scaffold(
      appBar: GTAppBar(
        title: 'Material GTAppBar',
        titleTextStyle: const TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.3,
          color: Colors.white,
        ),
        backgroundColor: _activeColor,
        foregroundColor: Colors.white,
        centerTitle: _centerTitle,
        elevation: _elevation,
        bottomCurveness: _bottomCurveness,
        bottomLeftRadius: _independentCorners ? effectiveLeft : null,
        bottomRightRadius: _independentCorners ? effectiveRight : null,
        showDivider: _showDivider,
        dividerColor: Colors.white.withValues(alpha: 0.25),
        dividerThickness: _dividerThickness,
        leading: IconButton(
          icon: const Icon(Icons.menu_rounded),
          tooltip: 'Menu',
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Navigation drawer tapped'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            ),
            tooltip: isDark ? 'Switch to Light Mode' : 'Switch to Dark Mode',
            onPressed: widget.onToggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Cycle Accent Color',
            onPressed: () {
              setState(() {
                _selectedColorIndex =
                    (_selectedColorIndex + 1) % _palette.length;
              });
            },
          ),
        ],
      ),
      body: _buildPlaygroundBody(isCupertino: false, isDark: isDark),
    );
  }

  // ==========================================
  // CUPERTINO VIEW
  // ==========================================
  Widget _buildCupertinoView(bool isDark) {
    final effectiveLeft = _independentCorners
        ? _bottomLeftRadius
        : _bottomCurveness;
    final effectiveRight = _independentCorners
        ? _bottomRightRadius
        : _bottomCurveness;

    final barBg = isDark
        ? const Color(0xCC1E293B)
        : Colors.white.withValues(alpha: 0.85);

    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primaryColor: _activeColor,
      ),
      child: CupertinoPageScaffold(
        navigationBar: GTCupertinoNavigationBar(
          title: 'Cupertino GTNavBar',
          bottomCurveness: _bottomCurveness,
          bottomLeftRadius: _independentCorners ? effectiveLeft : null,
          bottomRightRadius: _independentCorners ? effectiveRight : null,
          showDivider: _showDivider,
          dividerColor: isDark
              ? const Color(0x33FFFFFF)
              : const Color(0x1F000000),
          dividerThickness: _dividerThickness,
          backgroundColor: barBg,
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(CupertinoIcons.bars),
            onPressed: () {},
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: widget.onToggleTheme,
            child: Icon(
              isDark ? CupertinoIcons.sun_max_fill : CupertinoIcons.moon_fill,
            ),
          ),
        ),
        child: SafeArea(
          child: Material(
            type: MaterialType.transparency,
            child: _buildPlaygroundBody(isCupertino: true, isDark: isDark),
          ),
        ),
      ),
    );
  }

  // ==========================================
  // CONTROL PANEL & SCROLLING PREVIEW CONTENT
  // ==========================================
  Widget _buildPlaygroundBody({
    required bool isCupertino,
    required bool isDark,
  }) {
    final theme = Theme.of(context);

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      children: [
        // Mode & Theme Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _activeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.design_services_rounded,
                        color: _activeColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Design & Theme Controls',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SegmentedButton<int>(
                  segments: const [
                    ButtonSegment(
                      value: 0,
                      label: Text('Material 3'),
                      icon: Icon(Icons.palette_outlined),
                    ),
                    ButtonSegment(
                      value: 1,
                      label: Text('Cupertino'),
                      icon: Icon(Icons.apple),
                    ),
                  ],
                  selected: {_selectedStyle},
                  onSelectionChanged: (Set<int> newSelection) {
                    setState(() {
                      _selectedStyle = newSelection.first;
                    });
                  },
                ),
                const SizedBox(height: 16),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(
                      value: ThemeMode.light,
                      label: Text('Light'),
                      icon: Icon(Icons.light_mode_outlined),
                    ),
                    ButtonSegment(
                      value: ThemeMode.dark,
                      label: Text('Dark'),
                      icon: Icon(Icons.dark_mode_outlined),
                    ),
                    ButtonSegment(
                      value: ThemeMode.system,
                      label: Text('System'),
                      icon: Icon(Icons.brightness_auto_outlined),
                    ),
                  ],
                  selected: {widget.themeMode},
                  onSelectionChanged: (Set<ThemeMode> newMode) {
                    widget.onSetThemeMode(newMode.first);
                  },
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Shape & Geometry Playground Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: _activeColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.rounded_corner_rounded,
                            color: _activeColor,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Corner Curveness',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Chip(
                      label: Text(
                        _independentCorners
                            ? 'L:${_bottomLeftRadius.round()} | R:${_bottomRightRadius.round()}'
                            : '${_bottomCurveness.round()} dp',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Independent Bottom Corners'),
                  subtitle: const Text(
                    'Customize left and right corner radii separately',
                  ),
                  value: _independentCorners,
                  onChanged: (bool value) {
                    setState(() {
                      _independentCorners = value;
                    });
                  },
                ),
                if (!_independentCorners) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Unified Curveness: ${_bottomCurveness.toStringAsFixed(0)} dp',
                    style: theme.textTheme.bodyMedium,
                  ),
                  Slider(
                    value: _bottomCurveness,
                    min: 0.0,
                    max: 48.0,
                    divisions: 24,
                    label: '${_bottomCurveness.round()} dp',
                    activeColor: _activeColor,
                    onChanged: (double val) =>
                        setState(() => _bottomCurveness = val),
                  ),
                ] else ...[
                  const SizedBox(height: 8),
                  Text(
                    'Bottom-Left Radius: ${_bottomLeftRadius.toStringAsFixed(0)} dp',
                  ),
                  Slider(
                    value: _bottomLeftRadius,
                    min: 0.0,
                    max: 48.0,
                    divisions: 24,
                    label: '${_bottomLeftRadius.round()} dp',
                    activeColor: _activeColor,
                    onChanged: (double val) =>
                        setState(() => _bottomLeftRadius = val),
                  ),
                  Text(
                    'Bottom-Right Radius: ${_bottomRightRadius.toStringAsFixed(0)} dp',
                  ),
                  Slider(
                    value: _bottomRightRadius,
                    min: 0.0,
                    max: 48.0,
                    divisions: 24,
                    label: '${_bottomRightRadius.round()} dp',
                    activeColor: _activeColor,
                    onChanged: (double val) =>
                        setState(() => _bottomRightRadius = val),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Divider & Styling Controls Card
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _activeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.horizontal_rule_rounded,
                        color: _activeColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Divider & Elevation',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SwitchListTile.adaptive(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Show Bottom Divider'),
                  subtitle: const Text(
                    'Renders a divider line beneath the curved edge',
                  ),
                  value: _showDivider,
                  onChanged: (bool value) {
                    setState(() {
                      _showDivider = value;
                    });
                  },
                ),
                if (_showDivider) ...[
                  Text(
                    'Divider Thickness: ${_dividerThickness.toStringAsFixed(1)} dp',
                  ),
                  Slider(
                    value: _dividerThickness,
                    min: 0.5,
                    max: 4.0,
                    divisions: 7,
                    label: '${_dividerThickness.toStringAsFixed(1)} dp',
                    activeColor: _activeColor,
                    onChanged: (double val) =>
                        setState(() => _dividerThickness = val),
                  ),
                ],
                if (!isCupertino) ...[
                  SwitchListTile.adaptive(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Center Title'),
                    value: _centerTitle,
                    onChanged: (bool val) => setState(() => _centerTitle = val),
                  ),
                  Text('Elevation: ${_elevation.toStringAsFixed(0)}'),
                  Slider(
                    value: _elevation,
                    min: 0.0,
                    max: 16.0,
                    divisions: 8,
                    label: '${_elevation.round()}',
                    activeColor: _activeColor,
                    onChanged: (double val) => setState(() => _elevation = val),
                  ),
                ],
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Preset Templates Carousel / Row
        Text(
          'Quick Presets',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildPresetChip('Subtle (12dp)', () {
                setState(() {
                  _independentCorners = false;
                  _bottomCurveness = 12.0;
                  _showDivider = false;
                });
              }),
              _buildPresetChip('Pill Curvature (32dp)', () {
                setState(() {
                  _independentCorners = false;
                  _bottomCurveness = 32.0;
                  _showDivider = true;
                });
              }),
              _buildPresetChip('Asymmetric (36L / 0R)', () {
                setState(() {
                  _independentCorners = true;
                  _bottomLeftRadius = 36.0;
                  _bottomRightRadius = 0.0;
                  _showDivider = true;
                });
              }),
              _buildPresetChip('Divider Only (0dp)', () {
                setState(() {
                  _independentCorners = false;
                  _bottomCurveness = 0.0;
                  _showDivider = true;
                  _dividerThickness = 2.0;
                });
              }),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // Simulated Feed Cards (to demonstrate scrolling under curved edge)
        Text(
          'Scroll Demonstration',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        for (int i = 1; i <= 3; i++) ...[
          Card(
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _activeColor.withValues(alpha: 0.15),
                child: Text(
                  '#$i',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _activeColor,
                  ),
                ),
              ),
              title: Text('Feed Card $i'),
              subtitle: Text(
                'Notice how the curved app bar creates a modern floating appearance above content.',
                style: theme.textTheme.bodySmall,
              ),
              trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }

  Widget _buildPresetChip(String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ActionChip(
        label: Text(label),
        onPressed: onTap,
        avatar: const Icon(Icons.auto_awesome_rounded, size: 16),
      ),
    );
  }
}
