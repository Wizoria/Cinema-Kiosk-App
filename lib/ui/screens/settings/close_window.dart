import 'dart:io';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class CloseWindow extends StatefulWidget {
  const CloseWindow({Key? key}) : super(key: key);

  @override
  State<CloseWindow> createState() => _CloseWindowState();
}

class _CloseWindowState extends State<CloseWindow> with WindowListener {
  @override
  Widget build(BuildContext context) {
    @override
    void onWindowClose() async {
      showDialog(
        useSafeArea: false,
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Закрити застосунок?'),
            actions: [
              TextButton(
                child: const Text('Ні'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Так'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  if (Platform.isWindows) {
                    await windowManager.destroy();
                  } else {
                    Future.delayed(const Duration(milliseconds: 1000), () {
                      exit(0);
                    });
                  }
                },
              ),
            ],
          );
        },
      );
    }

    return IconButton(
      onPressed: () => onWindowClose(),
      icon: const Icon(Icons.power_settings_new),
      color: Theme.of(context).colorScheme.primary,
      iconSize: adaptWidgetWidth(100),
    );
  }
}
