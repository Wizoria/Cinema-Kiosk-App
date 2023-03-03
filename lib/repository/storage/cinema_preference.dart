import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CinemaPreference {
  static const cinemaId = "cinemaId";
  static const cinemaChainId = "cinemaChainId";
  static const cinemaName = "cinemaName";
  static const cinemaChainName = "cinemaChainName";

  setCinemaId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(cinemaId, value);
  }

  Future<int> getCinemaId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(cinemaId) ?? 0;
  }

  setCinemaChainId(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(cinemaChainId, value);
  }

  Future<int> getCinemaChainId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(cinemaChainId) ?? 0;
  }

  setCinemaName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cinemaName, value);
  }

  Future<String> getCinemaName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(cinemaName) ?? '';
  }

  setCinemaChainName(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(cinemaChainName, value);
  }

  Future<String> getCinemaChainName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(cinemaChainName) ?? '';
  }
}
