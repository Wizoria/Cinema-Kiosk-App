import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/ticket_reservation_time_model.dart';
import '../../service/app_manager.dart';
import '../../service/common_functions.dart';
import '../screens/cinemarket/cinemarket_model.dart';
import '../themes/theme_changer.dart';
import '../themes/themes.dart';
import 'gradient_box_border.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String logo;
    final themeChanger = Provider.of<ThemeChanger>(context);
    bool isDark = themeChanger.getTheme == ThemeMode.dark;
    if (AppManager().cinemaSettings.cinemaChainId == 1) {
      if (isDark) {
        logo = "assets/icons/wiz_logo_night.svg";
      } else {
        logo = "assets/icons/wiz_logo_day.svg";
      }
    } else {
      logo = "assets/icons/cinema_logo.svg";
    }

    return SvgPicture.asset(
        width: adaptWidgetWidth(100),
        logo,
        fit: BoxFit.contain);
  }
}

class GradientButton extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius borderRadius;
  final LinearGradient borderGradient;
  final Gradient gradient;
  final double width;
  final double height;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final VoidCallback? onPressed;

  const GradientButton({
    super.key,
    required this.child,
    this.borderWidth = 0,
    this.borderRadius = BorderRadius.zero,
    required this.borderGradient,
    required this.gradient,
    this.width = 0,
    this.height = 0,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: GradientBoxBorder(width: borderWidth, gradient: borderGradient),
        gradient: gradient,
        borderRadius: borderRadius,
      ),
      child: MaterialButton(
        elevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        // minWidth: width,
        splashColor: transparent,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        padding: padding,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class BottomMenuButton extends StatelessWidget {
  final String text;
  final bool isActive;
  final Function() onPressed;

  const BottomMenuButton({
    super.key,
    required this.isActive,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      padding: EdgeInsets.all(
        adaptWidgetWidth(10),
      ),
      borderWidth: adaptWidgetWidth(3),
      borderRadius: BorderRadius.circular(adaptWidgetWidth(30)),
      borderGradient: LinearGradient(
        colors: [
          isActive ? Theme.of(context).colorScheme.primary : transparent,
          isActive ? Theme.of(context).colorScheme.onPrimary : transparent,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      gradient: LinearGradient(
        colors: [
          isActive
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          isActive
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.surface,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      onPressed: onPressed,
      child: Text(text,
          style: isActive
              ? Theme.of(context).textTheme.bodyMedium?.apply(color: white)
              : Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.apply(color: Theme.of(context).colorScheme.outline),
          textAlign: TextAlign.center),
    );
  }
}

class SessionDateButton extends StatelessWidget {
  final DateTime dateTime;
  final bool isActive;
  final Function() onPressed;

  const SessionDateButton({
    super.key,
    required this.dateTime,
    required this.isActive,
    required this.onPressed,
  });

  String dateTimeFunction(DateTime dateTime, var tag) {
    if (daysOfDatesEqualAreEqual(getCurrentDate(), dateTime)) {
      return 'Сьогодні';
    } else if (daysOfDatesEqualAreEqual(
        getCurrentDate().add(const Duration(days: 1)), dateTime)) {
      return 'Завтра';
    } else {
      return DateFormat('E dd.MM', tag).format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return GradientButton(
      borderWidth: adaptWidgetWidth(2),
      borderRadius: BorderRadius.circular(adaptWidgetWidth(35)),
      borderGradient: LinearGradient(
        colors: [
          isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          isActive
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.surface,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      gradient: LinearGradient(
        colors: [
          isActive
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          isActive
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.surface,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      onPressed: onPressed,
      child: Text(
        dateTimeFunction(dateTime, tag),
        style: isActive
            ? Theme.of(context).textTheme.bodySmall!.apply(color: white)
            : Theme.of(context)
                .textTheme
                .bodySmall!
                .apply(color: Theme.of(context).colorScheme.outline),
      ),
    );
  }
}

class MyCheckbox extends StatelessWidget {
  final String text;
  final int price;
  final bool isActive;
  final Function() onPressed;

  const MyCheckbox({
    super.key,
    required this.text,
    this.price = 0,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: adaptWidgetWidth(40), vertical: adaptWidgetHeight(30)),
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(adaptWidgetHeight(25))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MaterialButton(
            minWidth: adaptWidgetWidth(32),
            shape: const CircleBorder(),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            padding: const EdgeInsets.all(2),
            onPressed: onPressed,
            child: Container(
                alignment: Alignment.center,
                width: adaptWidgetWidth(32),
                height: adaptWidgetWidth(32),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                        width: adaptWidgetWidth(2),
                        color: Theme.of(context).colorScheme.primary)),
                child: isActive
                    ? Container(
                        width: double.maxFinite,
                        height: double.maxFinite,
                        padding: EdgeInsets.only(
                            top: adaptWidgetHeight(4),
                            left: adaptWidgetHeight(4),
                            right: adaptWidgetHeight(4)),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/icons/checked.svg",
                            fit: BoxFit.contain),
                      )
                    : const SizedBox()),
          ),
          SizedBox(
            width: adaptWidgetWidth(14),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                isActive
                    ? Text(
                        price == 0 ? '' : '$price ₴',
                        style: Theme.of(context).textTheme.bodyLarge,
                      )
                    : const Text(''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonPromo extends StatelessWidget {
  final bool isActive;
  final Function() onPressed;

  const ButtonPromo({
    super.key,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      width: adaptWidgetWidth(150),
      height: double.maxFinite,
      borderWidth: adaptWidgetWidth(2),
      borderRadius: BorderRadius.circular(adaptWidgetWidth(8)),
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
          isActive ? Theme.of(context).colorScheme.primary : transparent,
          isActive ? Theme.of(context).colorScheme.onPrimary : transparent,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      onPressed: onPressed,
      child: isActive
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('ok',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .apply(color: white)),
                SvgPicture.asset("assets/icons/checked.svg",
                    fit: BoxFit.contain),
              ],
            )
          : Text('застосувати',
              style: Theme.of(context)
                  .textTheme
                  .labelSmall!
                  .apply(color: AppManager().isDarkThemeOn ? white : black)),
    );
  }
}

class TicketReservationTime extends StatelessWidget {
  final String text;

  const TicketReservationTime({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: adaptWidgetHeight(22)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(text, style: Theme.of(context).textTheme.headlineLarge),
          Container(
            padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(46)),
            child: Column(
              children: [
                Text('резерв квитків:',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center),
                SizedBox(
                  height: adaptWidgetHeight(14),
                ),
                SizedBox(
                  width: adaptWidgetWidth(120),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                          color: Theme.of(context).colorScheme.outline,
                          "assets/icons/clock.svg",
                          width: adaptWidgetWidth(35),
                          fit: BoxFit.contain),
                      SizedBox(
                        width: adaptWidgetWidth(10),
                      ),
                      Consumer<TicketReservationTimeModel>(
                          builder: (context, value, child) {
                        return Text(
                            '${value.myDuration.inMinutes} : ${value.myDuration.inSeconds.remainder(60).toString().padLeft(2, "0")}',
                            style: Theme.of(context).textTheme.headlineMedium);
                      })
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CinemarketNomenclatureGroup extends StatelessWidget {
  final String name;
  final String image;
  final bool isActive;
  final Function() onPressed;

  const CinemarketNomenclatureGroup({
    super.key,
    required this.name,
    required this.image,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      width: adaptWidgetWidth(145),
      height: adaptWidgetWidth(145),
      margin: EdgeInsets.only(bottom: adaptWidgetHeight(15)),
      borderWidth: adaptWidgetWidth(2),
      borderRadius: BorderRadius.circular(adaptWidgetWidth(30)),
      borderGradient: LinearGradient(
        colors: [
          isActive ? Theme.of(context).colorScheme.primary : transparent,
          isActive ? Theme.of(context).colorScheme.onPrimary : transparent,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      gradient: LinearGradient(
        colors: [
          isActive
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surface,
          isActive
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.surface,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: adaptWidgetHeight(18)),
        child: Column(
          children: [
            Text(name,
                style: isActive
                    ? Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.apply(color: white)
                    : Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.apply(color: Theme.of(context).colorScheme.outline),
                textAlign: TextAlign.center),
            SizedBox(
              height: adaptWidgetHeight(8),
            ),
            Expanded(
              child: Image.asset("assets/images/goods_drinks.png"),
              // SvgPicture.network(image),
              // Image.network(image),
              // CachedNetworkImage(
              //   fit: BoxFit.cover,
              //   imageUrl: image,
              //   placeholder: (context, url) =>
              //   const CircularProgressIndicator(),
              //   errorWidget: (context, url, error) =>
              //   const Icon(Icons.error),
              // ),
            )
          ],
        ),
      ),
    );
  }
}

class CinemarketItemNomenclature extends StatelessWidget {
  final int id;
  final String name;
  final String image;
  final double price;
  final int amount;
  final bool isActive;
  final Function() onPressed;

  const CinemarketItemNomenclature({
    super.key,
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.amount,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GradientButton(
      padding: EdgeInsets.symmetric(
          horizontal: adaptWidgetWidth(22), vertical: adaptWidgetHeight(16)),
      borderWidth: adaptWidgetWidth(2),
      borderRadius: BorderRadius.circular(adaptWidgetWidth(30)),
      borderGradient: LinearGradient(
        colors: [
          isActive ? Theme.of(context).colorScheme.primary : transparent,
          isActive ? Theme.of(context).colorScheme.onPrimary : transparent,
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.surface
        ],
        begin: FractionalOffset.centerLeft,
        end: FractionalOffset.centerRight,
      ),
      onPressed: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: adaptWidgetHeight(75),
            child: Image.asset("assets/images/goods_drinks.png"),
            // SvgPicture.asset("assets/images/popcorn.svg"),
            // Image.asset("assets/images/goods_drinks.png"),
            // SvgPicture.network(image),
            // Image.network(image),
            // CachedNetworkImage(
            //   fit: BoxFit.cover,
            //   imageUrl: image,
            //   placeholder: (context, url) =>
            //   const CircularProgressIndicator(),
            //   errorWidget: (context, url, error) =>
            //   const Icon(Icons.error),
            // ),
          ),
          SizedBox(
            height: adaptWidgetHeight(10),
          ),
          Text(name,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center),
          const Spacer(),
          Text('${removeTrailingZeros(price)} ₴',
              style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(
            height: adaptWidgetHeight(6),
          ),
          SizedBox(
            width: adaptWidgetWidth(112),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MaterialButton(
                  minWidth: adaptWidgetWidth(34),
                  height: adaptWidgetHeight(34),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  color: Theme.of(context).colorScheme.onSecondary,
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                  onPressed: () => CinemarketModel()
                      .callbackNomenclature(false, id, name, price),
                  child: Icon(
                    Icons.remove_sharp,
                    color: CinemarketModel().getAmount(id) != 0
                        ? Theme.of(context).colorScheme.outline
                        : gray,
                    size: adaptWidgetWidth(24),
                  ),
                ),
                Text(amount.toString(),
                    style: Theme.of(context).textTheme.bodyLarge),
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.onPrimary
                      ],
                      begin: FractionalOffset.centerLeft,
                      end: FractionalOffset.centerRight,
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: adaptWidgetWidth(34),
                    height: adaptWidgetHeight(34),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // color: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                    padding: EdgeInsets.zero,
                    onPressed: () => CinemarketModel()
                        .callbackNomenclature(true, id, name, price),
                    child: Icon(
                      Icons.add,
                      color: white,
                      size: adaptWidgetWidth(24),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
