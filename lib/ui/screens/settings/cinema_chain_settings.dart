import 'package:flutter/material.dart';

class CinemaChainSettings with ChangeNotifier {
  static CinemaChainSettings? _cinemaChainSettings;

  CinemaChainSettings._internal();

  factory CinemaChainSettings() {
    _cinemaChainSettings ??= CinemaChainSettings._internal();
    return _cinemaChainSettings!;
  }

  int cinemaChainId = 0;
  String cinemaChainName = '';

  updateCinemaList() {
    notifyListeners();
  }
}
