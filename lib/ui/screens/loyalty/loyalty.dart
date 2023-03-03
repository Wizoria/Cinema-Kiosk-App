import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../models/presence_model.dart';
import '../../../service/app_manager.dart';
import '../../components/bottom_menu.dart';
import '../../components/main_header.dart';

Map<String, String> loyaltyTitleTextWizoria = {
  'Зареєструйтеся в нашій програмі лояльності':
      'Встановіть мобільний додаток для реєстрації у програмі лояльності Wizoria Cashback. Також зареєструватись можна на нашому сайті wizoria.ua',
  'Купуйте квитки та продукцію кіномаркету ':
      'Всім авторизованим Клієнтам за номером телефону чи персональним QR-кодом від кожної покупки буде нараховуватись Wizoria Cashback',
  'Отримайте 3% від кожної витраченої гривні у кінотеатрі':
      'Всім авторизованим Клієнтам за номером телефону чи персональним QR-кодом від кожної покупки буде нараховуватись Wizoria Cashback',
  'Витрачайте накопичений Wizoria Cashback на все у Wizoria!':
      "На сайті, в мобільних додатках, у касах кінотеатрів та кіномаркетів, в кіосках самообслуговування  без обмежень, незалежно від сеансу, формату фільму чи дати прем'єри!",
  'Контролюйте свої покупки та Wizoria Cashback* в зручній історії транзакцій в особистому кабінеті':
      '*Wizoria Cashback не діє на підакцизний товар. Wizoria Cashback не нараховується при використанні знижок та акційних товарів у кіно-барі',
  'Отримуйте безкоштовний квиток до Дня Народження!':
      "Учасники програми лояльності Wizoria Cashback отримують безкоштовний квиток на свій День Народження за пред'явлення паспорта або свідоцтва про народження.",
};

Map<String, String> loyaltyTitleTextCinema = {
  'Зареєструйтеся в нашій програмі лояльності':
      'Встановіть мобільний додаток для реєстрації у програмі лояльності Cinema citi Cashback. Також зареєструватись можна на нашому сайті cinemaciti.ua',
  'Купуйте квитки та продукцію кіномаркету ':
      'Всім авторизованим Клієнтам за номером телефону чи персональним QR-кодом від кожної покупки буде нараховуватись Cinema citi Cashback',
  'Отримайте 3% від кожної витраченої гривні у кінотеатрі':
      'Всім авторизованим Клієнтам за номером телефону чи персональним QR-кодом від кожної покупки буде нараховуватись Cinema citi Cashback',
  'Витрачайте накопичений Cinema citi Cashback на все у Cinema citi!':
      "На сайті, в мобільних додатках, у касах кінотеатрів та кіномаркетів, в кіосках самообслуговування  без обмежень, незалежно від сеансу, формату фільму чи дати прем'єри!",
  'Контролюйте свої покупки та Cinema citi Cashback* в зручній історії транзакцій в особистому кабінеті':
      '*Cinema citi Cashback не діє на підакцизний товар. Cinema citi Cashback не нараховується при використанні знижок та акційних товарів у кіно-барі',
  'Отримуйте безкоштовний квиток до Дня Народження!':
      "Учасники програми лояльності Cinema citi Cashback отримують безкоштовний квиток на свій День Народження за пред'явлення паспорта або свідоцтва про народження.",
};

class Loyalty extends StatelessWidget {
  const Loyalty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      PresenceModel().timerOff();
    }
    AppManager().currentScreen = GoRouterState.of(context).name!;
    return Material(
      child: Stack(
        children: [
          Column(
            children: [
              const MainHeader(showCloseButton: true),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: adaptWidgetHeight(70)),
                    Image.asset(
                      fit: BoxFit.fitWidth,
                      AppManager().cinemaSettings.cinemaChainId == 1
                          ? 'assets/images/image_loyalty.png'
                          : 'assets/images/image_loyalty.png',
                      width: double.maxFinite,
                      height: adaptWidgetHeight(244),
                    ),
                    SizedBox(
                      height: adaptWidgetHeight(54),
                    ),
                    Text(
                        AppManager().cinemaSettings.cinemaChainId == 1
                            ? 'Програма лояльності Wizoria Cashback'
                            : 'Програма лояльності Cinema citi Cashback',
                        style: Theme.of(context).textTheme.headlineLarge),
                    SizedBox(
                      height: adaptWidgetHeight(32),
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        AppManager().cinemaSettings.cinemaChainId == 1
                            ? loyaltyTitleTextWizoria.length
                            : loyaltyTitleTextCinema.length,
                        (index) => Container(
                          width: adaptWidgetWidth(374),
                          height: adaptWidgetHeight(224),
                          margin: EdgeInsets.all(adaptWidgetWidth(6)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius:
                                BorderRadius.circular(adaptWidgetWidth(35)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: adaptWidgetHeight(34),
                                    left: adaptWidgetWidth(24)),
                                child: Text(
                                  (index + 1).toString(),
                                  style: TextStyle(
                                      fontSize: adaptWidgetHeight(44),
                                      fontWeight: FontWeight.w300,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: adaptWidgetWidth(20)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                          AppManager()
                                                      .cinemaSettings
                                                      .cinemaChainId ==
                                                  1
                                              ? loyaltyTitleTextWizoria.keys
                                                  .elementAt(index)
                                              : loyaltyTitleTextCinema.keys
                                                  .elementAt(index),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .apply(fontWeightDelta: 2)),
                                      SizedBox(
                                        height: adaptWidgetHeight(6),
                                      ),
                                      Text(
                                          AppManager()
                                                      .cinemaSettings
                                                      .cinemaChainId ==
                                                  1
                                              ? loyaltyTitleTextWizoria[
                                                  loyaltyTitleTextWizoria.keys
                                                      .elementAt(index)]!
                                              : loyaltyTitleTextCinema[
                                                  loyaltyTitleTextCinema.keys
                                                      .elementAt(index)]!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .displaySmall),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: adaptWidgetHeight(54),
                        ),
                        Text('Завантажуйте мобільний додаток ',
                            style: Theme.of(context).textTheme.headlineLarge),
                        SizedBox(
                          height: adaptWidgetHeight(10),
                        ),
                        Text(
                          AppManager().cinemaSettings.cinemaChainId == 1
                              ? 'Та приєднуйтесь до нашої\n програми лояльності Wizoria Cashback'
                              : 'Та приєднуйтесь до нашої\n програми лояльності Cinema citi Cashback',
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .apply(heightDelta: 0.2),
                        ),
                        SizedBox(
                          height: adaptWidgetHeight(24),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              fit: BoxFit.fitWidth,
                              'assets/images/qr_code.png',
                              width: adaptWidgetHeight(85),
                              height: adaptWidgetHeight(85),
                            ),
                            SizedBox(
                              width: adaptWidgetWidth(26),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        width: adaptWidgetHeight(22),
                                        height: adaptWidgetHeight(22),
                                        "assets/icons/icon_app_store.svg",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fit: BoxFit.cover),
                                    SizedBox(
                                      width: adaptWidgetWidth(12),
                                    ),
                                    Text('App Store',
                                        style: TextStyle(
                                            fontSize: adaptWidgetHeight(16))),
                                  ],
                                ),
                                SizedBox(
                                  height: adaptWidgetHeight(18),
                                ),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                        width: adaptWidgetHeight(22),
                                        height: adaptWidgetHeight(22),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        "assets/icons/icon_google_play.svg",
                                        fit: BoxFit.cover),
                                    SizedBox(
                                      width: adaptWidgetWidth(12),
                                    ),
                                    Text('Google Play',
                                        style: TextStyle(
                                            fontSize: adaptWidgetHeight(16))),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const BottomMenu(),
            ],
          ),
        ],
      ),
    );
  }
}
