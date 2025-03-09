import 'package:flutter/material.dart';

/// Các tùy chọn bổ sung cho theme
class ThemeOptions {
  /// Độ cong của các góc
  final double borderRadius;

  /// Độ nâng của card
  final double cardElevation;

  /// Độ nâng của AppBar
  final double appBarElevation;

  /// Độ đậm của font chữ
  final FontWeight defaultFontWeight;

  /// Kích thước font chữ mặc định
  final double defaultFontSize;

  /// Padding mặc định
  final double defaultPadding;

  /// Constructor
  ThemeOptions({
    this.borderRadius = 8.0,
    this.cardElevation = 1.0,
    this.appBarElevation = 0.0,
    this.defaultFontWeight = FontWeight.normal,
    this.defaultFontSize = 14.0,
    this.defaultPadding = 16.0,
  });

  /// Tạo một bản sao với các thuộc tính cập nhật
  ThemeOptions copyWith({
    double? borderRadius,
    double? cardElevation,
    double? appBarElevation,
    FontWeight? defaultFontWeight,
    double? defaultFontSize,
    double? defaultPadding,
  }) {
    return ThemeOptions(
      borderRadius: borderRadius ?? this.borderRadius,
      cardElevation: cardElevation ?? this.cardElevation,
      appBarElevation: appBarElevation ?? this.appBarElevation,
      defaultFontWeight: defaultFontWeight ?? this.defaultFontWeight,
      defaultFontSize: defaultFontSize ?? this.defaultFontSize,
      defaultPadding: defaultPadding ?? this.defaultPadding,
    );
  }

  /// Tạo ThemeOptions từ Map
  factory ThemeOptions.fromMap(Map<String, dynamic> map) {
    return ThemeOptions(
      borderRadius: map['borderRadius'] ?? 8.0,
      cardElevation: map['cardElevation'] ?? 1.0,
      appBarElevation: map['appBarElevation'] ?? 0.0,
      defaultFontWeight: FontWeight.values[map['defaultFontWeight'] ?? 3],
      defaultFontSize: map['defaultFontSize'] ?? 14.0,
      defaultPadding: map['defaultPadding'] ?? 16.0,
    );
  }

  /// Chuyển đổi sang Map để lưu trữ
  Map<String, dynamic> toMap() {
    return {
      'borderRadius': borderRadius,
      'cardElevation': cardElevation,
      'appBarElevation': appBarElevation,
      'defaultFontWeight': defaultFontWeight.index,
      'defaultFontSize': defaultFontSize,
      'defaultPadding': defaultPadding,
    };
  }

  /// Tạo phong cách material có bo góc
  static ThemeOptions rounded({
    double borderRadius = 16.0,
    double cardElevation = 2.0,
  }) {
    return ThemeOptions(
      borderRadius: borderRadius,
      cardElevation: cardElevation,
    );
  }

  /// Tạo phong cách material phẳng
  static ThemeOptions flat({double borderRadius = 4.0}) {
    return ThemeOptions(
      borderRadius: borderRadius,
      cardElevation: 0.0,
      appBarElevation: 0.0,
    );
  }
}
