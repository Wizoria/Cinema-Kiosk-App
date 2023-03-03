import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';

class SwitchSessionsHalls extends StatefulWidget {
  const SwitchSessionsHalls({
    Key? key,
  }) : super(key: key);

  @override
  State<SwitchSessionsHalls> createState() => _NewWidgetState();
}

class _NewWidgetState extends State<SwitchSessionsHalls> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xff202020), borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.19),
            // spreadRadius: 0.1,
            // blurRadius: 0.1,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      height: adaptWidgetHeight(45),
      child: Stack(
        children: [
          AnimatedContainer(
            alignment:
                (selected) ? Alignment.centerRight : Alignment.centerLeft,
            duration: const Duration(milliseconds: 200),
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xff8C64C9),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Flexible(
                flex: 50,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = false;
                    });
                  },
                  child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Text(
                        'Сеанси',
                        style: TextStyle(
                            fontSize: adaptWidgetHeight(18)),
                      )),
                ),
              ),
              Flexible(
                flex: 50,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = true;
                    });
                  },
                  child: Container(
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Text('Зали',
                          style: TextStyle(
                              fontSize: adaptWidgetHeight(18)))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
