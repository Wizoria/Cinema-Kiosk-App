import 'dart:developer';
import 'dart:io';
import 'package:cinema_kiosk_app/ui/screens/advertising_posters/advertising_posters_model.dart';
import 'package:cinema_kiosk_app/ui/screens/cinemarket/cinemarket_model.dart';
import 'package:cinema_kiosk_app/ui/screens/settings/cinema_chain_settings.dart';
import 'package:cinema_kiosk_app/ui/themes/theme_changer.dart';
import 'package:cinema_kiosk_app/ui/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:cinema_kiosk_app/navigation/nav_router.dart';
import 'package:window_manager/window_manager.dart';
import 'models/check_model.dart';
import 'models/environments/environment.dart';
import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'models/movies_on_sale.dart';
import 'models/presence_model.dart';
import 'models/ticket_reservation_time_model.dart';
import 'ui/screens/ticket_booking/ticket_booking_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    await windowManager.ensureInitialized();
    WindowOptions windowOptions = const WindowOptions(
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
      await windowManager.setFullScreen(true);
    });
  }

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
  ));

  String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: AppManager().environment,
  );
  Environment().initConfig(environment);

  await AppManager().restoreAppSettingsFromSharedPreferences();

  runApp(const CinemaApp());
}

class CinemaApp extends StatefulWidget {
  const CinemaApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CinemaApp();
  }
}

class _CinemaApp extends State<CinemaApp> with WindowListener {

  @override
  void dispose() {
    // windows
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  void initState() {
    if (Platform.isWindows) {
      // windows
      windowManager.addListener(this);
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: []); // +FOOL SCREEN
    // TODO: implement initState
    super.initState();

    var size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
    AppManager().setDeviceScreenParameters(size.height, size.width);
  }

  @override
  onWindowResized() async {
    // VO +
    if (await windowManager.isResizable()) {
      setState(() {
        var size =
            MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        AppManager().setDeviceScreenParameters(size.height, size.width);
      });
    }
  }

  @override
  onWindowEnterFullScreen() async {
    log('EnterFullScreen');
    setState(() {
      var size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
      AppManager().setDeviceScreenParameters(size.height, size.width);
    });
  }

  @override
  onWindowLeaveFullScreen() async {
    log('LeaveFullScreen');
    if (!await windowManager.isFullScreen()) {
      var size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
      await windowManager.setSize(Size(size.width, size.height), animate: true);
      await windowManager.center(animate: true);
      setState(() {
        var size =
            MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        AppManager().setDeviceScreenParameters(size.height, size.width);
      });
    }
  }

  @override
  onWindowMaximize() async {
    if (await windowManager.isMaximized()) {
      log('onWindowMaximize');
      setState(() {
        var size =
            MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        AppManager().setDeviceScreenParameters(size.height, size.width);
      });
    }
  }

  @override
  onWindowUnmaximize() async {
    if (await windowManager.isMinimizable()) {
      log('onWindowUnmaximize');
      setState(() {
        var size =
            MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
        AppManager().setDeviceScreenParameters(size.height, size.width);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PresenceModel>(
          lazy: false,
          create: (BuildContext createContext) => PresenceModel(),
        ),
        ChangeNotifierProvider<AdvertisingPostersModel>(
          lazy: false,
          create: (BuildContext createContext) => AdvertisingPostersModel(),
        ),
        ChangeNotifierProvider<TicketBookingModel>(
          lazy: false,
          create: (BuildContext createContext) => TicketBookingModel(),
        ),
        ChangeNotifierProvider<CinemaChainSettings>(
          lazy: false,
          create: (BuildContext createContext) => CinemaChainSettings(),
        ),
        ChangeNotifierProvider<ThemeChanger>(
          lazy: false,
          create: (BuildContext createContext) => ThemeChanger(),
        ),
        Provider<NavRouter>(
          lazy: false,
          create: (BuildContext createContext) => NavRouter(),
        ),
        ChangeNotifierProvider<MoviesOnSale>(
          create: (BuildContext context) => MoviesOnSale(),
          lazy: false,
        ),
        ChangeNotifierProvider<CinemarketModel>(
          create: (BuildContext context) => CinemarketModel(),
          lazy: false,
        ),
        ChangeNotifierProvider<TicketReservationTimeModel>(
          create: (BuildContext context) => TicketReservationTimeModel(),
          lazy: false,
        ),
        ChangeNotifierProvider<CheckModel>(
          create: (BuildContext context) => CheckModel(),
          lazy: true,
        ),
      ],
      child: Builder(
        builder: (BuildContext context) {
          AppManager().localizations =
              WidgetsBinding.instance.window.locale.toString();
          final router = Provider.of<NavRouter>(context, listen: false).router;
          final themeChanger = Provider.of<ThemeChanger>(context);
          return Listener(
            onPointerDown: (event) {
              Future.delayed(const Duration(milliseconds: 100), () {
                PresenceModel().updateTimer();
              });
            },
            child: MaterialApp.router(
              routeInformationParser: router.routeInformationParser,
              routerDelegate: router.routerDelegate,
              routeInformationProvider: router.routeInformationProvider,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              themeMode: themeChanger.getTheme,
              theme: (AppManager().cinemaSettings.cinemaChainId == 1)
                  ? Themes.getWizoriaTheme(false, context)
                  : Themes.getCinemaCitiTheme(false, context),
              darkTheme: (AppManager().cinemaSettings.cinemaChainId == 1)
                  ? Themes.getWizoriaTheme(true, context)
                  : Themes.getCinemaCitiTheme(true, context),
            ),
          );
        },
      ),
    );
  }
}
