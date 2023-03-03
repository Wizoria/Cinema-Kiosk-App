import 'package:cinema_kiosk_app/ui/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../models/check_model.dart';
import '../../service/common_functions.dart';
import '../themes/themes.dart';

class BottomNavigationButtons extends StatelessWidget {
  final bool showButtonNext;
  final bool clear;
  final bool skip;
  final bool payment;
  final VoidCallback? onPressClear;
  final VoidCallback? onPressBack;
  final VoidCallback? onPressNext;
  final VoidCallback? onPressSkip;
  final VoidCallback? onPressPayment;

  const BottomNavigationButtons({
    super.key,
    this.showButtonNext = false,
    this.clear = false,
    this.skip = false,
    this.payment = false,
    this.onPressClear,
    this.onPressBack,
    this.onPressNext,
    this.onPressSkip,
    this.onPressPayment,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          left: adaptWidgetWidth(65),
          right: adaptWidgetWidth(65),
          bottom: adaptWidgetHeight(14)),
      width: double.maxFinite,
      height: adaptWidgetHeight(120),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(adaptWidgetHeight(25)),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          clear
              ? Container(
                  width: adaptWidgetWidth(420),
                  height: adaptWidgetHeight(70),
                  margin:
                      EdgeInsets.symmetric(horizontal: adaptWidgetWidth(23)),
                  child: MaterialButton(
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: adaptWidgetWidth(1),
                            color:
                                Theme.of(context).colorScheme.inverseSurface),
                        borderRadius: BorderRadius.circular(40)),
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: onPressClear,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            color: Theme.of(context).colorScheme.outline,
                            "assets/icons/clear.svg",
                            height: adaptWidgetHeight(18),
                            fit: BoxFit.contain),
                        SizedBox(
                          width: adaptWidgetWidth(12),
                        ),
                        Text('Очистити вибір',
                            style: Theme.of(context).textTheme.displayMedium),
                      ],
                    ),
                  ),
                )
              : Container(
                  width: adaptWidgetWidth(420),
                  height: adaptWidgetHeight(70),
                  margin:
                      EdgeInsets.symmetric(horizontal: adaptWidgetWidth(23)),
                  child: MaterialButton(
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: adaptWidgetWidth(1),
                            color:
                                Theme.of(context).colorScheme.inverseSurface),
                        borderRadius: BorderRadius.circular(40)),
                    color: Theme.of(context).colorScheme.onSecondary,
                    onPressed: onPressBack,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                            color: Theme.of(context).colorScheme.outline,
                            "assets/icons/arrow_back.svg",
                            width: adaptWidgetWidth(20),
                            fit: BoxFit.contain),
                        SizedBox(
                          width: adaptWidgetWidth(12),
                        ),
                        Text('Назад',
                            style: Theme.of(context).textTheme.displayMedium),
                      ],
                    ),
                  ),
                ),
          showButtonNext
              ? GradientButton(
                  width: adaptWidgetWidth(420),
                  height: adaptWidgetHeight(70),
                  margin:
                      EdgeInsets.symmetric(horizontal: adaptWidgetWidth(23)),
                  borderWidth: 2,
                  borderRadius: BorderRadius.circular(40),
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
                  onPressed: onPressNext,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Consumer<CheckModel>(builder: (context, value, child) {
                        return Text('До сплати ${value.total} ₴',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .apply(color: white));
                      }),
                      SizedBox(
                        width: adaptWidgetWidth(12),
                      ),
                      SvgPicture.asset("assets/icons/arrow_next.svg",
                          width: adaptWidgetWidth(20), fit: BoxFit.contain),
                    ],
                  ),
                )
              : skip
                  ? Container(
                      width: adaptWidgetWidth(420),
                      height: adaptWidgetHeight(70),
                      margin: EdgeInsets.symmetric(
                          horizontal: adaptWidgetWidth(23)),
                      child: MaterialButton(
                        elevation: 0,
                        hoverElevation: 0,
                        focusElevation: 0,
                        highlightElevation: 0,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: adaptWidgetWidth(1),
                                color: Theme.of(context)
                                    .colorScheme
                                    .inverseSurface),
                            borderRadius: BorderRadius.circular(40)),
                        color: Theme.of(context).colorScheme.onSecondary,
                        onPressed: onPressSkip,
                        child: Text('Пропустити',
                            style: Theme.of(context).textTheme.displayMedium),
                      ),
                    )
                  : payment
                      ? GradientButton(
                          width: adaptWidgetWidth(420),
                          height: adaptWidgetHeight(70),
                          margin: EdgeInsets.symmetric(
                              horizontal: adaptWidgetWidth(23)),
                          borderWidth: 2,
                          borderRadius: BorderRadius.circular(40),
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
                          onPressed: onPressPayment,
                          child: Consumer<CheckModel>(
                              builder: (context, value, child) {
                            return Text('Сплатити ${value.total} ₴',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: white));
                          }),
                        )
                      : const SizedBox(),
        ],
      ),
    );
  }
}
