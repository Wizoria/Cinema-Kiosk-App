import '../../../repository/storage/cinema_preference.dart';
import 'cinema_chain_settings.dart';

class CinemaSettings {
  static CinemaSettings? _cinemaSettings;

  CinemaSettings._internal();
  factory CinemaSettings() {
    _cinemaSettings ??= CinemaSettings._internal();
    return _cinemaSettings!;
  }

  CinemaChainSettings cinemaChainSettings = CinemaChainSettings();

  // int cinemaChainId = 0;
  int cinemaId = 0;
  // String cinemaChainName = '';
  String cinemaName = '';

  // int _cinemaChainId;

  int get cinemaChainId => cinemaChainSettings.cinemaChainId;
  String get cinemaChainName => cinemaChainSettings.cinemaChainName;

  Map<int, String> cinemaChains = {1: "Wizoria", 2: "Cinema Citi"};

  Future<void> restoreCinemaSettingsFromSharedPreferences() async {
    CinemaPreference cinemaPreference = CinemaPreference();
    cinemaId = await cinemaPreference.getCinemaId();
    cinemaChainSettings.cinemaChainId = await cinemaPreference.getCinemaChainId();
    cinemaName = await cinemaPreference.getCinemaName();
    cinemaChainSettings.cinemaChainName = await cinemaPreference.getCinemaChainName();

    if (cinemaId == 0) {
      cinemaId = 2;
    }
    if (cinemaChainSettings.cinemaChainId == 0) {
      cinemaChainSettings.cinemaChainId = 1;
    }
    if (cinemaChainName == '') {
      cinemaChainSettings.cinemaChainName = 'Wizoria';
    }
    if (cinemaName == '') {
      cinemaName = 'Wizoria Kyiv';
    }
  }
}
