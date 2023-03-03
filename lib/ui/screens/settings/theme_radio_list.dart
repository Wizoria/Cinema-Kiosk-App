import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes/theme_changer.dart';

class ThemeRadioList extends StatefulWidget {
  const ThemeRadioList({Key? key}) : super(key: key);

  @override
  State<ThemeRadioList> createState() => _ThemeRadioListState();
}

class _ThemeRadioListState extends State<ThemeRadioList> {
  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Column(
      children: [
        RadioListTile<ThemeMode>(
          title: const Text('Light Mode'),
          groupValue: themeChanger.getTheme,
          value: ThemeMode.light,
          onChanged: themeChanger.setTheme,
        ),
        RadioListTile<ThemeMode>(
          title: const Text('Dark Mode'),
          groupValue: themeChanger.getTheme,
          value: ThemeMode.dark,
          onChanged: themeChanger.setTheme,
        ),
      ],
    );
  }
}
