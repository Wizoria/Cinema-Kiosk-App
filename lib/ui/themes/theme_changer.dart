import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:flutter/material.dart';
import '../../repository/storage/theme_preference.dart';

class ThemeChanger with ChangeNotifier {
  ThemePreference themePreference = ThemePreference();
  // late var isDarkModeOn = themePreference.getTheme();

  // var _themeMode = (AppManager().isDarkThemeOn == true) ? ThemeMode.dark : ThemeMode.light;
  // get getTheme => _themeMode;
  get getTheme => (AppManager().isDarkThemeOn == true) ? ThemeMode.dark : ThemeMode.light;

  setTheme(themeMode) {
    // _themeMode = themeMode;

    bool isDarkModeOn = (themeMode == ThemeMode.light) ? false : true;
    AppManager().isDarkThemeOn = isDarkModeOn;
    themePreference.setDarkTheme(isDarkModeOn);

    notifyListeners();
  }

  updateTheme() {
    notifyListeners();
  }
}
