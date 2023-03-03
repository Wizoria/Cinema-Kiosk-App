import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:cinema_kiosk_app/navigation/nav_router.dart';
import 'package:intl/intl.dart';
import '../styles/styles.dart';

class MainHeader extends StatelessWidget {
  const MainHeader({
    Key? key,
    this.showCloseButton = false,
  }) : super(key: key);
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    // print(MediaQuery.of(context).size.width);
    // print(MediaQuery.of(context).size.height);
    //
    // print(adaptWidgetWidth(100));
    // print(adaptWidgetHeight(100));

    var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(74)),
      height: adaptWidgetHeight(120),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            flex: 25,
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: EdgeInsets.symmetric(vertical: adaptWidgetHeight(10)),
              child: const HeaderLogo(),
            ),
          ),
          Flexible(
            flex: 50,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: double.maxFinite,
              padding: EdgeInsets.zero,
              child: StreamBuilder(
                stream: Stream.periodic(const Duration(minutes: 1)),
                builder: (context, snapshot) {
                  String time = DateFormat('HH:mm ').format(DateTime.now());
                  String date =
                      DateFormat('E dd.MM', tag).format(DateTime.now());
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(time, style: Theme.of(context).textTheme.titleLarge),
                      Text(date,
                          style: Theme.of(context).textTheme.titleMedium),
                    ],
                  );
                },
              ),
            ),
          ),
          if (showCloseButton) ...[
            Flexible(
              flex: 25,
              child: MaterialButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                padding: EdgeInsets.zero,
                onPressed: () {
                  GoRouter.of(context).goNamed(advertisingPoster);
                  resetSession();
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                            width: adaptWidgetHeight(35),
                            height: adaptWidgetHeight(35),
                            "assets/icons/close.svg",
                            color: Theme.of(context).colorScheme.outline,
                            fit: BoxFit.contain),
                        SizedBox(
                          width: adaptWidgetWidth(10),
                        ),
                        Text(
                          'закрити',
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ] else if (!showCloseButton) ...[
            Flexible(flex: 25, child: Container())
          ],
        ],
      ),
    );
  }
}
