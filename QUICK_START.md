# Quick Start Guide - Purple Theme Module

This guide will help you quickly integrate beautiful Deep Purple themes into your Flutter application.

## 1. Add dependency

In your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  theme_module:
    git:
      url: https://github.com/yourusername/theme_module.git
```

Run `flutter pub get` to install.

## 2. Add theme to your app

In your `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize with Purple themes
  await ThemeModule.initializeWithPurpleTheme();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ThemeProvider.create(
      child: Builder(
        builder: (context) {
          final themeProvider = ThemeProvider.of(context);
          
          return MaterialApp(
            title: 'My App',
            theme: themeProvider.themeData,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
```

## 3. Add theme selector

Create a theme settings page:

```dart
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

class ThemeSettingsPage extends StatelessWidget {
  const ThemeSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = ThemeProvider.of(context);
    final purpleThemes = PurpleThemeCreator.createPurpleThemes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Text(
            'Select Theme',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          // Build theme selection options
          ...purpleThemes.map((theme) => _buildThemeOption(context, theme)),
          
          const SizedBox(height: 24),
          
          Text(
            'Preview',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ThemePreview(),
        ],
      ),
    );
  }
  
  Widget _buildThemeOption(BuildContext context, AppTheme theme) {
    final themeProvider = ThemeProvider.of(context);
    final isSelected = themeProvider.currentTheme.id == theme.id;
    
    return ListTile(
      title: Text(theme.name),
      subtitle: Text(theme.description ?? ''),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: theme.primaryColor,
          shape: BoxShape.circle,
          border: Border.all(color: isSelected ? theme.primaryColor : Colors.transparent),
        ),
      ),
      trailing: isSelected ? Icon(Icons.check, color: theme.primaryColor) : null,
      onTap: () {
        themeProvider.setTheme(theme.id);
      },
    );
  }
}
```

## 4. Access in your HomePage

```dart
import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';
import 'theme_settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Purple Theme Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.color_lens),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ThemeSettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Beautiful Purple Theme',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary Button'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Outlined Button'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
```

## 5. Done!

You now have a beautiful Deep Purple themed app with:
- Automatic theme persistence
- Theme switching capability
- Properly styled Material components

For more advanced usage and customization options, see the full README.md documentation.