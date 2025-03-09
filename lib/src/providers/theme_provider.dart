import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/app_theme.dart';

/// Provider để quản lý theme và cung cấp cho toàn bộ ứng dụng
class ThemeProvider extends ChangeNotifier {
  static ThemeProvider? _instance;

  /// Danh sách các theme có sẵn
  List<AppTheme> _themes = [];

  /// Theme hiện tại đang được sử dụng
  late AppTheme _currentTheme;

  /// ID của theme mặc định
  String _defaultThemeId = 'light';

  /// Cờ sử dụng Material 3
  bool _useMaterial3 = true;

  /// Singleton instance
  static ThemeProvider get instance {
    if (_instance == null) {
      throw Exception(
        'ThemeProvider chưa được khởi tạo. Hãy gọi ThemeProvider.initialize() trước.',
      );
    }
    return _instance!;
  }

  /// Khởi tạo ThemeProvider với các theme và cài đặt mặc định
  static Future<void> initialize({
    required List<AppTheme> themes,
    String defaultThemeId = 'light',
    bool useMaterial3 = true,
  }) async {
    if (_instance != null) {
      return;
    }

    _instance = ThemeProvider._internal(
      themes: themes,
      defaultThemeId: defaultThemeId,
      useMaterial3: useMaterial3,
    );

    await _instance!._loadSavedTheme();
  }

  /// Constructor nội bộ
  ThemeProvider._internal({
    required List<AppTheme> themes,
    required String defaultThemeId,
    required bool useMaterial3,
  }) {
    _themes = themes;
    _defaultThemeId = defaultThemeId;
    _useMaterial3 = useMaterial3;

    // Nếu không tìm thấy theme mặc định, sử dụng theme đầu tiên hoặc tạo light theme mới
    AppTheme? defaultTheme = _findThemeById(defaultThemeId);
    _currentTheme =
        defaultTheme ?? (themes.isNotEmpty ? themes.first : AppTheme.light());

    // Thêm theme mặc định nếu chưa có trong danh sách
    if (defaultTheme == null &&
        _defaultThemeId == 'light' &&
        themes.isNotEmpty) {
      _themes.add(AppTheme.light());
    }
  }

  /// Danh sách các theme có sẵn
  List<AppTheme> get themes => List.unmodifiable(_themes);

  /// Theme hiện tại đang được sử dụng
  AppTheme get currentTheme => _currentTheme;

  /// ThemeData hiện tại để sử dụng với MaterialApp
  ThemeData get themeData =>
      _currentTheme.toThemeData(useMaterial3: _useMaterial3);

  /// Theme mode hiện tại (sáng/tối/hệ thống)
  ThemeMode get themeMode => _currentTheme.themeMode;

  /// Cờ sử dụng Material 3
  bool get useMaterial3 => _useMaterial3;
  set useMaterial3(bool value) {
    _useMaterial3 = value;
    notifyListeners();
  }

  /// Thay đổi theme dựa trên ID
  Future<void> setTheme(String themeId) async {
    final theme = _findThemeById(themeId);
    if (theme != null) {
      _currentTheme = theme;
      notifyListeners();
      await saveThemeSettings();
    }
  }

  /// Thêm theme mới vào danh sách
  void addTheme(AppTheme theme) {
    // Kiểm tra xem theme đã tồn tại chưa
    final existingIndex = _themes.indexWhere((t) => t.id == theme.id);

    if (existingIndex >= 0) {
      // Nếu đã tồn tại, cập nhật theme đó
      _themes[existingIndex] = theme;

      // Nếu theme hiện tại bị thay đổi, cập nhật nó
      if (_currentTheme.id == theme.id) {
        _currentTheme = theme;
      }
    } else {
      // Nếu chưa tồn tại, thêm vào danh sách
      _themes.add(theme);
    }

    notifyListeners();
  }

  /// Xóa theme khỏi danh sách
  void removeTheme(String themeId) {
    // Không cho phép xóa theme hiện tại đang sử dụng
    if (_currentTheme.id == themeId) {
      return;
    }

    _themes.removeWhere((theme) => theme.id == themeId);
    notifyListeners();
  }

  /// Cập nhật theme hiện tại
  void updateCurrentTheme({
    String? name,
    Color? primaryColor,
    Color? accentColor,
    Color? backgroundColor,
    Color? textColor,
    String? fontFamily,
  }) {
    _currentTheme = _currentTheme.copyWith(
      name: name,
      primaryColor: primaryColor,
      accentColor: accentColor,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontFamily: fontFamily,
    );

    // Cập nhật theme trong danh sách
    final index = _themes.indexWhere((t) => t.id == _currentTheme.id);
    if (index >= 0) {
      _themes[index] = _currentTheme;
    }

    notifyListeners();
  }

  /// Lưu cài đặt theme hiện tại
  Future<void> saveThemeSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('current_theme_id', _currentTheme.id);
    await prefs.setString(
      'current_theme_data',
      jsonEncode(_currentTheme.toMap()),
    );
  }

  /// Tìm theme dựa trên ID
  AppTheme? _findThemeById(String id) {
    try {
      return _themes.firstWhere((theme) => theme.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Tải theme đã lưu từ SharedPreferences
  Future<void> _loadSavedTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedThemeId = prefs.getString('current_theme_id');

      if (savedThemeId != null) {
        final savedThemeData = prefs.getString('current_theme_data');

        if (savedThemeData != null) {
          // Tạo theme từ dữ liệu đã lưu
          final themeMap = jsonDecode(savedThemeData) as Map<String, dynamic>;
          final savedTheme = AppTheme.fromMap(themeMap);

          // Cập nhật theme hiện tại
          _currentTheme = savedTheme;

          // Cập nhật hoặc thêm vào danh sách themes
          final existingIndex = _themes.indexWhere(
            (t) => t.id == savedTheme.id,
          );
          if (existingIndex >= 0) {
            _themes[existingIndex] = savedTheme;
          } else {
            _themes.add(savedTheme);
          }

          notifyListeners();
        } else {
          // Nếu không có dữ liệu theme nhưng có ID, tìm theme đó trong danh sách
          final theme = _findThemeById(savedThemeId);
          if (theme != null) {
            _currentTheme = theme;
            notifyListeners();
          }
        }
      }
    } catch (e) {
      debugPrint('Lỗi khi tải theme đã lưu: $e');
    }
  }

  /// Tạo ChangeNotifierProvider cho ThemeProvider
  static Widget create({required Widget child}) {
    return ChangeNotifierProvider<ThemeProvider>.value(
      value: ThemeProvider.instance,
      child: child,
    );
  }

  /// Lấy ThemeProvider từ context
  static ThemeProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<ThemeProvider>(context, listen: listen);
  }
}
