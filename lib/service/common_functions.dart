import 'dart:developer';
import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:cinema_kiosk_app/models/environments/environment.dart';
import 'package:intl/intl.dart';

import '../models/presence_model.dart';
import '../models/ticket_reservation_time_model.dart';
import '../ui/screens/cinemarket/cinemarket_model.dart';

DateTime getDateFromString(String dateString) {
  try {
    if (dateString == '2049-01-01 00:00:00') {
      return DateTime.parse(dateString).toUtc();
    } else {
      return DateTime.parse(dateString).toUtc().add(const Duration(hours: 2));
    }
  } on Exception catch (e) {
    try {
      return DateFormat("dd.MM.yyyy hh:mm:ss").parse(dateString);
    } on Exception catch (e) {
      log(e.toString());
      return DateTime.parse("2022-01-01 00:00:00").toUtc();
    }
  }
}

DateTime getCurrentDate() {
  if (Environment().config.type == Environment.LOCAL) {
    return DateTime.parse("2022-10-25 12:54:02").toUtc();
  } else {
    // return DateTime.now().toUtc().add(const Duration(hours: 11));
    return DateTime.now().toUtc().add(const Duration(hours: 2));
  }
}

bool daysOfDatesEqualAreEqual(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}

double adaptWidgetHeight(double widgetHeight) {
  return AppManager().deviceToKioskAspectRatioHeight * widgetHeight;
}

double adaptWidgetWidth(double widgetWidth) {
  return AppManager().deviceToKioskAspectRatioWidth * widgetWidth;
}

removeTrailingZeros(double n) {
  return n.toString().replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
}

void resetSession() {
  PresenceModel().timerOff();
  TicketReservationTimeModel().stopTimer();
  CinemarketModel().resetSelectedNomenclature();
  Future.delayed(const Duration(milliseconds: 50), () {
    AppManager().currentScreen = '';
  });
}
