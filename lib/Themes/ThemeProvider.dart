import 'package:flutter/material.dart';

class Themeprovider {
  static ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      surface: Colors.black,
      primary: Colors.grey.shade900,
      secondary: Colors.grey.shade800,
      onSurface: Colors.white,
    ),
  );

  static ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      surface: Colors.white,
      primary: Colors.grey.shade400,
      secondary: Colors.grey.shade600,
      onSurface: Colors.black,
    ),
  );

  static ThemeData getTheme(bool isThemeTypeDark) {
    return (isThemeTypeDark) ? _darkTheme : _lightTheme;
  }
}
