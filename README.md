# Purple Theme Module

A focused Flutter package featuring beautiful Deep Purple (#4d2962) themes with PANTONE-inspired color palettes. Designed for maximum reusability across projects.

## Features

- 🎨 Beautiful Deep Purple (#4d2962) theme with multiple variants (Light, Dark, Dominant)
- 🎭 Easy theme switching with built-in persistence
- 🌈 PANTONE color-inspired design with carefully selected complementary colors
- 🧩 Simple, reusable API for quick integration in new projects
- 📦 Lightweight implementation with minimal dependencies
- 📱 Beautiful theme preview and selection widgets included

## Purpose

This package is specifically designed for teams and developers who want to:
- Maintain consistent branding across multiple Flutter projects
- Quickly set up beautiful themes without starting from scratch
- Implement a professional purple-based design system with minimal effort

## Installation

Add `theme_module` to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  theme_module:
    git:
      url: https://github.com/yourusername/theme_module.git
```

## Basic Usage

### Initialize the theme module

```dart
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize with Purple themes
  final purpleThemes = PurpleThemeCreator.createPurpleThemes();
  
  await ThemeModule.initialize(
    themes: purpleThemes,
    defaultThemeId: 'purple_light', // Start with light purple theme
    useMaterial3: true,
  );
  
  runApp(const MyApp());
}
```

### Use ThemeProvider

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider.create(
      child: Builder(
        builder: (context) {
          final themeProvider = ThemeProvider.of(context);
          
          return MaterialApp(
            title: 'My Purple App',
            theme: themeProvider.themeData,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
```

## Purple Theme Variants

### Available Purple Themes

The package provides three beautiful purple theme variants:

1. **Purple Light** (`purple_light`) - Light theme with deep purple accents
2. **Purple Dark** (`purple_dark`) - Dark theme with deep purple accents
3. **Purple Dominant** (`purple_dominant`) - Dark theme with dominant deep purple background

### Purple Theme Previews and Picker

```dart
// Add Purple theme picker to your settings page
class ThemeSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Theme Settings')),
      body: Column(
        children: [
          // Preview current theme
          CustomColorDemo(),
          
          // Purple theme selector
          _buildPurpleThemePicker(context),
        ],
      ),
    );
  }
  
  Widget _buildPurpleThemePicker(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final purpleThemes = PurpleThemeCreator.createPurpleThemes();
    
    // Use the built-in theme picker or create your own UI
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Theme', style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 16),
          // Implement theme selection UI here...
        ],
      ),
    );
  }
}
```

## Example App

The package includes a complete example app showcasing:
- Implementation of all Purple theme variants
- Theme picker and preview components
- Material 3 components with the purple theme
- Persistence of selected theme

## Custom Branding

While focused on the Deep Purple (#4d2962) theme, you can easily customize the exact shade to match your brand:

```dart
// Create custom purple theme
final myBrandTheme = AppTheme(
  id: 'my_brand_purple',
  name: 'Brand Purple',
  themeMode: ThemeMode.light,
  primaryColor: Color(0xFF5D3A8E), // Your custom purple shade
  backgroundColor: Colors.white,
  textColor: Colors.black87,
  options: ThemeOptions(
    borderRadius: 12.0,
    cardElevation: 1.0,
  ),
);

// Add to provider
ThemeProvider.instance.addTheme(myBrandTheme);
```

## License

This package is distributed under the MIT license.

---

Created with ❤️ by [Your Name]