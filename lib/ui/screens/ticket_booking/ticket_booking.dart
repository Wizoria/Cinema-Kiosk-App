import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:cinema_kiosk_app/ui/components/main_header.dart';
import 'package:cinema_kiosk_app/ui/screens/ticket_booking/selected_seats_list.dart';
import 'package:cinema_kiosk_app/ui/screens/ticket_booking/ticket_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/models.dart';
import '../../../models/ticket_reservation_time_model.dart';
import '../../../navigation/nav_router.dart';
import '../../../repository/session_seats_repository.dart';
import '../../../service/common_functions.dart';
import '../../components/bottom_navigation_buttons.dart';
import '../cinemarket/cinemarket_model.dart';
import '../schedule/session_list_element_schedule.dart';
import 'hall_map.dart';

class TicketBooking extends StatefulWidget {
  final int sessionId;

  const TicketBooking({Key? key, required this.sessionId}) : super(key: key);

  @override
  State<TicketBooking> createState() => _TicketBookingState();
}

class _TicketBookingState extends State<TicketBooking> {
  late Future<List<Seat>> _futureSessionSeats;

  @override
  void initState() {
    super.initState();
    _futureSessionSeats =
        SessionSeatsRepository().getSessionSeatsBySessionId(widget.sessionId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        CinemarketModel().selectedProducts.clear();
        TicketBookingModel().resetTicketBookingModel();
        return false;
      },
      child: FutureBuilder<List<Seat>>(
        future: _futureSessionSeats,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              Session session = Session.empty();
              for (Session value in MoviesOnSale().filtratedSessionsOnSale) {
                if (value.id == widget.sessionId) {
                  session = value;
                }
              }

              TicketBookingModel().allSeats = snapshot.data as List<Seat>;
              TicketBookingModel().sessionId = widget.sessionId;

              double hallMapHeight = TicketBookingModel()
                  .calculateHallMapHeight(session.stringStatusSeat);

              return Material(
                child: Column(
                  children: [
                    // Text(widget.sessionId.toString()),
                    const MainHeader(showCloseButton: true),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: adaptWidgetWidth(65),
                          vertical: adaptWidgetHeight(30)),
                      child: MovieSchedule(
                        sessionId: widget.sessionId,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: adaptWidgetHeight(60),
                      child: Center(
                        child: Text(
                          'Оберіть місця:',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                    // SvgPicture.asset(
                    //     width: adaptWidgetWidth(50), height: adaptWidgetHeight(40), "assets/icons/screen.svg", fit: BoxFit.contain),

                    // Container(
                    //   height: bottomGradientHeight,
                    //   decoration: const BoxDecoration(
                    //     gradient: LinearGradient(
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       colors: [
                    //         Color.fromRGBO(36, 36, 36, 0),
                    //         Color(0xff121212)
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: adaptWidgetWidth(160),
                              right: adaptWidgetWidth(106)),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 50,
                                offset: const Offset(
                                    0, 55), // changes position of shadow
                              ),
                            ],
                          ),
                          width: AppManager().deviceScreenWidth,
                          height: adaptWidgetHeight(80),
                          child: Column(
                            children: [
                              AppManager().isDarkThemeOn
                                  ? (SvgPicture.asset(
                                      height: adaptWidgetHeight(50),
                                      "assets/icons/screen_night.svg",
                                      fit: BoxFit.contain))
                                  : SvgPicture.asset(
                                      height: adaptWidgetHeight(50),
                                      "assets/icons/screen_day.svg",
                                      fit: BoxFit.contain),
                              Center(
                                child: Text(
                                  'Екран     ',
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // HallMap(
                    //   hallMapString: session.stringStatusSeat,
                    //   numberingRightToLeft: session.numberingRightToLeft,
                    // ),
                    // Consumer<TicketBookingModel>(builder: (context, value, child) {
                    //   return const SelectedSeatsList();
                    // }),
                    // const Expanded(child: SizedBox()),

                    Expanded(
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            height: hallMapHeight,
                            child: HallMap(
                              hallMapString: session.stringStatusSeat,
                              numberingRightToLeft:
                                  session.numberingRightToLeft,
                              withGlasses:
                                  (session.format == '3D') ? true : false,
                            ),
                          ),
                          Positioned(
                            top: hallMapHeight + adaptWidgetHeight(40),
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Consumer<TicketBookingModel>(
                                builder: (context, value, child) {
                              return SelectedSeatsList(
                                  withGlasses:
                                      (session.format == '3D') ? true : false,
                                  glassesPrice: session.glassPrice);
                            }),
                          ),
                        ],
                      ),
                    ),

                    Consumer<TicketBookingModel>(
                      builder: (context, value, child) {
                        return BottomNavigationButtons(
                            onPressBack: () {
                              TicketBookingModel().resetTicketBookingModel();
                              GoRouter.of(context).pop();
                            },
                            showButtonNext: value.selectedSeats.isNotEmpty,
                            onPressNext: () {
                              TicketReservationTimeModel().startTimer();
                              if (AppManager().currentScreenIndex == 0) {
                                if (AppManager().cinemarketOn) {
                                  GoRouter.of(context).goNamed(
                                      scTicketBookingForCinemarket,
                                      params: {
                                        "sessionId": widget.sessionId.toString()
                                      });
                                } else {
                                  GoRouter.of(context).goNamed(
                                      scTicketBookingForAuthorization,
                                      params: {
                                        "sessionId": widget.sessionId.toString()
                                      });
                                }
                              } else if (AppManager().currentScreenIndex == 1) {
                                if (AppManager().cinemarketOn) {
                                  GoRouter.of(context).goNamed(
                                      onTicketBookingForCinemarket,
                                      params: {
                                        "sessionId": widget.sessionId.toString()
                                      });
                                } else {
                                  GoRouter.of(context).goNamed(
                                      onTiAuthorizationForTotal,
                                      params: {
                                        "sessionId": widget.sessionId.toString()
                                      });
                                }
                              }
                            });
                      },
                    ),
                  ],
                ),
              );
            } else {
              return Text('No data...');
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
