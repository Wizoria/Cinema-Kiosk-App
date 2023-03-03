import 'package:flutter/material.dart';
import '../../service/common_functions.dart';
import '../themes/themes.dart';

class DotsIndicator extends StatelessWidget {
  final int itemLength;
  final int currentIndex;

  const DotsIndicator({
    Key? key,
    required this.itemLength,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: adaptWidgetHeight(20),
      margin: EdgeInsets.only(bottom: adaptWidgetHeight(10)),
      padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(65)),
      child: Wrap(
        runAlignment: WrapAlignment.center,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: List.generate(
          itemLength,
          (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: currentIndex == index ? adaptWidgetWidth(15) : adaptWidgetWidth(10),
            height: currentIndex == index ? adaptWidgetWidth(15) : adaptWidgetWidth(10),
            decoration: BoxDecoration(
                color: currentIndex == index ? Theme.of(context).colorScheme.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(adaptWidgetWidth(30)),
                border: Border.all(width: adaptWidgetWidth(1),
                    color: currentIndex == index ? Theme.of(context).colorScheme.primary : gray)),
            margin: EdgeInsets.all(currentIndex == index ? adaptWidgetWidth(4) : adaptWidgetWidth(7)),
          ),
        ),
      ),
    );
  }
}
