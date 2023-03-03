import 'package:cinema_kiosk_app/ui/screens/ticket_booking/hall_map_painter.dart';
import 'package:cinema_kiosk_app/ui/screens/ticket_booking/ticket_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/seat.dart';
import '../../../service/common_functions.dart';

class HallMap extends StatelessWidget {
  final String hallMapString;
  final bool numberingRightToLeft;
  final bool withGlasses;

  const HallMap(
      {Key? key,
      required this.hallMapString,
      required this.numberingRightToLeft,
      required this.withGlasses})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransformationController transformationController =
        TransformationController();

    double scalingFactor = 1.0;

    return SafeArea(
      child:  Padding(
          padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(65)),
          child: GestureDetector(
            onTapUp: (details) {
              var childWasTappedAt = transformationController.toScene(
                details.localPosition,
              );

              double currentDx = childWasTappedAt.dx.toDouble();
              double currentDy = childWasTappedAt.dy.toDouble();

              int additionalClickRadius = 10;
              for (Seat seat in TicketBookingModel().allSeats) {
                if (currentDx >=
                        seat.seatMapCoordinates.dx -
                            seat.seatMapCoordinates.seatRadius +
                            additionalClickRadius / 2 &&
                    currentDx <=
                        seat.seatMapCoordinates.dx +
                            seat.seatMapCoordinates.seatRadius +
                            additionalClickRadius / 2 &&
                    currentDy >=
                        seat.seatMapCoordinates.dy -
                            seat.seatMapCoordinates.seatRadius +
                            additionalClickRadius / 2 &&
                    currentDy <=
                        seat.seatMapCoordinates.dy +
                            seat.seatMapCoordinates.seatRadius +
                            additionalClickRadius / 2) {
                  // log(seat.toString());
                  if (seat.status == 'F' || seat.status == 'B') {
                    TicketBookingModel().updateSelectedSeats(seat);
                  }
                  // log(TicketBookingModel().selectedSeats.toString());
                }
              }

              // TicketBookingModel().updateHallMap();
            },
            child: InteractiveViewer(
              minScale: 1.0,
              maxScale: 2.5,
              transformationController: transformationController,
              onInteractionEnd: (details) {
                double correctScaleValue =
                    transformationController.value.getMaxScaleOnAxis();
                scalingFactor = correctScaleValue;
              },
              child:
                  Consumer<TicketBookingModel>(builder: (context, value, child) {
                // return FutureBuilder(
                //     // future: _futureCinemasList,
                //     future: getHallMapImage(hallMapString, numberingRightToLeft),
                //     builder: (context, snapshot) {
                //       if (snapshot.data != null) {
                //         return Image.memory(snapshot.data as Uint8List);
                //
                //         return snapshot.data as Widget;
                //       } else {
                //         return Text('Hall map drawing exeption!');
                //       }
                //     });

                return RepaintBoundary(
                    child: CustomPaint(
                      painter: HallMapPainter(hallMapString, numberingRightToLeft),
                    ));
              }),
            ),
          ),
        ),
      );
  }
}
