import 'dart:developer';
import 'package:flutter/material.dart';
import '../../../models/check_model.dart';
import '../../../models/total_item.dart';
import '../../../service/app_manager.dart';
import '../../../service/common_functions.dart';
import '../../styles/styles.dart';
import '../schedule/session_list_element_schedule.dart';
import 'modal_dialog.dart';

class TotalList extends StatelessWidget {
  const TotalList({
    Key? key,
    required this.sessionId,
  }) : super(key: key);

  final int sessionId;

  @override
  Widget build(BuildContext context) {
    List<TotalItem> check = CheckModel().getCheckList();
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(65)),
        child: Column(
          children: [
            SizedBox(
              height: adaptWidgetHeight(30),
            ),
            if (sessionId != 0) ...[
              MovieSchedule(
                sessionId: sessionId,
              ),
              const TicketReservationTime(text: 'Замовлення'),
            ] else if (sessionId == 0) ...[
              Container(
                  padding:
                      EdgeInsets.symmetric(vertical: adaptWidgetHeight(30)),
                  alignment: Alignment.centerLeft,
                  child: Text('Замовлення',
                      style: Theme.of(context).textTheme.headlineLarge)),
            ],
            Expanded(
              child: RawScrollbar(
                thumbColor:
                    AppManager().isDarkThemeOn ? Colors.grey : Colors.black54,
                thumbVisibility: true,
                thickness: adaptWidgetWidth(5),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(adaptWidgetWidth(40)),
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            borderRadius:
                                BorderRadius.circular(adaptWidgetWidth(25))),
                        child: Column(
                          children: [
                            Column(
                              children: List.generate(
                                check.length,
                                (index) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        bottom: adaptWidgetHeight(14)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(check[index].name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                        const Spacer(),
                                        Text(
                                            '${check[index].amount} x ${removeTrailingZeros(check[index].price)} ₴',
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                        Container(
                                          alignment: Alignment.centerRight,
                                          width: adaptWidgetWidth(100),
                                          child: Text(
                                              '${removeTrailingZeros(check[index].totalPrice)} ₴',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyLarge),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Разом',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                                Text('${CheckModel().total.toString()} ₴',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: adaptWidgetHeight(10)),
                        child: MyCheckbox(
                            isActive: false,
                            onPressed: () => showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const PromoModalDialog();
                                }),
                            text: 'Застосувати промокод',
                            price: 0),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: adaptWidgetHeight(10)),
                        child: MyCheckbox(
                            isActive: true,
                            onPressed: () => log('сертифікат'),
                            text: 'Застосувати подарунковий сертифікат',
                            price: 250),
                      ),
                      true
                          ? Padding(
                              padding:
                                  EdgeInsets.only(top: adaptWidgetHeight(20)),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: adaptWidgetWidth(40)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('До сплати',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge),
                                    Text('${CheckModel().total.toString()} ₴',
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayLarge)
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: adaptWidgetHeight(10)),
              child: MyCheckbox(
                  isActive: true,
                  onPressed: () => log('ознайомлений'),
                  text:
                      'Погоджуюсь з офіційними правилами мережі \nкінотеатрів Wizoria та підтверджую, що ознайомлений \nз віковими обмеженнями на цей фільм'),
            ),
          ],
        ),
      ),
    );
  }
}
