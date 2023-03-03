import 'package:flutter/material.dart';
import '../repository/storage/theme_preference.dart';

class DarkThemeProvider with ChangeNotifier {
  ThemePreference darkThemePreference = ThemePreference();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setDarkTheme(value);
    notifyListeners();
  }
}
