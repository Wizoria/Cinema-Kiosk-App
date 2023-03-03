import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:cinema_kiosk_app/ui/screens/ticket_booking/ticket_booking_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../service/common_functions.dart';
import '../../styles/gradient_box_border.dart';

class SelectedSeatsList extends StatelessWidget {
  final bool withGlasses;
  final int glassesPrice;

  const SelectedSeatsList(
      {Key? key, required this.withGlasses, required this.glassesPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalTicket = TicketBookingModel().totalTicket();
    int totalGlasses = TicketBookingModel().totalGlasses();
    return RawScrollbar(
      thumbColor: AppManager().isDarkThemeOn ? Colors.grey : Colors.black54,
      thumbVisibility: true,
      thickness: adaptWidgetWidth(5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: List.generate(TicketBookingModel().selectedSeats.length,
                  (index) {
                int row = TicketBookingModel().selectedSeats[index].row;
                int seat = TicketBookingModel().selectedSeats[index].seat;
                int priceK = TicketBookingModel().selectedSeats[index].priceK;
                int priceGlasses =
                    TicketBookingModel().selectedSeats[index].priceGlasses;
                return Padding(
                  padding: EdgeInsets.only(bottom: adaptWidgetHeight(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: adaptWidgetWidth(400),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AppManager().isDarkThemeOn
                                ? SvgPicture.asset(
                                    height: adaptWidgetHeight(64),
                                    "assets/icons/ticket_layer_night.svg",
                                    fit: BoxFit.contain)
                                : SvgPicture.asset(
                                    height: adaptWidgetHeight(64),
                                    "assets/icons/ticket_layer_day.svg",
                                    fit: BoxFit.contain),
                            Row(
                              children: [
                                SizedBox(
                                  width: adaptWidgetWidth(40),
                                ),
                                SizedBox(
                                  width: adaptWidgetWidth(24),
                                  child: Text(
                                    row.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                                SizedBox(
                                  width: adaptWidgetWidth(8),
                                ),
                                Text(
                                  'ряд',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                SizedBox(
                                  width: adaptWidgetWidth(15),
                                ),
                                SizedBox(
                                  width: adaptWidgetWidth(25),
                                  child: Text(
                                    seat.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
                                  ),
                                ),
                                SizedBox(
                                  width: adaptWidgetWidth(8),
                                ),
                                Text(
                                  'місце',
                                  style:
                                      Theme.of(context).textTheme.displayMedium,
                                ),
                                SizedBox(
                                  width: adaptWidgetWidth(40),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${priceK + priceGlasses} ₴',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge,
                                      ),
                                      MaterialButton(
                                        minWidth: adaptWidgetWidth(32),
                                        height: adaptWidgetHeight(32),
                                        padding: EdgeInsets.zero,
                                        shape: const CircleBorder(),
                                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                        onPressed: () => TicketBookingModel()
                                            .updateSelectedSeats(
                                                TicketBookingModel()
                                                    .selectedSeats[index]),
                                        child: Container(
                                          alignment: Alignment.center,
                                          width: adaptWidgetWidth(32),
                                          height: adaptWidgetWidth(32),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              border: Border.all(
                                                  width: adaptWidgetWidth(1),
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .outline)),
                                          child: Icon(
                                            Icons.close,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                            size: adaptWidgetWidth(12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: adaptWidgetWidth(30),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      withGlasses
                          ? Container(
                              alignment: Alignment.center,
                              width: adaptWidgetWidth(40),
                              child: Text(
                                '+',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: adaptWidgetWidth(20)),
                              ))
                          : const SizedBox(),
                      withGlasses
                          ? Container(
                              width: adaptWidgetWidth(300),
                              height: adaptWidgetHeight(64),
                              decoration: BoxDecoration(
                                  border: GradientBoxBorder(
                                    width: 1,
                                    gradient: LinearGradient(
                                      colors: [
                                        TicketBookingModel()
                                                    .selectedSeats[index]
                                                    .priceGlasses >
                                                0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .inverseSurface,
                                        TicketBookingModel()
                                                    .selectedSeats[index]
                                                    .priceGlasses >
                                                0
                                            ? Theme.of(context)
                                                .colorScheme
                                                .onPrimary
                                            : Theme.of(context)
                                                .colorScheme
                                                .inverseSurface,
                                      ],
                                      begin: FractionalOffset.centerLeft,
                                      end: FractionalOffset.centerRight,
                                    ),
                                  ),
                                  borderRadius: BorderRadius.circular(
                                      adaptWidgetWidth(10)),
                                  color: Theme.of(context).colorScheme.surface),
                              child: MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: adaptWidgetWidth(18)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        adaptWidgetWidth(10))),
                                onPressed: () {
                                  TicketBookingModel().updateSelectedSeats(
                                      null, index, glassesPrice);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                        width: adaptWidgetWidth(32),
                                        height: adaptWidgetWidth(32),
                                        "assets/icons/glasses_button_image.svg",
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline,
                                        fit: BoxFit.fill),
                                    SizedBox(
                                      width: adaptWidgetWidth(8),
                                    ),
                                    TicketBookingModel()
                                                .selectedSeats[index]
                                                .priceGlasses >
                                            0
                                        ? Row(
                                            children: [
                                              Container(
                                                width: adaptWidgetWidth(32),
                                                height: adaptWidgetWidth(32),
                                                padding: EdgeInsets.all(
                                                    adaptWidgetWidth(6)),
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary),
                                                child: SvgPicture.asset(
                                                    "assets/icons/checked.svg",
                                                    fit: BoxFit.contain),
                                              ),
                                              SizedBox(
                                                width: adaptWidgetWidth(8),
                                              ),
                                              Text(
                                                ' додано ',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Text(
                                                'додати 3D окуляри',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                              ),
                                              SizedBox(
                                                width: adaptWidgetWidth(8),
                                              ),
                                              Text(
                                                '$glassesPrice ₴',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayLarge,
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                );
              }),
            ),
            TicketBookingModel().total > 0
                ? Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: adaptWidgetWidth(withGlasses ? 220 : 380),
                        vertical: adaptWidgetHeight(16)),
                    child: SizedBox(
                      width: adaptWidgetWidth(190),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Квитки:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                              Text('$totalTicket ₴',
                                  style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          withGlasses
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('3D-окуляри:',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium),
                                    Text('$totalGlasses ₴',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                  ],
                                )
                              : const SizedBox()
                        ],
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
