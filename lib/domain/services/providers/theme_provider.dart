import 'package:client_project/ui/themes/dark_theme.dart';
import 'package:client_project/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme;
  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider(bool darkMode) {
    _isDarkMode = darkMode;
    changeTheme();
  }

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    _theme =
        _isDarkMode ? DarkTheme.getDarkTheme() : LightTheme.getLightTheme();
    notifyListeners();
  }

  ThemeData get theme => _theme;
}
