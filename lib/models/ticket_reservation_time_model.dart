import 'dart:async';

import 'package:flutter/cupertino.dart';
import '../ui/screens/cinemarket/cinemarket_model.dart';
import '../ui/screens/ticket_booking/ticket_booking_model.dart';

class TicketReservationTimeModel with ChangeNotifier {
  static TicketReservationTimeModel? _ticketReservationTimeModel;

  TicketReservationTimeModel._internal();

  factory TicketReservationTimeModel() {
    _ticketReservationTimeModel ??= TicketReservationTimeModel._internal();
    return _ticketReservationTimeModel!;
  }

  Timer? countdownTimer;
  Duration myDuration = const Duration(minutes: 1);
bool timerOn = false;
  void startTimer() {

    if (myDuration.inSeconds == 0) {
      myDuration = const Duration(minutes: 1);
    }
    if (!timerOn) {
      timerOn = true;
      countdownTimer = Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
    }

  }

  void stopTimer() {
    if (countdownTimer != null) {
      TicketBookingModel().resetTicketBookingModel();
      countdownTimer!.cancel();
      TicketBookingModel().resetTicketBookingModel();
      CinemarketModel().removeNomenclatureGlasses();
      myDuration = const Duration(minutes: 1);
      print('Ticket Booking Reservation stop');
    }
  }

  void setCountDown() {
    final seconds = myDuration.inSeconds - 1;
    if (seconds < 0) {
      timerOn = false;
      stopTimer();
    } else {
      myDuration = Duration(seconds: seconds);
      notifyListeners();
    }
  }
}
