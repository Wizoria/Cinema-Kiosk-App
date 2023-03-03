import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/presence_model.dart';
import '../../../service/app_manager.dart';
import '../../components/bottom_menu.dart';
import '../../components/main_header.dart';
import 'coming_soon_list.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      PresenceModel().timerOff();
    }
    AppManager().currentScreen = GoRouterState.of(context).name!;
    return Material(
      child: Column(
        children: const [
          MainHeader(showCloseButton: true),
          Expanded(child: ComingSoonList()),
          BottomMenu(),
        ],
      ),
    );
  }
}
