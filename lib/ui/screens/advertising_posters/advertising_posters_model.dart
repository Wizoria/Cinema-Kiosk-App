import 'dart:async';
import 'package:flutter/cupertino.dart';

class AdvertisingPostersModel with ChangeNotifier {
  static AdvertisingPostersModel? _advertisingPostersModel;

  AdvertisingPostersModel._internal();

  factory AdvertisingPostersModel() {
    _advertisingPostersModel ??= AdvertisingPostersModel._internal();
    return _advertisingPostersModel!;
  }

  bool isTimer = false;
  final int _waitTimeInSec = 5;
  bool isAutoPlayEnabled = true;
  Timer? _timer;
  late int _waitTime;
  bool isStart = false;

  void timerOff() {
    isAutoPlayEnabled = true;
    _timer?.cancel();
    notifyListeners();
  }

  void start() {
    if (_waitTime > 0 && !isStart) {
      print('start');
      isStart = true;
      isTimer = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _waitTime--;
        print(_waitTime);
        if (_waitTime == 0) {
          pause();
          print('autoPlay ON');
          isTimer = false;
          isAutoPlayEnabled = true;
        } else if (_waitTime < 0) {
          print('error!!!');
          _timer?.cancel();
        }
      });
    }
  }

  void pause() {
    print('pause');
    _timer?.cancel();
    isStart = false;
    notifyListeners();
  }

  void pauseCarousel(event) {
    if (event == "Down") {
      isAutoPlayEnabled = false;
      if (isTimer) {
        pause();
      }
    } else if (event == "Up") {
      _waitTime = _waitTimeInSec;
      start();
      print('autoPlay OFF');
    }
    notifyListeners();
  }
}
