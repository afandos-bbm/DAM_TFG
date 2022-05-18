import 'package:cuevaDelRecambio/ui/themes/dark_theme.dart';
import 'package:cuevaDelRecambio/ui/themes/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _theme;
  bool _isDarkMode;
  bool get isDarkMode => _isDarkMode;

  ThemeProvider(bool darkMode) {
    _isDarkMode = darkMode;
    _theme =
        _isDarkMode ? DarkTheme.getDarkTheme() : LightTheme.getLightTheme();
    GetIt.I<SharedPreferences>().setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    _theme =
        _isDarkMode ? DarkTheme.getDarkTheme() : LightTheme.getLightTheme();
    GetIt.I<SharedPreferences>().setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  ThemeData get theme => _theme;
}
