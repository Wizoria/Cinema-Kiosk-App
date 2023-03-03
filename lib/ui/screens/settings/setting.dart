import 'dart:io';
import 'package:cinema_kiosk_app/ui/screens/settings/support_cinemas_list.dart';
import 'package:cinema_kiosk_app/ui/screens/settings/theme_radio_list.dart';
import 'package:cinema_kiosk_app/ui/screens/settings/windows_full_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/presence_model.dart';
import '../../../navigation/nav_router.dart';
import '../../components/bottom_navigation_buttons.dart';
import 'cinema_chains_radio_list.dart';
import 'cinemarket_setting.dart';
import 'close_window.dart';

class Settings extends StatelessWidget {
  const Settings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        PresenceModel().timerOff();
        GoRouter.of(context).goNamed(advertisingPoster);
        return false;
      },
      child: Material(
        // appBar: AppBar(title: const Text('Settings')),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                CloseWindow(),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Theme:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const ThemeRadioList(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Cinema Chain:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const CinemaChainsRadioList(),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Cinema:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SupportCinemasList(),
                  const SizedBox(
                    height: 10,
                  ),
                  if (Platform.isWindows) ...[
                    const Text(
                      'Screen settings:',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const WindowsFullScreen(),
                  ],
                  const Text(
                    'Cinemarket settings:',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const CinemarketSetting(),
                ],
              ),
            ),
            BottomNavigationButtons(
              onPressBack: () {
                GoRouter.of(context).goNamed(advertisingPoster);
              },
            ),
          ],
        ),
      ),
    );
  }
}
