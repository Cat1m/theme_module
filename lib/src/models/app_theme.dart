// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'theme_options.dart';

/// Class chính đại diện cho một theme trong ứng dụng
class AppTheme {
  /// ID duy nhất của theme
  final String id;

  /// Tên hiển thị của theme
  final String name;

  /// Mô tả ngắn về theme (tùy chọn)
  final String? description;

  /// Chế độ sáng/tối
  final ThemeMode themeMode;

  /// Màu chính của theme
  final Color primaryColor;

  /// Màu accent (tùy chọn)
  final Color? accentColor;

  /// Màu nền chính
  final Color backgroundColor;

  /// Màu văn bản chính
  final Color textColor;

  /// Font chữ (tùy chọn)
  final String? fontFamily;

  /// Các tùy chọn theme bổ sung
  final ThemeOptions options;

  /// Constructor
  AppTheme({
    required this.id,
    required this.name,
    this.description,
    required this.themeMode,
    required this.primaryColor,
    this.accentColor,
    required this.backgroundColor,
    required this.textColor,
    this.fontFamily,
    ThemeOptions? options,
  }) : options = options ?? ThemeOptions();

  /// Tạo một theme mặc định sáng
  factory AppTheme.light({
    String id = 'light',
    String name = 'Light',
    String? description,
    Color primaryColor = const Color(0xFF2196F3), // Blue
    Color? accentColor,
    Color backgroundColor = Colors.white,
    Color textColor = Colors.black87,
    String? fontFamily,
    ThemeOptions? options,
  }) {
    return AppTheme(
      id: id,
      name: name,
      description: description ?? 'Default light theme',
      themeMode: ThemeMode.light,
      primaryColor: primaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontFamily: fontFamily,
      options: options,
    );
  }

  /// Tạo một theme mặc định tối
  factory AppTheme.dark({
    String id = 'dark',
    String name = 'Dark',
    String? description,
    Color primaryColor = const Color(0xFF1976D2), // Darker blue
    Color? accentColor,
    Color backgroundColor = const Color(0xFF121212),
    Color textColor = Colors.white,
    String? fontFamily,
    ThemeOptions? options,
  }) {
    return AppTheme(
      id: id,
      name: name,
      description: description ?? 'Default dark theme',
      themeMode: ThemeMode.dark,
      primaryColor: primaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontFamily: fontFamily,
      options: options,
    );
  }

  /// Chuyển đổi AppTheme thành ThemeData để sử dụng với MaterialApp
  ThemeData toThemeData({bool useMaterial3 = true}) {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness:
          themeMode == ThemeMode.dark ? Brightness.dark : Brightness.light,
      primary: primaryColor,
      secondary: accentColor ?? primaryColor,
      surface: backgroundColor,
    );

    return ThemeData(
      useMaterial3: useMaterial3,
      colorScheme: colorScheme,
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: fontFamily,
      textTheme: _createTextTheme(textColor),
      elevatedButtonTheme: _createButtonTheme(colorScheme),
      cardTheme: CardTheme(
        elevation: options.cardElevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(options.borderRadius),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: _contrastColor(primaryColor),
        elevation: options.appBarElevation,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(options.borderRadius),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(options.borderRadius),
          borderSide: BorderSide(color: primaryColor.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(options.borderRadius),
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }

  /// Tạo một bản sao của theme với các thuộc tính cập nhật
  AppTheme copyWith({
    String? id,
    String? name,
    String? description,
    ThemeMode? themeMode,
    Color? primaryColor,
    Color? accentColor,
    Color? backgroundColor,
    Color? textColor,
    String? fontFamily,
    ThemeOptions? options,
  }) {
    return AppTheme(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      themeMode: themeMode ?? this.themeMode,
      primaryColor: primaryColor ?? this.primaryColor,
      accentColor: accentColor ?? this.accentColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      fontFamily: fontFamily ?? this.fontFamily,
      options: options ?? this.options,
    );
  }

  /// Tạo TextTheme từ màu văn bản chính
  TextTheme _createTextTheme(Color textColor) {
    return TextTheme(
      bodyLarge: TextStyle(color: textColor),
      bodyMedium: TextStyle(color: textColor),
      displayLarge: TextStyle(color: textColor),
      displayMedium: TextStyle(color: textColor),
      displaySmall: TextStyle(color: textColor),
      headlineMedium: TextStyle(color: textColor),
      titleLarge: TextStyle(color: textColor),
      titleMedium: TextStyle(color: textColor),
    );
  }

  /// Tạo style cho button dựa trên colorScheme
  ElevatedButtonThemeData _createButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: _contrastColor(colorScheme.primary),
        backgroundColor: colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(options.borderRadius),
        ),
      ),
    );
  }

  /// Tính toán màu tương phản cho text dựa trên màu nền
  Color _contrastColor(Color background) {
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  /// Chuyển thành Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'themeMode': themeMode.index,
      'primaryColor': primaryColor.value,
      'accentColor': accentColor?.value,
      'backgroundColor': backgroundColor.value,
      'textColor': textColor.value,
      'fontFamily': fontFamily,
      'options': options.toMap(),
    };
  }

  /// Tạo AppTheme từ Map
  factory AppTheme.fromMap(Map<String, dynamic> map) {
    return AppTheme(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      themeMode: ThemeMode.values[map['themeMode']],
      primaryColor: Color(map['primaryColor']),
      accentColor:
          map['accentColor'] != null ? Color(map['accentColor']) : null,
      backgroundColor: Color(map['backgroundColor']),
      textColor: Color(map['textColor']),
      fontFamily: map['fontFamily'],
      options:
          map['options'] != null
              ? ThemeOptions.fromMap(map['options'])
              : ThemeOptions(),
    );
  }
}
