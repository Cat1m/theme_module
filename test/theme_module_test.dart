// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme_module/theme_module.dart';

void main() {
  group('AppTheme Tests', () {
    test('Creating default light theme', () {
      final theme = AppTheme.light();

      expect(theme.id, 'light');
      expect(theme.name, 'Light');
      expect(theme.themeMode, ThemeMode.light);
      expect(theme.primaryColor, const Color(0xFF2196F3));
      expect(theme.backgroundColor, Colors.white);
      expect(theme.textColor, Colors.black87);
    });

    test('Creating default dark theme', () {
      final theme = AppTheme.dark();

      expect(theme.id, 'dark');
      expect(theme.name, 'Dark');
      expect(theme.themeMode, ThemeMode.dark);
      expect(theme.primaryColor, const Color(0xFF1976D2));
      expect(theme.backgroundColor, const Color(0xFF121212));
      expect(theme.textColor, Colors.white);
    });

    test('Converting theme to ThemeData', () {
      final theme = AppTheme.light();
      final themeData = theme.toThemeData();

      expect(themeData, isA<ThemeData>());
      expect(themeData.colorScheme.primary, theme.primaryColor);
      expect(themeData.scaffoldBackgroundColor, theme.backgroundColor);
    });

    test('Creating theme with custom options', () {
      final options = ThemeOptions(
        borderRadius: 16.0,
        cardElevation: 2.0,
        appBarElevation: 1.0,
      );

      final theme = AppTheme(
        id: 'custom',
        name: 'Custom',
        themeMode: ThemeMode.light,
        primaryColor: Colors.purple,
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        options: options,
      );

      expect(theme.options.borderRadius, 16.0);
      expect(theme.options.cardElevation, 2.0);
      expect(theme.options.appBarElevation, 1.0);
    });

    test('Converting theme to Map and back', () {
      final originalTheme = AppTheme(
        id: 'test_theme',
        name: 'Test Theme',
        description: 'A test theme',
        themeMode: ThemeMode.light,
        primaryColor: Colors.amber,
        accentColor: Colors.orange,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontFamily: 'Roboto',
      );

      final map = originalTheme.toMap();
      final recreatedTheme = AppTheme.fromMap(map);

      expect(recreatedTheme.id, originalTheme.id);
      expect(recreatedTheme.name, originalTheme.name);
      expect(recreatedTheme.description, originalTheme.description);
      expect(recreatedTheme.themeMode, originalTheme.themeMode);
      expect(
        recreatedTheme.primaryColor.value,
        originalTheme.primaryColor.value,
      );
      expect(recreatedTheme.accentColor, originalTheme.accentColor);
      expect(recreatedTheme.backgroundColor, originalTheme.backgroundColor);
      expect(recreatedTheme.textColor, originalTheme.textColor);
      expect(recreatedTheme.fontFamily, originalTheme.fontFamily);
    });
  });

  group('ThemeOptions Tests', () {
    test('Creating default ThemeOptions', () {
      final options = ThemeOptions();

      expect(options.borderRadius, 8.0);
      expect(options.cardElevation, 1.0);
      expect(options.appBarElevation, 0.0);
      expect(options.defaultFontWeight, FontWeight.normal);
      expect(options.defaultFontSize, 14.0);
      expect(options.defaultPadding, 16.0);
    });

    test('Creating rounded ThemeOptions', () {
      final options = ThemeOptions.rounded();

      expect(options.borderRadius, 16.0);
      expect(options.cardElevation, 2.0);
    });

    test('Creating flat ThemeOptions', () {
      final options = ThemeOptions.flat();

      expect(options.borderRadius, 4.0);
      expect(options.cardElevation, 0.0);
      expect(options.appBarElevation, 0.0);
    });

    test('Converting ThemeOptions to Map and back', () {
      final originalOptions = ThemeOptions(
        borderRadius: 20.0,
        cardElevation: 4.0,
        appBarElevation: 2.0,
        defaultFontWeight: FontWeight.bold,
        defaultFontSize: 16.0,
        defaultPadding: 20.0,
      );

      final map = originalOptions.toMap();
      final recreatedOptions = ThemeOptions.fromMap(map);

      expect(recreatedOptions.borderRadius, originalOptions.borderRadius);
      expect(recreatedOptions.cardElevation, originalOptions.cardElevation);
      expect(recreatedOptions.appBarElevation, originalOptions.appBarElevation);
      expect(
        recreatedOptions.defaultFontWeight,
        originalOptions.defaultFontWeight,
      );
      expect(recreatedOptions.defaultFontSize, originalOptions.defaultFontSize);
      expect(recreatedOptions.defaultPadding, originalOptions.defaultPadding);
    });
  });

  group('PurpleThemeCreator Tests', () {
    test('Purple color value is correct', () {
      expect(PurpleThemeCreator.purpleColor, const Color(0xFF4d2962));
    });

    test('Creating Purple themes', () {
      final themes = PurpleThemeCreator.createPurpleThemes();

      expect(themes.length, 3);
      expect(themes[0].id, 'purple_light');
      expect(themes[1].id, 'purple_dark');
      expect(themes[2].id, 'purple_dominant');
    });

    test('Creating Purple gradient', () {
      final gradient = PurpleThemeCreator.createPurpleGradient();

      expect(gradient, isA<LinearGradient>());
      expect(gradient.colors.length, 2);
      expect(gradient.colors[0], PurpleThemeCreator.purpleColor);
    });

    test('Getting complementary colors', () {
      final colors = PurpleThemeCreator.getComplementaryColors();

      expect(colors.length, 5);
      expect(colors[0], const Color(0xFF4d2962)); // Main color
      // ignore: unnecessary_type_check
      expect(colors.every((color) => color is Color), true);
    });

    test('Getting color info', () {
      final colorInfo = PurpleThemeCreator.getColorInfo();

      expect(colorInfo, isA<Map<String, String>>());
      expect(colorInfo['hex'], '#4d2962');
      expect(colorInfo['name'], 'Deep Purple');
    });

    test('Creating Purple color scheme', () {
      final colorScheme = PurpleThemeCreator.createPurpleColorScheme();

      expect(colorScheme, isA<ColorScheme>());
      expect(colorScheme.primary, PurpleThemeCreator.purpleColor);
      expect(colorScheme.brightness, Brightness.light);
    });
  });
}
