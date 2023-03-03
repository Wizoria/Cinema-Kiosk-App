import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../models/check_model.dart';
import '../../../models/seat.dart';
import '../../../models/ticket_reservation_time_model.dart';
import '../../../service/app_manager.dart';
import '../cinemarket/cinemarket_model.dart';

class TicketBookingModel extends ChangeNotifier {
  static TicketBookingModel? _ticketBookingModel;

  TicketBookingModel._internal();

  factory TicketBookingModel() {
    _ticketBookingModel ??= TicketBookingModel._internal();
    return _ticketBookingModel!;
  }
  int sessionId = 0;
  List<Seat> allSeats = [];
  List<Seat> selectedSeats = [];

  List<SeatMapCoordinates> seatMap = [];

  int total = 0;

  // int count = 0;
  //
  // updateHallMap() {
  //   count++;
  //   notifyListeners();
  // }

  // removeSelectedSeatByIndex() {
  //
  // }

  updateSelectedSeats([Seat? selectedSeat, int? index, int? glassesPrice]) {
    if (index != null && glassesPrice != null) {
      if (selectedSeats[index].priceGlasses > 0) {
        selectedSeats[index].priceGlasses = 0;
        total = total - glassesPrice;
        // if (CinemarketModel().) {
          CinemarketModel().callbackNomenclature(false, 777, '3D-окулярии', glassesPrice.toDouble());
        // }
      } else {
        selectedSeats[index].priceGlasses = glassesPrice;
        total = total + glassesPrice;
        CinemarketModel().callbackNomenclature(true, 777, '3D-окулярии', glassesPrice.toDouble());
      }
    } else {
      bool isSeatAdded = false;
      for (Seat seat in selectedSeats) {
        if (seat.row == selectedSeat!.row && seat.seat == selectedSeat.seat) {
          isSeatAdded = true;
        }
      }
      if (isSeatAdded) {
        selectedSeats.remove(selectedSeat);
        total = (total - selectedSeat!.priceK) - selectedSeat.priceGlasses;
        selectedSeat.priceGlasses = 0;
      } else {
        selectedSeats.add(selectedSeat!);
        total = total + selectedSeat.priceK;
      }
    }
    CheckModel().updateCheck();
    notifyListeners();
    if (selectedSeats.isEmpty) {
      TicketReservationTimeModel().stopTimer();
    }
  }

  totalTicket() {
    int totalTicket = 0;
    for (Seat seat in selectedSeats) {
      if (seat.priceK > 0) {
        totalTicket = totalTicket + seat.priceK;
      }
    }
    return totalTicket;
  }

  totalGlasses() {
    int totalGlasses = 0;
    for (Seat seat in selectedSeats) {
      if (seat.priceK > 0) {
        totalGlasses = totalGlasses + seat.priceGlasses;
      }
    }
    return totalGlasses;
  }

  double calculateHallMapHeight(String hallMapString) {
    double maxRowLength = 0;
    int rowsQty = 0;
    total = 0; // reset total

    List<String> rows = hallMapString.split("/");
    rows.removeWhere((row) => row.isEmpty);

    for (String row in rows) {
      double currentRowLength = 0;
      for (var rune in row.runes) {
        var character = String.fromCharCode(rune);

        if (character == '.') {
          currentRowLength = currentRowLength + 0.5;
        } else {
            currentRowLength++;
        }
      }
      if (currentRowLength > maxRowLength) {
        maxRowLength = currentRowLength;
      }
    }

    rowsQty = rows.length;

    double deviceScreenHeight = AppManager().deviceScreenHeight * 0.5;
    double deviceScreenWidth = AppManager().deviceScreenWidth;

    double seatSpacerDx = (deviceScreenWidth / maxRowLength / 2) * 0.3;
    if (seatSpacerDx > 10) {
      seatSpacerDx = 10;
    }
    double seatSpacerDy = (deviceScreenHeight / rowsQty / 2) * 0.5;
    if (seatSpacerDy > 12) {
      seatSpacerDy = 12;
    }
    double seatSizeDx =
        (deviceScreenWidth - seatSpacerDx * maxRowLength) / maxRowLength / 2;
    double seatSizeDy = deviceScreenHeight / rowsQty / 2;
    double seatRadius = min(seatSizeDx, seatSizeDy);

    double hallMapHeight =
        seatSizeDy * (rowsQty + 1) + (seatSpacerDy * rowsQty);

    return hallMapHeight;
    // return AppManager().deviceScreenHeight * 0.50;
  }

  resetTicketBookingModel() {
    selectedSeats.clear();
    notifyListeners();
    // allSeats.clear();
  }

  bindCoordinatesToHallMap() {
    for (Seat seat in allSeats) {
      for (SeatMapCoordinates seatCoordinates in seatMap) {
        if (seat.row == seatCoordinates.row &&
            seat.seat == seatCoordinates.seat) {
          seat.seatMapCoordinates = seatCoordinates;
        }
      }
    }
  }

  Seat getSeatData(int seat, int row) {
    for (Seat seatData in allSeats) {
      if (seatData.row == row && seatData.seat == seat) {
        return seatData;
      }
    }
    return Seat.empty();
  }

  bool checkIfSeatSelected(Seat seat) {
    for (Seat selectedSeat in selectedSeats) {
      if (selectedSeat.row == seat.row && selectedSeat.seat == seat.seat) {
        return true;
      }
    }
    return false;
  }

// updateSelectedSeats() {
//   count++;
//   notifyListeners();
// }

// parseHallMapString(String hallMapString, bool numberingRightToLeft) {
//   hallMapString = '____.FFFFFFFFFFFFFFFFFF.____/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '__FFFFFFFFFFFFFFFFFFFFFFF__/'
//       '_FFFFFFFFFFFFFFFFFFFFFFFFF_/'
//       '___________________________/'
//       '_______.BBBBBBBBBBBB._______/'
//       '______.BBBBBBBBBBBBBB.______/';
//
//   for (var rune in hallMapString.runes) {
//     var character = String.fromCharCode(rune);
//
//     if (character == 'F') {
//       // allSeats.add(SeatMapCoordinates);
//     }
//
//     // log(character);
//   }
// }
}

class SeatMapCoordinates {
  int seat = 0;
  int row = 0;
  double dx = 0.0;
  double dy = 0.0;
  double seatRadius = 0.0;

  // SeatStatus status

  SeatMapCoordinates(this.seat, this.row, this.dx, this.dy, this.seatRadius);

  @override
  String toString() {
    return 'SeatMapCoordinates{seat: $seat, row: $row, dx: $dx, dy: $dy}';
  }
}

// enum SeatStatus { free, sold, blue }
