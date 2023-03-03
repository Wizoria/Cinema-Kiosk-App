import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:cinema_kiosk_app/ui/screens/schedule/session_list_schedule.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/presence_model.dart';
import '../../components/bottom_menu.dart';
import '../../components/main_header.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key? key}) : super(key: key);

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
          Expanded(child: SessionListSchedule()),
          BottomMenu(),
        ],
      ),
    );
  }
}
