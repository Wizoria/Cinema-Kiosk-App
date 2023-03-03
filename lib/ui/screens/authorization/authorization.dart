import 'package:cinema_kiosk_app/navigation/nav_router.dart';
import 'package:cinema_kiosk_app/ui/screens/authorization/test_input_number.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../service/app_manager.dart';
import '../../../service/common_functions.dart';
import '../../components/bottom_navigation_buttons.dart';
import '../../components/main_header.dart';
import '../schedule/session_list_element_schedule.dart';

class Authorization extends StatelessWidget {
  final int sessionId;

  const Authorization({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          const MainHeader(showCloseButton: true),
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: adaptWidgetWidth(65),
                      vertical: adaptWidgetHeight(30)),
                  child: sessionId != 0
                      ? MovieSchedule(
                          sessionId: sessionId,
                        )
                      : const SizedBox(),
                ),
                SizedBox(
                  height: adaptWidgetHeight(130),
                ),
                Container(
                  width: double.maxFinite,
                  height: adaptWidgetHeight(800),
                  padding: EdgeInsets.symmetric(
                      vertical: adaptWidgetWidth(58),
                      horizontal: adaptWidgetWidth(150)),
                  margin:
                      EdgeInsets.symmetric(horizontal: adaptWidgetWidth(65)),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius:
                          BorderRadius.circular(adaptWidgetWidth(20))),
                  child: Column(
                    children: [
                      Text('Авторизація',
                          style: Theme.of(context).textTheme.headlineLarge),
                      SizedBox(
                        height: adaptWidgetHeight(28),
                      ),
                      Text('Введіть свій номер телефону:',
                          style: Theme.of(context).textTheme.displayMedium),
                      SizedBox(
                        height: adaptWidgetHeight(20),
                      ),
                      Container(
                        width: adaptWidgetWidth(350),
                        height: adaptWidgetHeight(60),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: adaptWidgetWidth(1),
                                color: Theme.of(context).colorScheme.outline),
                            borderRadius: BorderRadius.circular(40)),
                        child:
                            const MyStatefulWidget(), // TODO Добавити ввід номеру телефону з валідацією для авторизації
                      ),
                      SizedBox(
                        height: adaptWidgetHeight(35),
                      ),
                      Text('або',
                          style: Theme.of(context).textTheme.displaySmall),
                      SizedBox(
                        height: adaptWidgetHeight(34),
                      ),
                      Text(
                        'Відскануйте QR-код учасника\n програми лояльності',
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: adaptWidgetHeight(34),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: adaptWidgetHeight(26)),
                            width: adaptWidgetWidth(210),
                            child: Column(
                              children: [
                                SvgPicture.asset(
                                    width: adaptWidgetWidth(58),
                                    AppManager().cinemaSettings.cinemaChainId ==
                                            1
                                        ? "assets/icons/wiz_icon.svg"
                                        : "assets/icons/cinema_icon.svg",
                                    fit: BoxFit.contain),
                                SizedBox(
                                  height: adaptWidgetHeight(8),
                                ),
                                Text(
                                  AppManager().cinemaSettings.cinemaChainId == 1
                                      ? 'Wizoria'
                                      : 'Cinema Citi',
                                  style:
                                      Theme.of(context).textTheme.displaySmall,
                                ),
                                SizedBox(
                                  height: adaptWidgetHeight(14),
                                ),
                                Text('відкрийте QR-код в\n мобільному додатку',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall,
                                    textAlign: TextAlign.center),
                                SizedBox(
                                  height: adaptWidgetHeight(40),
                                ),
                                Container(
                                  width: double.maxFinite,
                                  alignment: Alignment.centerRight,
                                  child: SvgPicture.asset(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      "assets/icons/loyalty_arrow_left.svg",
                                      width: adaptWidgetWidth(105),
                                      height: adaptWidgetHeight(105),
                                      fit: BoxFit.contain),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Image.asset(
                                fit: BoxFit.fitWidth,
                                AppManager().cinemaSettings.cinemaChainId == 1
                                    ? 'assets/images/img_phone_wiz.png'
                                    : 'assets/images/img_phone_cinema.png',
                                width: adaptWidgetWidth(170),
                                height: adaptWidgetHeight(340),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: adaptWidgetHeight(26)),
                            width: adaptWidgetWidth(210),
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  width: double.maxFinite,
                                  child: SvgPicture.asset(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      "assets/icons/loyalty_arrow_right.svg",
                                      width: adaptWidgetWidth(105),
                                      height: adaptWidgetHeight(105),
                                      fit: BoxFit.contain),
                                ),
                                SizedBox(
                                  height: adaptWidgetHeight(20),
                                ),
                                Text(
                                  'Піднесіть QR-код до\n зчитувача під екраном',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: adaptWidgetHeight(28),
                                ),
                                Text(
                                  'scanner',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Image.asset(
                                    width: adaptWidgetWidth(120),
                                    height: adaptWidgetHeight(70),
                                    "assets/images/scanner.png",
                                    fit: BoxFit.contain),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          BottomNavigationButtons(
            onPressBack: () => GoRouter.of(context).pop(),
            skip: true,
            onPressSkip: () {
              if (AppManager().currentScreenIndex == 0) {
                if (AppManager().cinemarketOn) {
                  GoRouter.of(context).goNamed(scTiCiAuthorizationForTotal,
                      params: {"sessionId": sessionId.toString()});
                } else {
                  GoRouter.of(context).goNamed(scTiAuthorizationForTotal,
                      params: {"sessionId": sessionId.toString()});
                }
              } else if (AppManager().currentScreenIndex == 1) {
                if (AppManager().cinemarketOn) {
                  GoRouter.of(context).goNamed(onTiCiAuthorizationForTotal,
                      params: {"sessionId": sessionId.toString()});
                } else {}
              } else if (AppManager().currentScreenIndex == 2) {
                GoRouter.of(context).goNamed(ciAuthorizationForTotal,
                    params: {"sessionId": sessionId.toString()});
              }
            },
          ),
        ],
      ),
    );
  }
}
