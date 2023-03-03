import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/presence_model.dart';
import '../../../navigation/nav_router.dart';
import '../../../service/app_manager.dart';
import '../../components/bottom_menu.dart';
import '../../components/bottom_navigation_buttons.dart';
import '../../components/main_header.dart';
import 'cinemarket_list.dart';
import 'cinemarket_model.dart';

class Cinemarket extends StatelessWidget {
  final int sessionId;

  const Cinemarket({Key? key, required this.sessionId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      PresenceModel().timerOff();
      CinemarketModel().resetSelectedNomenclature();
    }
    AppManager().currentScreen = GoRouterState.of(context).name!;
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MainHeader(showCloseButton: true),
          CinemarketList(sessionId: sessionId),
          Consumer<CinemarketModel>(
            builder: (context, value, child) {
              return sessionId != 0 || value.selectedProducts.isNotEmpty
                  ? BottomNavigationButtons(
                      onPressClear: () => value.resetSelectedNomenclature(),
                      onPressBack: () => GoRouter.of(context).pop(),
                      clear: sessionId == 0,
                      showButtonNext: true,
                      onPressNext: () {
                        if (AppManager().currentScreenIndex == 0) {
                          GoRouter.of(context).goNamed(
                              scTiCinemarketForAuthorization,
                              params: {"sessionId": sessionId.toString()});
                        } else if (AppManager().currentScreenIndex == 1) {
                          GoRouter.of(context).goNamed(
                              onTiCinemarketForAuthorization,
                              params: {"sessionId": sessionId.toString()});
                        } else if (AppManager().currentScreenIndex == 2) {
                          GoRouter.of(context).goNamed(
                              cinemarketForAuthorization,
                              params: {"sessionId": sessionId.toString()});
                        }
                      },
                    )
                  : const BottomMenu();
            },
          ),
        ],
      ),
    );
  }
}
