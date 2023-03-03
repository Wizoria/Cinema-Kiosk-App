import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../service/common_functions.dart';
import '../../themes/themes.dart';

class HelpButton extends StatefulWidget {
  const HelpButton({
    Key? key,
  }) : super(key: key);

  @override
  State<HelpButton> createState() => _HelpButtonState();
}

class _HelpButtonState extends State<HelpButton> {
  @override
  void initState() {
    super.initState();
  }

  bool helpChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {
            setState(() => helpChecked = !helpChecked);
          },
          icon: Container(
            width: adaptWidgetWidth(240),
            height: adaptWidgetHeight(240),
            padding: EdgeInsets.all(adaptWidgetWidth(20)),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              shape: BoxShape.circle,
            ),
            child: Container(
              padding: EdgeInsets.all(adaptWidgetWidth(20)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.20),
                shape: BoxShape.circle,
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Theme.of(context).colorScheme.primary,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.80),
                      Theme.of(context).colorScheme.onPrimary.withOpacity(0.80),
                    ],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  ),
                  shape: BoxShape.circle,
                ),
                child: helpChecked
                    ? SvgPicture.asset(
                        width: adaptWidgetWidth(40),
                        height: adaptWidgetHeight(40),
                        "assets/icons/checked.svg")
                    : Text(
                        'Виклик адміністратора',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .apply(color: white),
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: adaptWidgetHeight(20),
        ),
        Text(helpChecked ? 'Адміністратор підійде \n за декілька хвилин' : '',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall),
      ],
    );
  }
}
