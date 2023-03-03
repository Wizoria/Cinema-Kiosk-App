import 'package:cinema_kiosk_app/ui/components/main_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/presence_model.dart';
import '../../../service/app_manager.dart';
import '../../components/bottom_menu.dart';
import 'movie_list_on_sale.dart';

class OnSale extends StatelessWidget {
  const OnSale({Key? key, this.movieOnSaleId = 0}) : super(key: key);
  final int movieOnSaleId;

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      PresenceModel().timerOff();
    }
    AppManager().currentScreen = GoRouterState.of(context).name!;
    return Material(
      child: Column(
        children: [
          const MainHeader(showCloseButton: true),
          Expanded(
            child: MovieListOnSale(movieOnSaleId: movieOnSaleId),
          ),
          const BottomMenu(),
        ],
      ),
    );
  }
}
