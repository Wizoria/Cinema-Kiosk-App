import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import '../../../service/common_functions.dart';

class WindowsFullScreen extends StatefulWidget {
  const WindowsFullScreen({Key? key}) : super(key: key);

  @override
  State<WindowsFullScreen> createState() => _WindowsFullScreenState();
}

class _WindowsFullScreenState extends State<WindowsFullScreen>
    with WindowListener {
  @override
  Widget build(BuildContext context) {
    void fullScreen() async {
      AppManager().fullScreen = await windowManager.isFullScreen();
      if (mounted) {
        showDialog(
          useSafeArea: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppManager().fullScreen
                  ? 'Вийти з повноекранного режиму?'
                  : 'Увімкнути повноекранний режим?'),
              actions: [
                TextButton(
                  child: const Text('Ні'),
                  onPressed: () {
                    print(
                        'Width ${AppManager().deviceToKioskAspectRatioWidth}');
                    print('Heigh ${adaptWidgetHeight(100)}');

                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Так'),
                  onPressed: () async {
                    AppManager().fullScreen = !AppManager().fullScreen;
                    Navigator.of(context).pop();
                    await windowManager.center(animate: true);
                    await windowManager.setFullScreen(AppManager().fullScreen);
                    await windowManager.setTitleBarStyle(AppManager().fullScreen
                        ? TitleBarStyle.hidden
                        : TitleBarStyle.normal);
                    setState(() {});
                  },
                ),
              ],
            );
          },
        );
      }
    }

    return CheckboxListTile(
      value: AppManager().fullScreen,
      controlAffinity: ListTileControlAffinity.leading, //checkbox at left
      onChanged: (bool? value) {
        fullScreen();
        setState(() {});
      },
      title: const Text("Full screen"),
    );
  }
}
