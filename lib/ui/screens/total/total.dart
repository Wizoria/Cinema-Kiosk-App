import 'dart:convert';
import 'dart:developer';
import 'package:cinema_kiosk_app/ui/screens/total/total_list.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/check_model.dart';
import '../../components/bottom_navigation_buttons.dart';
import '../../components/main_header.dart';

class Total extends StatelessWidget {
  final int sessionId;

  const Total({
    Key? key,
    this.sessionId = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const MainHeader(showCloseButton: true),
          TotalList(sessionId: sessionId),
          BottomNavigationButtons(
            onPressBack: () => GoRouter.of(context).pop(),
            payment: true,
            onPressPayment: () {
              String json = jsonEncode(CheckModel().formJsonFunction());
              log('json $json');
            },
          )
        ],
      ),
    );
  }
}
