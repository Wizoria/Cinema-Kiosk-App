import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:cinema_kiosk_app/ui/components/main_header.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/presence_model.dart';
import '../../../navigation/nav_router.dart';
import '../../../service/app_manager.dart';
import '../../components/bottom_menu.dart';
import 'expansion_text.dart';
import 'help_button.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final refundOfTicketsTitle = 'Повернення квитків';

  final refundOfTicketsText =
      'При купівлі квитків за готівку – повертаються гроші, при оплаті квитків банківською карткою – кошти повертаються на картку, з якої здійснювалася оплата.\n \nЗвернення в касу про повернення квитків приймаються не пізніше як за 30 хвилин до початку сеансу.\n \nДля здійснення повернення коштів у касі необхідно надати: квитки, чек і паспорт (водійські права).Необхідно заповнити бланк заяви та акт про повернення коштів – ці документи надає касир.\n \nПовернення квитків здійснюється в касі Кінотеатру.';

  final evacuationTitle = 'Евакуація';

  final evacuationText =
      'Евакуація— процес виведення населення і життєважливих ресурсів першої необхідності з території можливої загрози від катастрофи чи воєнного конфлікту.';

  @override
  Widget build(BuildContext context) {
    if (!Navigator.canPop(context)) {
      PresenceModel().timerOff();
    }
    AppManager().currentScreen = GoRouterState.of(context).name!;

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const MainHeader(
            showCloseButton: true,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: adaptWidgetHeight(65)),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Column(
                    children: [
                      SizedBox(height: adaptWidgetHeight(70)),
                      Text('Часті питання',
                          style: Theme.of(context).textTheme.headlineLarge),
                      SizedBox(
                        height: adaptWidgetHeight(40),
                      ),
                      ExpansionText(
                          title: refundOfTicketsTitle,
                          text: refundOfTicketsText),
                      SizedBox(
                        height: adaptWidgetHeight(15),
                      ),
                      ExpansionText(
                          title: evacuationTitle, text: evacuationText),
                      SizedBox(
                        height: adaptWidgetHeight(60),
                      ),
                      Text('Потрібна допомога?',
                          style: Theme.of(context).textTheme.headlineMedium),
                      SizedBox(
                        height: adaptWidgetHeight(30),
                      ),
                      const HelpButton(),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
              icon: const Icon(Icons.lock_clock_sharp),
              onPressed: () async {
                await showDialog<void>(
                  useSafeArea: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Введіть пароль 1',
                          style: Theme.of(context).textTheme.titleSmall,
                          textAlign: TextAlign.center),
                      content: Form(
                        key: _formKey,
                        child: SizedBox(
                          height: adaptWidgetHeight(80),
                          child: TextFormField(
                            onFieldSubmitted: (value) => submitted(),
                            decoration: const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.zero,
                            ),
                            autofocus: true,
                            controller: _controller,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Введіть пароль';
                              } else if (value != '1') {
                                return 'Недійсний пароль';
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                      actions: [
                        Center(
                          child: MaterialButton(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            // height: adaptWidgetHeight(40),
                            color: Colors.white54,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60)),
                            onPressed: () => submitted(),
                            child: Text('Увійти',
                                style:
                                    Theme.of(context).textTheme.displayMedium),
                          ),
                        ),
                      ],
                    );
                  },
                );
                setState(() => _controller.clear());
              }),
          const BottomMenu(),
        ],
      ),
    );
  }

  void submitted() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      _formKey.currentState!.reset();
      GoRouter.of(context).goNamed(supportForSettings);
    }
  }
}
