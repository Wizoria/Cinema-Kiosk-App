import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:cinema_kiosk_app/ui/screens/ticket_booking/ticket_booking_model.dart';
import 'package:flutter/material.dart';
import '../../../models/seat.dart';
import '../../../service/app_manager.dart';
import '../../../service/common_functions.dart';

// TODO: Використовувати цю функцію для збереження намальованих схем залів для вкладки Купити в клієнтському мобільному додатку
Future<Uint8List?> getHallMapImage(String hallMapString, bool numberingRightToLeft) async {
  // String hallMapString =
  //     '____.FFFFFFFFFFFFFFFFFF.____/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFSFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
  //     '_FFFFFFFFFFFFFFFFFFFFFFFFF_/'
  //     '___________________________/'
  //     '_______.BBBBBBBBBBBB._______/'
  //     '______.BBBBBBBBBBBBBB.______/';

  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();

  double devicePixelRatio = ui.window.devicePixelRatio;

  Canvas canvas = Canvas(pictureRecorder);
  // Make sure to apply scaling to the DPR of the window, since the framework will be scaling this picture normally in the layer tree
  canvas.save();
  canvas.scale(ui.window.devicePixelRatio);

  // HallMapPainter(hallMapString, false).paint(canvas, Size(AppManager().deviceScreenHeight * 0.5 * devicePixelRatio, AppManager().deviceScreenWidth * devicePixelRatio));
  // HallMapPainter(hallMapString, false).paint(canvas, Size(1700, 300));

  canvas.restore();

  var pic = pictureRecorder.endRecording();
  ui.Image img = await pic.toImage((AppManager().deviceScreenHeight * 0.5 * devicePixelRatio).toInt(), (AppManager().deviceScreenWidth * devicePixelRatio).toInt());
  var byteData = await img.toByteData(format: ui.ImageByteFormat.png);
  var buffer = byteData?.buffer.asUint8List();

  return buffer;
}

_drawTextAt(String text, Offset position, Canvas canvas, double seatRadius, Color textColor, bool isSelected) {
  double fontSize = (seatRadius * 0.7);
  double textShifting = 0;
  FontWeight fontWeight = FontWeight.w500;
  if (isSelected) {
    fontWeight = FontWeight.bold;
    fontSize = fontSize * 1.4; // VO 1.2 -> 1.4
  }
  if (text == '╳') { // VO
    fontSize = fontSize * 1.4;
  }
  final textStyle = TextStyle(color: textColor, fontSize: fontSize, fontWeight: fontWeight);
  final textSpan = TextSpan(
    text: text,
    style: textStyle,
  );

  final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.center, maxLines: 1);
  textPainter.layout(minWidth: 0, maxWidth: 100);

  if (text == '╳') {
    textShifting = seatRadius / 2.66;
  } else if (text.length == 1) {
    if (isSelected) {
      textShifting = seatRadius / 3;
    } else {
      textShifting = seatRadius / 4;
    }
  } else if (text.length == 2) {
    if (isSelected) {
      textShifting = seatRadius / 1.8;
    } else {
      textShifting = seatRadius / 2.3;
    }
  } else if (text.length == 3) {
    textShifting = seatRadius / 1.2;
  }

  double verticalTextShifting = 0;
  if (isSelected) {
    verticalTextShifting = seatRadius / 1.5;
  } else if (text == '╳') {
    verticalTextShifting = seatRadius / 1.52;
  } else {
    verticalTextShifting = seatRadius / 2;
  }
  // if (text == '╳') {
  //   verticalTextShifting = seatRadius / 1.5;
  // }


  Offset drawPosition = Offset(position.dx - textShifting, position.dy - (textPainter.height) + verticalTextShifting);
  textPainter.paint(canvas, drawPosition);
}

class HallMapPainter extends CustomPainter {
  Color freeRegularSeatColor = Colors.white;
  Color freeVIPSeatColor = const Color(0xFFFF762D);
  Color blockedSeatColor = const Color(0xFF202020);
  Color blockedSeatBorderColor = Colors.white54;
  // Color selectedSeatColor = const Color(0xFFFE5000); // Cinema Citi
  Color selectedSeatColor = const Color(0xFF8C64C9);
  // Color selectedSeatBorderColor = Colors.white; // Cinema Citi
  Color selectedSeatBorderColor = const Color(0xFF8C64C9);

  Color freeRegularSeatTextColor = Colors.black;
  Color freeVIPSeatTextColor = Colors.white;
  Color blockedSeatTextColor = const Color(0xFFA4A4A4);
  Color selectedSeatTextColor = Colors.white;
  Color numColor = Colors.white;
  Color transparent = Colors.transparent;

  String hallMapString = '';
  bool numberingRightToLeft = false;

  bool useHallMapStringForSeatsStatus = true;

  HallMapPainter(this.hallMapString, this.numberingRightToLeft);

  @override
  void paint(Canvas canvas, Size size) {
    // developer.log('calculating...');
    if (AppManager().isDarkThemeOn) {
      if (AppManager().cinemaSettings.cinemaChainSettings.cinemaChainId == 1) {
        // Wizoria night
        freeRegularSeatColor = Colors.white;
        freeVIPSeatColor = const Color(0xFFFF762D);
        blockedSeatColor = const Color(0xFF202020);
        blockedSeatBorderColor = Colors.white54;
        selectedSeatColor = const Color(0xFF8C64C9);
        selectedSeatBorderColor = const Color(0xFF8C64C9);

        freeRegularSeatTextColor = Colors.black;
        freeVIPSeatTextColor = Colors.white;
        blockedSeatTextColor = const Color(0xFFA4A4A4);
        selectedSeatTextColor = Colors.white;
        numColor = Colors.white;
      } else {
        // Cinema citi night

        freeRegularSeatColor = Colors.white;
        freeVIPSeatColor = const Color(0xFFEF7B07);
        blockedSeatColor = const Color(0xFF202020);
        blockedSeatBorderColor = Colors.white54;
        selectedSeatColor = const Color(0xFFFE5000); // Cinema Citi
        selectedSeatBorderColor = Colors.white; // Cinema Citi

        freeRegularSeatTextColor = Colors.black;
        freeVIPSeatTextColor = Colors.white;
        blockedSeatTextColor = const Color(0xFFA4A4A4);
        selectedSeatTextColor = Colors.white;
        numColor = Colors.white;
      }
    } else {
      if (AppManager().cinemaSettings.cinemaChainSettings.cinemaChainId == 1) {
        // Wizoria day

        freeRegularSeatColor = const Color(0xFF52899E);
        freeVIPSeatColor = const Color(0xFFFE5A02);
        blockedSeatColor = const Color(0xFFE6E6E6);
        blockedSeatBorderColor = const Color(0xFFC7C7C7);
        selectedSeatColor = const Color(0xFF8C64C9);
        selectedSeatBorderColor = const Color(0xFF8C64C9);

        freeRegularSeatTextColor = Colors.white;
        freeVIPSeatTextColor = Colors.white;
        blockedSeatTextColor = const Color(0xFFA4A4A4);
        selectedSeatTextColor = Colors.white;
        numColor = Colors.black;
      } else {
        // Cinema citi day

        freeRegularSeatColor = const Color(0xFFF6A217);
        freeVIPSeatColor = const Color(0xFFFE5A02);
        blockedSeatColor = const Color(0xFFE6E6E6);
        blockedSeatBorderColor = const Color(0xFFC7C7C7);
        selectedSeatColor = Colors.black;
        selectedSeatBorderColor = Colors.black;

        freeRegularSeatTextColor = Colors.white;
        freeVIPSeatTextColor = Colors.white;
        blockedSeatTextColor = const Color(0xFFA4A4A4);
        selectedSeatTextColor = Colors.white;
        numColor = Colors.black;
      }
    }

    TicketBookingModel().seatMap.clear();

    // hallMapString =
    // '____.FFFFFFFFFFFFFFFFFF.____/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFSFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '__FFFFFFFFFFFFFFFFFFFFFFF__/'
    //     '_FFFFFFFFFFFFFFFFFFFFFFFFF_/'
    //     '___________________________/'
    //     '_______.BBBBBBBBBBBB._______/'
    //     '______.BBBBBBBBBBBBBB.______/';
    //
    // hallMapString = '__FF_FF__/'
    //     '__SF_FF__/'
    //     '__BB_BB__/';

    double maxRowLength = 0;
    int rowsQty = 0;

    List<String> rows = hallMapString.split("/");
    rows.removeWhere((row) => row.isEmpty);

    List<String> normalizedRows = [];

    for (String row in rows) {
      row = row.replaceAll("F", "N");
      row = row.replaceAll("S", "N");
      row = row.replaceAll("R", "N");
      row = row.replaceAll("V", "N");
      row = row.replaceAll("T", "N");
      row = row.replaceAll("B", "N");
      row = row.replaceAll("U", "N");
      row = row.replaceAll("\r", "");

      normalizedRows.add(row);

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

    if (useHallMapStringForSeatsStatus) {
      rowsQty = rows.length;
    } else {
      rowsQty = normalizedRows.length;
    }

    double deviceScreenHeight = AppManager().deviceScreenHeight * 0.5;
    double deviceScreenWidth = AppManager().deviceScreenWidth - adaptWidgetWidth(130); // VO + - adaptWidgetWidth(130)

    double seatSpacerDx = (deviceScreenWidth / maxRowLength / 2) * 0.3;
    if (seatSpacerDx > 10) {
      seatSpacerDx = 10;
    }
    double seatSpacerDy = (deviceScreenHeight / rowsQty / 2) * 0.5;
    if (seatSpacerDy > 12) {
      seatSpacerDy = 12;
    }
    double seatSizeDx = (deviceScreenWidth - seatSpacerDx * maxRowLength) / maxRowLength / 2;
    double seatSizeDy = deviceScreenHeight / rowsQty / 2;
    double seatRadius = min(seatSizeDx, seatSizeDy);

    double currentDxPosition = 0.0;
    double currentDyPosition = 0.0;
    int currentRowNumber = 1;

    for (String row in rows) {
      int currentSeatNumber = 1;

      currentDyPosition = currentDyPosition + seatSizeDy + seatSpacerDy;

      String currentRow = row.replaceAll("\r", "");

      bool rowHasPlaces = false;
      int seatsQty = 0;
      for (var rune in currentRow.runes) {
        var character = String.fromCharCode(rune);
        if (character != '_' && character != '.') {
          rowHasPlaces = true;
          seatsQty++;
        }
      }
      if (numberingRightToLeft) {
        currentSeatNumber = seatsQty;
      }

      if (rowHasPlaces) {
        _drawTextAt(currentRowNumber.toString(), Offset(adaptWidgetWidth(10), currentDyPosition), canvas, seatRadius, numColor, false);
      }

      if (numberingRightToLeft) {
        currentRow = String.fromCharCodes(currentRow.runes.toList().reversed);
      }
      rowHasPlaces = false;
      for (var rune in currentRow.runes) {
        var character = String.fromCharCode(rune);
        if (character == '_') {
          currentDxPosition = currentDxPosition + seatSizeDx * 2 + seatSpacerDx;
          continue;
        }

        if (character == '.') {
          currentDxPosition = currentDxPosition + (seatSizeDx) + seatSpacerDx;
          continue;
        }

        rowHasPlaces = true;
        bool isVipSeat = false;
        Seat seatData = TicketBookingModel().getSeatData(currentSeatNumber, currentRowNumber);
        if (seatData.seat != 0 && seatData.row != 0 && character != 'X') {
          character = seatData.status;
          isVipSeat = seatData.seatVIP;
        }

        bool isSeatSelected = TicketBookingModel().checkIfSeatSelected(seatData);

        if (isSeatSelected) {
          character = 'A';
        }

        // Вибране місце
        if (character == 'A') {
          currentDxPosition = currentDxPosition + seatSizeDx * 2 + seatSpacerDx;

          final selectedPlacePaint = Paint()
            ..strokeWidth = 4
            ..color = selectedSeatColor
            ..style = PaintingStyle.fill;

          canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, selectedPlacePaint);
          _drawTextAt(
              '✓',  Offset(currentDxPosition, currentDyPosition), canvas, seatRadius, selectedSeatTextColor, true);
          // _drawTextAt('V', Offset(currentDxPosition, currentDyPosition), canvas, seatRadius, selectedSeatTextColor, true);

          selectedPlacePaint
            ..strokeWidth = adaptWidgetHeight(2)
            ..color = selectedSeatBorderColor
            ..style = PaintingStyle.stroke;
          canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, selectedPlacePaint);

          TicketBookingModel()
              .seatMap
              .add(SeatMapCoordinates(currentSeatNumber, currentRowNumber, currentDxPosition, currentDyPosition, seatRadius));

          if (numberingRightToLeft) {
            currentSeatNumber--;
          } else {
            currentSeatNumber++;
          }
        }

        // Вільне звичайне місце
        if (character == 'F' && isVipSeat == false) {
          currentDxPosition = currentDxPosition + seatSizeDx * 2 + seatSpacerDx;

          final freePlacePaint = Paint()
            ..strokeWidth = 3
            ..color = freeRegularSeatColor
            ..style = PaintingStyle.fill;

          canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, freePlacePaint);
          _drawTextAt(currentSeatNumber.toString(), Offset(currentDxPosition, currentDyPosition), canvas, seatRadius,
              freeRegularSeatTextColor, false);

          TicketBookingModel()
              .seatMap
              .add(SeatMapCoordinates(currentSeatNumber, currentRowNumber, currentDxPosition, currentDyPosition, seatRadius));

          if (numberingRightToLeft) {
            currentSeatNumber--;
          }
          else {
            currentSeatNumber++;
          }
        } else if (character == 'X') { // VO +
            currentDxPosition = currentDxPosition + seatSizeDx * 2 + seatSpacerDx;
            seatData.status = "X";
            final blockedPlacePaint = Paint()
              ..strokeWidth = 4
              ..color = transparent
              ..style = PaintingStyle.fill;

            canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, blockedPlacePaint);
            _drawTextAt('╳', Offset(currentDxPosition, currentDyPosition), canvas, seatRadius, blockedSeatTextColor, false);

            blockedPlacePaint
              ..strokeWidth = 1.5 // VO 2 -> 1.5
              ..color = transparent
              ..style = PaintingStyle.stroke;
            canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, blockedPlacePaint);

            TicketBookingModel()
                .seatMap
                .add(SeatMapCoordinates(currentSeatNumber, currentRowNumber, currentDxPosition, currentDyPosition, seatRadius));

            if (numberingRightToLeft) {
              currentSeatNumber--;
            } else {
              currentSeatNumber++;
            }
        }

        // Вільне VIP/LUX місце
        if (character == 'B' || (character == 'F' && isVipSeat)) {
          currentDxPosition = currentDxPosition + seatSizeDx * 2 + seatSpacerDx;

          final vipPlacePaint = Paint()
            ..strokeWidth = 4
            ..color = freeVIPSeatColor
            ..style = PaintingStyle.fill;

          canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, vipPlacePaint);
          _drawTextAt(
              currentSeatNumber.toString(), Offset(currentDxPosition, currentDyPosition), canvas, seatRadius, freeVIPSeatTextColor, false);

          TicketBookingModel()
              .seatMap
              .add(SeatMapCoordinates(currentSeatNumber, currentRowNumber, currentDxPosition, currentDyPosition, seatRadius));

          if (numberingRightToLeft) {
            currentSeatNumber--;
          } else {
            currentSeatNumber++;
          }
        }

        // Зайняте місце без привʼязки до VIP/LUX
        if (character == 'S' || character == 'R' || character == 'T' || character == 'U' || character == 'V') {
          currentDxPosition = currentDxPosition + seatSizeDx * 2 + seatSpacerDx;

          final blockedPlacePaint = Paint()
            ..strokeWidth = 4
            ..color = blockedSeatColor
            ..style = PaintingStyle.fill;

          canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, blockedPlacePaint);
          _drawTextAt('╳', Offset(currentDxPosition, currentDyPosition), canvas, seatRadius, blockedSeatTextColor, false); // VO

          blockedPlacePaint
            ..strokeWidth = adaptWidgetWidth(1.5) // VO 2 -> 1.5
            ..color = blockedSeatBorderColor
            ..style = PaintingStyle.stroke;
          canvas.drawCircle(Offset(currentDxPosition, currentDyPosition), seatRadius, blockedPlacePaint);

          TicketBookingModel()
              .seatMap
              .add(SeatMapCoordinates(currentSeatNumber, currentRowNumber, currentDxPosition, currentDyPosition, seatRadius));

          if (numberingRightToLeft) {
            currentSeatNumber--;
          } else {
            currentSeatNumber++;
          }
        }
      }

      if (rowHasPlaces) {
        currentRowNumber++;
      }
      currentDxPosition = 0.0;
    }
    TicketBookingModel().bindCoordinatesToHallMap();
    log(currentDyPosition);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
