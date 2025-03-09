import 'package:flutter/material.dart';
import '../models/app_theme.dart';
import '../models/theme_options.dart';

/// Các tiện ích hỗ trợ cho việc tạo và xử lý theme
class ThemeUtils {
  /// Tạo theme Deep Space dựa trên gradient màu xanh-tím
  static AppTheme createDeepSpaceTheme({
    String id = 'deep_space',
    String name = 'Deep Space',
    String? fontFamily,
  }) {
    // Các màu từ palette Deep Space
    const Color deepBlue = Color(0xFF112C71);
    const Color darkCyan = Color(0xFF0A4235);
    const Color brightCyan = Color(0xFF56E1E9);
    const Color periwinkle = Color(0xFF5B58EB);
    const Color lavender = Color(0xFFBB63FF);

    return AppTheme(
      id: id,
      name: name,
      description:
          'Gradient từ xanh dương đến tím theo phong cách vũ trụ sâu thẳm',
      themeMode: ThemeMode.dark,
      primaryColor: brightCyan,
      accentColor: lavender,
      backgroundColor: deepBlue,
      textColor: Colors.white,
      fontFamily: fontFamily,
      options: ThemeOptions(
        borderRadius: 12.0,
        cardElevation: 4.0,
        appBarElevation: 0.0,
      ),
    );
  }

  /// Tạo danh sách các theme mặc định (light và dark)
  static List<AppTheme> createDefaultThemes({
    Color? primaryLight,
    Color? primaryDark,
    String? fontFamily,
  }) {
    return [
      AppTheme.light(
        primaryColor: primaryLight ?? const Color(0xFF2196F3),
        fontFamily: fontFamily,
      ),
      AppTheme.dark(
        primaryColor: primaryDark ?? const Color(0xFF1976D2),
        fontFamily: fontFamily,
      ),
    ];
  }

  /// Tạo danh sách theme với các màu sắc phổ biến
  static List<AppTheme> createColorfulThemes({String? fontFamily}) {
    return [
      // Light themes
      AppTheme.light(
        id: 'blue_light',
        name: 'Blue Light',
        primaryColor: Colors.blue,
        fontFamily: fontFamily,
      ),
      AppTheme.light(
        id: 'green_light',
        name: 'Green Light',
        primaryColor: Colors.green,
        fontFamily: fontFamily,
      ),
      AppTheme.light(
        id: 'purple_light',
        name: 'Purple Light',
        primaryColor: Colors.purple,
        fontFamily: fontFamily,
      ),
      AppTheme.light(
        id: 'orange_light',
        name: 'Orange Light',
        primaryColor: Colors.orange,
        fontFamily: fontFamily,
      ),

      // Dark themes
      AppTheme.dark(
        id: 'blue_dark',
        name: 'Blue Dark',
        primaryColor: Colors.blue[700]!,
        fontFamily: fontFamily,
      ),
      AppTheme.dark(
        id: 'green_dark',
        name: 'Green Dark',
        primaryColor: Colors.green[700]!,
        fontFamily: fontFamily,
      ),
      AppTheme.dark(
        id: 'purple_dark',
        name: 'Purple Dark',
        primaryColor: Colors.purple[700]!,
        fontFamily: fontFamily,
      ),
      AppTheme.dark(
        id: 'orange_dark',
        name: 'Orange Dark',
        primaryColor: Colors.orange[700]!,
        fontFamily: fontFamily,
      ),
    ];
  }

  /// Tạo theme với Material You dynamic colors
  /// Lưu ý: Chỉ hoạt động trên Android 12+ và cần có thêm dynamic_color package
  static AppTheme createDynamicColorTheme({
    required ColorScheme lightDynamicColor,
    required ColorScheme darkDynamicColor,
    String? fontFamily,
  }) {
    return AppTheme(
      id: 'dynamic',
      name: 'System Dynamic',
      description: 'Follows your system accent color',
      themeMode: ThemeMode.system,
      primaryColor: lightDynamicColor.primary,
      accentColor: lightDynamicColor.secondary,
      backgroundColor: lightDynamicColor.background,
      textColor: lightDynamicColor.onBackground,
      fontFamily: fontFamily,
      options: ThemeOptions(borderRadius: 16.0, cardElevation: 0.5),
    );
  }

  /// Chuyển đổi hex color string sang Color
  static Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Chuyển đổi Color sang hex string
  static String colorToHex(Color color, {bool withHashSign = true}) {
    String hex = color.value.toRadixString(16).padLeft(8, '0');
    if (hex.startsWith('ff')) {
      hex = hex.substring(2);
    }
    return withHashSign ? '#$hex' : hex;
  }

  /// Tạo các theme dựa trên Deep Space palette
  static List<AppTheme> createDeepSpaceThemes({String? fontFamily}) {
    // Các màu từ gradient Deep Space
    const Color deepBlue = Color(0xFF112C71);
    const Color darkCyan = Color(0xFF0A4235);
    const Color brightCyan = Color(0xFF56E1E9);
    const Color periwinkle = Color(0xFF5B58EB);
    const Color lavender = Color(0xFFBB63FF);

    return [
      // Deep Space Blue theme
      AppTheme(
        id: 'deep_space_blue',
        name: 'Deep Space Blue',
        description: 'Theme tối với tông màu xanh dương của vũ trụ',
        themeMode: ThemeMode.dark,
        primaryColor: brightCyan,
        accentColor: periwinkle,
        backgroundColor: deepBlue,
        textColor: Colors.white,
        fontFamily: fontFamily,
        options: ThemeOptions(borderRadius: 12.0, cardElevation: 2.0),
      ),

      // Deep Space Cyan theme
      AppTheme(
        id: 'deep_space_cyan',
        name: 'Deep Space Cyan',
        description: 'Theme tối với tông màu xanh ngọc của đại dương',
        themeMode: ThemeMode.dark,
        primaryColor: brightCyan,
        accentColor: periwinkle,
        backgroundColor: darkCyan,
        textColor: Colors.white,
        fontFamily: fontFamily,
        options: ThemeOptions(borderRadius: 12.0, cardElevation: 2.0),
      ),

      // Deep Space Purple theme
      AppTheme(
        id: 'deep_space_purple',
        name: 'Deep Space Purple',
        description: 'Theme tối với tông màu tím huyền bí',
        themeMode: ThemeMode.dark,
        primaryColor: periwinkle,
        accentColor: brightCyan,
        backgroundColor: Color(0xFF2A1B5D), // Tông tím đậm
        textColor: Colors.white,
        fontFamily: fontFamily,
        options: ThemeOptions(borderRadius: 12.0, cardElevation: 2.0),
      ),
    ];
  }
}
