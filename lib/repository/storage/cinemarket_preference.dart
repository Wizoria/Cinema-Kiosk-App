import 'package:shared_preferences/shared_preferences.dart';

class CinemarketPreference {
  static const cinemarketOn = 'cinemarketOn';

  setCinemarketSetting(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(cinemarketOn, value);
  }
  Future<bool> getCinemarketSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(cinemarketOn) ?? false;
  }
}