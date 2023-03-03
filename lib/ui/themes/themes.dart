import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';

const Color backgroundNight = Color(0xFF121212);
const Color backgroundDay = Color(0xFFFFFFFF);
const Color black = Color(0xFF000000);
const Color white = Color(0xFFFFFFFF);
const Color transparent = Colors.transparent;

const Color gray = Color(0xFF979797);
const Color surfaceNight = Color(0xFF202020); // surface Night
const Color surfaceDay = Color(0xFFF3F3F3); // surface Day
const Color minorGreyNight = Color(0xFF333333); // onSecondary Night
const Color minorGreyDay = Color(0xFFFFFFFF); // onSecondary Day
const Color soldNight = Color(0xFF202020); // surfaceVariant Night
const Color soldDay = Color(0xFFE6E6E6); // surfaceVariant Day
const Color borderSeatsNight = Color(0xFF676767); // onSurfaceVariant Night
const Color borderSeatsDay = Color(0xFFC7C7C7); // onSurfaceVariant Day
const Color soldSeatsNight = Color(0xFFABABAB); // onInverseSurface Night
const Color soldSeatsDay = Color(0xFF979797); // onInverseSurface Day
const Color ticketsBorderNight = Color(0xFF333333); // inverseSurface Night
const Color ticketsBorderDay = Color(0xFFDDDDDD); // inverseSurface Day
const Color textNight = Color(0xFFFFFFFF); // outline Night
const Color textDay = Color(0xFF000000); // outline Day
const Color textInactiveNight = Color(0xFF8F8F8F); // tertiary Night
const Color textInactiveDay = Color(0xFF979797); // tertiary Day
// WIZORIA COLORS
const Color primaryWiz = Color(0xFF8C64C9); // primary Wiz
const Color secondaryWizNight = Color(0xFFFF762D); // secondary Night
const Color secondaryWizDay = Color(0xFFFE5A02); // secondary Day
const Color seatsWizNight = Color(0xFFFFFFFF); // surfaceTint Night
const Color seatsWizDay = Color(0xFF52899E); // surfaceTint Day
// CINEMA COLORS
const Color primaryCinema = Color(0xFFFE5000); // primary Cinema
const Color secondaryCinemaNight = Color(0xFFEF7B07); // secondary Night
const Color secondaryCinemaDay = Color(0xFFFE5A02); // secondary Day
const Color seatsCinemaNight = Color(0xFFFFFFFF); // surfaceTint Night
const Color seatsCinemaDay = Color(0xFFF6A217); // surfaceTint Day

// const MaterialColor kToDark = MaterialColor(
//   0xFFFE5A02,
//   // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
//   <int, Color>{
//     50: Colors.transparent, //10%
//     100: Colors.transparent, //20%
//     200: Colors.transparent, //30%
//     300: Colors.transparent, //40%
//     400: Colors.transparent, //50%
//     500: Colors.transparent, //60%
//     600: Colors.transparent, //70%
//     700: Colors.transparent, //80%
//     800: Colors.transparent, //90%
//     900: Colors.transparent, //100%
//   },
// );

class Themes {
  static ThemeData getWizoriaTheme(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      canvasColor: isDarkTheme ? backgroundNight : backgroundDay, // background всього застосунку
      primarySwatch: Colors.deepPurple,

      colorScheme: isDarkTheme
          ? const ColorScheme.dark().copyWith(
        surface: surfaceNight,
        onSecondary: minorGreyNight,
        surfaceVariant: soldNight,
        onSurfaceVariant: borderSeatsNight,
        inverseSurface: ticketsBorderNight,
        onInverseSurface: soldSeatsNight,
        outline: textNight,
        tertiary: textInactiveNight,
        primary: primaryWiz,
        onPrimary: primaryWiz,
        primaryContainer: primaryWiz,
        onPrimaryContainer: primaryWiz,
        secondary: secondaryWizNight,
        surfaceTint: seatsWizNight,
        background: backgroundNight
      )
          : const ColorScheme.light().copyWith(
        surface: surfaceDay,
        onSecondary: minorGreyDay,
        surfaceVariant: soldDay,
        onSurfaceVariant: borderSeatsDay,
        inverseSurface: ticketsBorderDay,
        onInverseSurface: soldSeatsDay,
        outline: textDay,
        tertiary: textInactiveDay,
        primary: primaryWiz,
        onPrimary: primaryWiz,
        primaryContainer: primaryWiz,
        onPrimaryContainer: primaryWiz,
        secondary: secondaryWizDay,
        surfaceTint: seatsWizDay,
        background: backgroundDay
      ),

      fontFamily: 'Montserrat',
      // FontWeight: 100 Thin, 200 Extra Light, 300 Light, 400 Regular, 500 Medium, 600 Semi Bold, 700 Bold, 800 Extra Bold, 900 Black;
      textTheme: isDarkTheme ? ThemeData.dark().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: adaptWidgetWidth(60), fontWeight: FontWeight.w200, height: 1, letterSpacing: 3, color: white),
        titleMedium: TextStyle(fontSize: adaptWidgetWidth(30), fontWeight: FontWeight.w300, letterSpacing: 3, color: white), // subtitle2
        titleSmall: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w600, color: white), // headline2
        headlineLarge: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w500, color: white),
        headlineMedium: TextStyle(fontSize: adaptWidgetWidth(22), fontWeight: FontWeight.w400, color: white),
        headlineSmall: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w600, color: white),
        displayLarge: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w500, color: white), // headline1
        bodyLarge: TextStyle(fontSize: adaptWidgetWidth(18), fontWeight: FontWeight.w500, color: white),
        bodyMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w500, color: white),
        displayMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: white), // bodyText1
        bodySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w500, color: white),
        displaySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: white), // bodyText2:
        labelSmall: TextStyle(fontSize: adaptWidgetWidth(12), fontWeight: FontWeight.w500, color: white),
      ) : ThemeData.dark().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: adaptWidgetWidth(60), fontWeight: FontWeight.w200, height: 1, letterSpacing: 3, color: black),
        titleMedium: TextStyle(fontSize: adaptWidgetWidth(30), fontWeight: FontWeight.w300, letterSpacing: 3, color: black), // subtitle2
        titleSmall: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w600, color: black), // headline2
        headlineLarge: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w500, color: black),
        headlineMedium: TextStyle(fontSize: adaptWidgetWidth(22), fontWeight: FontWeight.w400, color: black),
        headlineSmall: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w600, color: black),
        displayLarge: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w500, color: black), // headline1
        bodyLarge: TextStyle(fontSize: adaptWidgetWidth(18), fontWeight: FontWeight.w500, color: black),
        bodyMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w500, color: black),
        displayMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: black), // bodyText1
        bodySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w500, color: black),
        displaySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: black), // bodyText2:
        labelSmall: TextStyle(fontSize: adaptWidgetWidth(12), fontWeight: FontWeight.w500, color: black),
      ),
    );
  }

  static ThemeData getCinemaCitiTheme(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      canvasColor: isDarkTheme ? backgroundNight : backgroundDay, // background всього застосунку
      primarySwatch: Colors.deepOrange,

      colorScheme: isDarkTheme
          ? const ColorScheme.dark().copyWith(
        surface: surfaceNight,
        onSecondary: minorGreyNight,
        surfaceVariant: soldNight,
        onSurfaceVariant: borderSeatsNight,
        inverseSurface: ticketsBorderNight,
        onInverseSurface: soldSeatsNight,
        outline: textNight,
        tertiary: textInactiveNight,
        primary: primaryCinema,
        onPrimary: seatsCinemaDay,
        primaryContainer: surfaceNight,
        onPrimaryContainer: surfaceNight,
        secondary: secondaryCinemaNight,
        surfaceTint: seatsCinemaNight,
        background: backgroundNight
      )
          :  const ColorScheme.light().copyWith(
        surface: surfaceDay,
        onSecondary: minorGreyDay,
        surfaceVariant: soldDay,
        onSurfaceVariant: borderSeatsDay,
        inverseSurface: ticketsBorderDay,
        onInverseSurface: soldSeatsDay,
        outline: textDay,
        tertiary: textInactiveDay,
        primary: primaryCinema,
        onPrimary: seatsCinemaDay,
        primaryContainer: primaryCinema,
        onPrimaryContainer: seatsCinemaDay,
        secondary: secondaryCinemaDay,
        surfaceTint: seatsCinemaDay,
        background: backgroundDay
      ),

      fontFamily: 'Montserrat',
      // FontWeight: 100 Thin, 200 Extra Light, 300 Light, 400 Regular, 500 Medium, 600 Semi Bold, 700 Bold, 800 Extra Bold, 900 Black;
      textTheme: isDarkTheme ? ThemeData.dark().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: adaptWidgetWidth(60), fontWeight: FontWeight.w200, height: 1, letterSpacing: 3, color: white),
        titleMedium: TextStyle(fontSize: adaptWidgetWidth(30), fontWeight: FontWeight.w300, letterSpacing: 3, color: white), // subtitle2
        titleSmall: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w600, color: white), // headline2
        headlineLarge: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w500, color: white),
        headlineMedium: TextStyle(fontSize: adaptWidgetWidth(22), fontWeight: FontWeight.w400, color: white),
        headlineSmall: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w600, color: white),
        displayLarge: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w500, color: white), // headline1
        bodyLarge: TextStyle(fontSize: adaptWidgetWidth(18), fontWeight: FontWeight.w500, color: white),
        bodyMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w500, color: white),
        displayMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: white), // bodyText1
        bodySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w500, color: white),
        displaySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: white), // bodyText2:
        labelSmall: TextStyle(fontSize: adaptWidgetWidth(12), fontWeight: FontWeight.w500, color: white),
      ) : ThemeData.dark().textTheme.copyWith(
        titleLarge: TextStyle(fontSize: adaptWidgetWidth(60), fontWeight: FontWeight.w200, height: 1, letterSpacing: 3, color: black),
        titleMedium: TextStyle(fontSize: adaptWidgetWidth(30), fontWeight: FontWeight.w300, letterSpacing: 3, color: black), // subtitle2
        titleSmall: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w600, color: black), // headline2
        headlineLarge: TextStyle(fontSize: adaptWidgetWidth(24), fontWeight: FontWeight.w500, color: black),
        headlineMedium: TextStyle(fontSize: adaptWidgetWidth(22), fontWeight: FontWeight.w400, color: black),
        headlineSmall: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w600, color: black),
        displayLarge: TextStyle(fontSize: adaptWidgetWidth(20), fontWeight: FontWeight.w500, color: black), // headline1
        bodyLarge: TextStyle(fontSize: adaptWidgetWidth(18), fontWeight: FontWeight.w500, color: black),
        bodyMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w500, color: black),
        displayMedium: TextStyle(fontSize: adaptWidgetWidth(16), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: black), // bodyText1
        bodySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w500, color: black),
        displaySmall: TextStyle(fontSize: adaptWidgetWidth(14), fontWeight: FontWeight.w400, letterSpacing: 0.5, color: black), // bodyText2:
        labelSmall: TextStyle(fontSize: adaptWidgetWidth(12), fontWeight: FontWeight.w500, color: black),
      ),
    );
  }
}