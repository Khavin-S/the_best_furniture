import 'package:flutter/material.dart';

class MyTheme{
  static ThemeData lightTheme = ThemeData.light();
  static ThemeData darkTheme = ThemeData.dark();
  static ThemeData currentTheme(bool isDarkMode) {
  return isDarkMode ? darkTheme : lightTheme;
  }
}