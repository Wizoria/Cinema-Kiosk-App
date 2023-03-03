import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../navigation/nav_router.dart';
import '../service/app_manager.dart';
import '../service/common_functions.dart';

class PresenceModel with ChangeNotifier {
  static PresenceModel? _presenceModel;

  PresenceModel._internal();

  factory PresenceModel() {
    _presenceModel ??= PresenceModel._internal();
    return _presenceModel!;
  }

  Timer? _timer;
  int _waitTime = 60;
  bool isStart = false;
  bool openModal = false;

  void timerStart() {
    log('start');
    if (!isStart) {
      isStart = true;
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          _waitTime--;
          // print(_waitTime);
          if (_waitTime == 0 && !openModal) {
            _waitTime = 6;
            if (!openModal) {
              checkPresence();
              openModal = true;
            }
          } else if (_waitTime == 0 && openModal) {
            openModal = false;
            GoRouter.of(AppManager().context).goNamed(advertisingPoster);
            resetSession();
          }
        },
      );
    }
  }

  void updateTimer() {
    if (AppManager().currentScreen != '') {
      openModal = false;
      switch (AppManager().currentScreen) {
        case 'schedule':
          _waitTime = 200;
          return;
        case 'advertisingPosterForOnSale':
          _waitTime = 300;
          return;
        case 'onSale':
          _waitTime = 300;
          return;
        case 'cinemarket':
          _waitTime = 500;
          return;
        case 'coming_soon':
          _waitTime = 150;
          return;
        case 'loyalty':
          _waitTime = 5;
          return;
        case 'support':
          _waitTime = 40;
          return;
        default:
          _waitTime = 60;
      }
    }
  }

  void timerOff() {
    isStart = false;
    _timer?.cancel();
  }

  checkPresence() async {
    return await showDialog(
      useSafeArea: false,
      useRootNavigator: false,
      barrierDismissible: true,
      context: AppManager().context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            updateTimer();
            Navigator.pop(context);
            return false;
          },
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: AlertDialog(
              title: Text('Ви ще тут ?',
                  style: Theme.of(context).textTheme.titleSmall,
                  textAlign: TextAlign.center),
              content: const SizedBox(
                height: 40,
              ),
              actions: [
                Center(
                  child: MaterialButton(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Colors.deepPurpleAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60)),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Так',
                        style: Theme.of(context).textTheme.displayMedium),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
