import 'package:cinema_kiosk_app/navigation/nav_router.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../models/presence_model.dart';
import '../../../service/app_manager.dart';
import '../../styles/styles.dart';
import '../../themes/themes.dart';
import 'advertising_posters_model.dart';

class AdvertisingPostersBuyNowButton extends StatelessWidget {
  const AdvertisingPostersBuyNowButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AdvertisingPostersModel>(
      builder: (context, value, child) {
        return GradientButton(
          width: adaptWidgetWidth(260),
          height: adaptWidgetHeight(70),
          margin: EdgeInsets.only(
              bottom: adaptWidgetHeight(70), top: adaptWidgetHeight(50)),
          borderWidth: adaptWidgetWidth(3),
          borderRadius: BorderRadius.circular(adaptWidgetWidth(75)),
          borderGradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.onPrimary,
            ],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primaryContainer,
              Theme.of(context).colorScheme.onPrimaryContainer,
            ],
            begin: FractionalOffset.centerLeft,
            end: FractionalOffset.centerRight,
          ),
          onPressed: () {
            PresenceModel().timerStart();
            value.timerOff();
            AppManager().currentScreenIndex = 0;
            GoRouter.of(context).pushNamed(schedule);
          },
          child: Text(
            AppLocalizations.of(context)!.buyNow,
            style:
                Theme.of(context).textTheme.displayLarge?.apply(color: white),
          ),
        );
      },
    );
  }
}
