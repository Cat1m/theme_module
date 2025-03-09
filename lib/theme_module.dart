library;

import 'dart:ui';

import 'package:theme_module/theme_module.dart';

// Export tất cả các class và function chính
export 'src/models/app_theme.dart';
export 'src/models/theme_options.dart';
export 'src/providers/theme_provider.dart';
export 'src/widgets/theme_picker.dart';
export 'src/widgets/theme_preview.dart';
export 'src/utils/theme_utils.dart';

/// ThemeModule là class chính để khởi tạo và quản lý theme cho ứng dụng
class ThemeModule {
  /// Khởi tạo module với các theme mặc định
  static Future<void> initialize({
    required List<AppTheme> themes,
    String defaultThemeId = 'light',
    bool useMaterial3 = true,
  }) async {
    await ThemeProvider.initialize(
      themes: themes,
      defaultThemeId: defaultThemeId,
      useMaterial3: useMaterial3,
    );
  }

  /// Lấy theme provider instance
  static ThemeProvider get provider => ThemeProvider.instance;

  /// Tiện ích để thêm theme mới vào runtime
  static void addTheme(AppTheme theme) {
    ThemeProvider.instance.addTheme(theme);
  }

  /// Lưu các cài đặt theme hiện tại
  static Future<void> saveThemeSettings() async {
    await ThemeProvider.instance.saveThemeSettings();
  }

  /// Tạo các theme mặc định (light và dark)
  static List<AppTheme> createDefaultThemes({
    Color? primaryLight,
    Color? primaryDark,
    String? fontFamily,
  }) {
    return ThemeUtils.createDefaultThemes(
      primaryLight: primaryLight,
      primaryDark: primaryDark,
      fontFamily: fontFamily,
    );
  }
}
