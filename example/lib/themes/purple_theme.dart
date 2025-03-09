import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

/// Class tiện ích để tạo và quản lý theme với màu tím PANTONE #4d2962
class PurpleThemeCreator {
  /// Màu tím chính #4d2962
  static const Color purpleColor = Color(0xFF4d2962);

  /// Tạo các theme tím dựa trên màu #4d2962
  static List<AppTheme> createPurpleThemes({String? fontFamily}) {
    // Tạo các theme
    return [
      // Light theme with purple
      AppTheme(
        id: 'purple_light',
        name: 'Purple Light',
        description: 'Light theme with deep purple accent (#4d2962)',
        themeMode: ThemeMode.light,
        primaryColor: purpleColor,
        accentColor: _lightenColor(purpleColor, 0.2),
        backgroundColor: Colors.white,
        textColor: Colors.black87,
        fontFamily: fontFamily,
        options: ThemeOptions(
          borderRadius: 8.0,
          cardElevation: 1.0,
          appBarElevation: 0.0,
        ),
      ),

      // Dark theme with purple
      AppTheme(
        id: 'purple_dark',
        name: 'Purple Dark',
        description: 'Dark theme with deep purple accent (#4d2962)',
        themeMode: ThemeMode.dark,
        primaryColor: _lightenColor(purpleColor, 0.1),
        accentColor: _lightenColor(purpleColor, 0.3),
        backgroundColor: const Color(0xFF121212),
        textColor: Colors.white,
        fontFamily: fontFamily,
        options: ThemeOptions(
          borderRadius: 8.0,
          cardElevation: 1.0,
          appBarElevation: 0.0,
        ),
      ),

      // Purple dominant theme
      AppTheme(
        id: 'purple_dominant',
        name: 'Purple Dominant',
        description: 'Theme with dominant deep purple (#4d2962)',
        themeMode: ThemeMode.dark,
        primaryColor: _lightenColor(purpleColor, 0.1),
        accentColor: _lightenColor(purpleColor, 0.4),
        backgroundColor: purpleColor,
        textColor: Colors.white,
        fontFamily: fontFamily,
        options: ThemeOptions(
          borderRadius: 12.0,
          cardElevation: 4.0,
          appBarElevation: 0.0,
        ),
      ),
    ];
  }

  /// Tạo một màu gradient dựa trên màu purple
  static LinearGradient createPurpleGradient({bool reversed = false}) {
    final colors = [purpleColor, _lightenColor(purpleColor, 0.3)];

    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: reversed ? colors.reversed.toList() : colors,
    );
  }

  /// Tạo Color Scheme dựa trên purple theme
  static ColorScheme createPurpleColorScheme({bool isDark = false}) {
    return ColorScheme.fromSeed(
      seedColor: purpleColor,
      brightness: isDark ? Brightness.dark : Brightness.light,
      primary: purpleColor,
      secondary: _lightenColor(purpleColor, 0.2),
      tertiary: _lightenColor(purpleColor, 0.4),
    );
  }

  /// Làm sáng màu
  static Color _lightenColor(Color color, double amount) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    final hslLight = hsl.withLightness(
      (hsl.lightness + amount).clamp(0.0, 1.0),
    );
    return hslLight.toColor();
  }

  /// Màu phụ bổ sung
  static List<Color> getComplementaryColors() {
    // rgb(77,41,98) - HSL: 278°, 41%, 27%
    return [
      const Color(0xFF4d2962), // Màu chính
      const Color(0xFF7A5095), // Màu tím nhạt hơn
      const Color(0xFF2E1A3B), // Màu tím đậm hơn
      const Color(0xFFAF8FC8), // Màu lavender
      const Color(0xFF8247A4), // Màu tía
    ];
  }

  /// Chi tiết thông tin về màu
  static Map<String, String> getColorInfo() {
    return {
      'hex': '#4d2962',
      'rgb': 'rgb(77,41,98)',
      'hsl': 'hsl(278°, 41%, 27%)',
      'rgba': 'rgba(77,41,98,1.00)',
      'name': 'Deep Purple',
    };
  }
}
