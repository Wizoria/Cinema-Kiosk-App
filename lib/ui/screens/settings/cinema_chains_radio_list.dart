import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../repository/storage/cinema_preference.dart';
import '../../../service/app_manager.dart';
import '../../themes/theme_changer.dart';

class CinemaChainsRadioList extends StatefulWidget {
  const CinemaChainsRadioList({Key? key}) : super(key: key);

  @override
  State<CinemaChainsRadioList> createState() => _CinemaChainsRadioListState();
}

class _CinemaChainsRadioListState extends State<CinemaChainsRadioList> {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Column(
      children: [
        RadioListTile(
          title: Text(
            AppManager().cinemaSettings.cinemaChains[1]!,
          ),
          groupValue: AppManager().cinemaSettings.cinemaChainId,
          value: 1,
          onChanged: (void value) {
            AppManager().cinemaSettings.cinemaChainSettings.cinemaChainId = 1;
            AppManager().cinemaSettings.cinemaChainSettings.cinemaChainName = AppManager().cinemaSettings.cinemaChains[1]!;
            CinemaPreference cinemaPreference = CinemaPreference();
            cinemaPreference.setCinemaChainId(1);
            cinemaPreference.setCinemaChainName(AppManager().cinemaSettings.cinemaChainName);
            setState(() {
              AppManager().cinemaSettings.cinemaChainSettings.updateCinemaList();
            });
            themeChanger.updateTheme();
            log(AppManager().cinemaSettings.cinemaChainId.toString());
          },
        ),
        RadioListTile(
          title: Text(
            AppManager().cinemaSettings.cinemaChains[2]!,
          ),
          groupValue: AppManager().cinemaSettings.cinemaChainId,
          value: 2,
          onChanged: (void value) {
            AppManager().cinemaSettings.cinemaChainSettings.cinemaChainId = 2;
            AppManager().cinemaSettings.cinemaChainSettings.cinemaChainName = AppManager().cinemaSettings.cinemaChains[2]!;
            CinemaPreference cinemaPreference = CinemaPreference();
            cinemaPreference.setCinemaChainId(2);
            cinemaPreference.setCinemaChainName(AppManager().cinemaSettings.cinemaChainName);
            setState(() {
              AppManager().cinemaSettings.cinemaChainSettings.updateCinemaList();
            });
            themeChanger.updateTheme();
            log(AppManager().cinemaSettings.cinemaChainId.toString());
          },
        ),
      ],
    );
  }
}
