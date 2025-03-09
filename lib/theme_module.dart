library;

import 'package:flutter/material.dart';
import 'package:theme_module/theme_module.dart';

// Export tất cả các class và function chính
export 'src/models/app_theme.dart';
export 'src/models/theme_options.dart';
export 'src/providers/theme_provider.dart';
export 'src/utils/purple_theme_creator.dart';

/// ThemeModule là class chính để khởi tạo và quản lý theme cho ứng dụng,
/// tập trung vào theme Deep Purple (#4d2962) và các biến thể của nó.
class ThemeModule {
  /// Khởi tạo module với Purple theme
  static Future<void> initialize({
    String defaultThemeId = 'purple_light',
    bool useMaterial3 = true,
    String? fontFamily,
  }) async {
    // Luôn sử dụng Purple themes
    final purpleThemes = PurpleThemeCreator.createPurpleThemes(
      fontFamily: fontFamily,
    );

    await ThemeProvider.initialize(
      themes: purpleThemes,
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

  /// Màu tím chính - Deep Purple (#4d2962)
  static Color get purpleColor => PurpleThemeCreator.purpleColor;
}
