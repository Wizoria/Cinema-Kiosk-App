import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:flutter/material.dart';
import '../../../repository/storage/cinemarket_preference.dart';

class CinemarketSetting extends StatefulWidget {
  const CinemarketSetting({Key? key}) : super(key: key);

  @override
  State<CinemarketSetting> createState() => _CinemarketSetting();
}

class _CinemarketSetting extends State<CinemarketSetting> {
  @override
  Widget build(BuildContext context) {
    void cinemarketFunction() async {
      if (mounted) {
        showDialog(
          useSafeArea: false,
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(AppManager().cinemarketOn
                  ? 'Заблокувати кіномаркет?'
                  : 'Розблокувати кіномаркет?'),
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
                    CinemarketPreference cinemarketPreference =
                        CinemarketPreference();
                    cinemarketPreference.setCinemarketSetting(
                        AppManager().cinemarketOn = !AppManager().cinemarketOn);
                    Navigator.of(context).pop();
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
      value: AppManager().cinemarketOn,
      controlAffinity: ListTileControlAffinity.leading, //checkbox at left
      onChanged: (bool? value) {
        cinemarketFunction();
      },
      title: AppManager().cinemarketOn
          ? const Text("Cinemarket On")
          : const Text("Cinemarket Off"),
    );
  }
}
