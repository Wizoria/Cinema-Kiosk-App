import 'package:cinema_kiosk_app/models/environments/environment.dart';
import 'package:flutter/material.dart';
import '../repository/storage/cinemarket_preference.dart';
import '../repository/storage/theme_preference.dart';
import '../ui/screens/settings/cinema_settings.dart';

class AppManager {
  static AppManager? _appManager;

  AppManager._internal();
  factory AppManager() {
    _appManager ??= AppManager._internal();
    return _appManager!;
  }
  String _localizations = '';
  String get localizations => _localizations;

  set localizations(String value) {
    if (value == 'uk_UA') {
      _localizations = 'ua';
    } else if (value == 'en_US') {
      _localizations = 'en';
    } else {
      _localizations = 'en';
    }
  }

  // var navigatorKey;

  bool fullScreen = true;
  final double _kioskScreenHeight = 1920.0;
  final double _kioskScreenWidth = 1080.0;

  double _deviceScreenHeight = 1920;
  double _deviceScreenWidth = 1080;

  double get deviceScreenHeight => _deviceScreenHeight;
  double deviceToKioskAspectRatioHeight = 1;
  double deviceToKioskAspectRatioWidth = 1;

  final String _environment = Environment.PROD;

  String get environment => _environment;

  bool isDarkThemeOn = false;

  CinemaSettings cinemaSettings = CinemaSettings();
  String currentScreen = '';
  int currentScreenIndex = 0;
  bool cinemarketOn = false;
  UniqueKey uniqueKeyOnSale = UniqueKey();

  // int cinemaChainId = 0;
  // int cinemaId = 0;
  // String cinemaChainName = '';
  // String cinemaName = '';
  //
  // Map<int, String> cinemaChains = {1: "Wizoria", 2: "Cinema Citi"};

  setDeviceScreenParameters(double height, double width) {
    _deviceScreenHeight = height;
    _deviceScreenWidth = width;

    deviceToKioskAspectRatioHeight = _deviceScreenHeight / _kioskScreenHeight;
    deviceToKioskAspectRatioWidth = _deviceScreenWidth / _kioskScreenWidth;
  }

  Future<void> restoreAppSettingsFromSharedPreferences() async {
    cinemaSettings.restoreCinemaSettingsFromSharedPreferences();

    ThemePreference themePreference = ThemePreference();
    isDarkThemeOn = await themePreference.getTheme();

    CinemarketPreference cinemarketPreference = CinemarketPreference();
    cinemarketOn = await cinemarketPreference.getCinemarketSetting();
  }

  double get deviceScreenWidth => _deviceScreenWidth;


// Future<void> restoreCinemaSettingsFromSharedPreferences() async {
  //   CinemaPreference cinemaPreference = CinemaPreference();
  //   cinemaId = await cinemaPreference.getCinemaId();
  //   cinemaChainId = await cinemaPreference.getCinemaChainId();
  //   cinemaName = await cinemaPreference.getCinemaName();
  //   cinemaChainName = await cinemaPreference.getCinemaChainName();
  //
  //   ThemePreference themePreference = ThemePreference();
  //   isDarkThemeOn = await themePreference.getTheme();
  //
  //   if (cinemaId == 0) {
  //     cinemaId = 2;
  //   }
  //   if (cinemaChainId == 0) {
  //     cinemaChainId = 1;
  //   }
  //   if (cinemaChainName == '') {
  //     cinemaChainName = 'Wizoria';
  //   }
  //   if (cinemaName == '') {
  //     cinemaName = 'Wizoria Kyiv';
  //   }
  // }
late BuildContext context;
}
