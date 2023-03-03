import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cinema_kiosk_app/navigation/nav_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../service/app_manager.dart';
import '../styles/styles.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> buttonBar = [
      AppLocalizations.of(context)!.schedule,
      AppLocalizations.of(context)!.onSale,
      AppLocalizations.of(context)!.cinemarket,
      AppLocalizations.of(context)!.comingSoon,
      AppLocalizations.of(context)!.loyalty,
      AppLocalizations.of(context)!.support,
    ];

    void callbackNavigationButton(int index) {
      AppManager().currentScreenIndex = index;
      switch (AppManager().currentScreenIndex) {
        case 0:
          return GoRouter.of(context).goNamed(schedule);
        case 1:
          return GoRouter.of(context).goNamed(onSale);
        case 2:
          return GoRouter.of(context)
              .goNamed(cinemarket, params: {"sessionId": '0'});
        case 3:
          return GoRouter.of(context).goNamed(comingSoon);
        case 4:
          return GoRouter.of(context).goNamed(loyalty);
        case 5:
          return GoRouter.of(context).goNamed(support);
      }
    }

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          boxShadow: [
            BoxShadow(
              // color: Colors.white.withOpacity(0.06),
              color: AppManager().isDarkThemeOn
                  ? const Color.fromRGBO(21, 21, 21, 0.5)
                  : const Color.fromRGBO(184, 184, 184, 0.2),
              spreadRadius: 6,
              blurRadius: 12,
            ),
          ]),
      padding: EdgeInsets.symmetric(vertical: adaptWidgetHeight(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          buttonBar.length,
          (index) => AppManager().cinemarketOn
              ? Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: adaptWidgetWidth(7)),
                  child: SizedBox(
                    width: adaptWidgetWidth(145),
                    height: adaptWidgetWidth(145),
                    child: BottomMenuButton(
                      text: buttonBar[index],
                      isActive: AppManager().currentScreenIndex == index,
                      onPressed: () => callbackNavigationButton(index),
                    ),
                  ),
                )
              : index != 2
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: adaptWidgetWidth(7)),
                      child: SizedBox(
                        width: adaptWidgetWidth(145),
                        height: adaptWidgetWidth(145),
                        child: BottomMenuButton(
                          text: buttonBar[index],
                          isActive: AppManager().currentScreenIndex == index,
                          onPressed: () => callbackNavigationButton(index),
                        ),
                      ),
                    )
                  : const SizedBox(),
        ),
      ),
    );
  }
}
