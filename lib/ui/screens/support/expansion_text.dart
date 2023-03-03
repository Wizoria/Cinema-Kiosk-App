import 'package:flutter/material.dart';
import '../../../service/common_functions.dart';

class ExpansionText extends StatefulWidget {
  const ExpansionText({
    Key? key,
    required String title,
    required String text,
  })  : _title = title,
        _text = text,
        super(key: key);

  final String _title;
  final String _text;

  @override
  State<ExpansionText> createState() => _ExpansionTextState();
}

class _ExpansionTextState extends State<ExpansionText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool showText = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: adaptWidgetHeight(100)),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(adaptWidgetWidth(30)),
          color: Theme.of(context).colorScheme.surface),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(
              vertical: adaptWidgetHeight(22),
              horizontal: adaptWidgetWidth(30)),
          childrenPadding: EdgeInsets.zero,
          title:
              Text(widget._title, style: Theme.of(context).textTheme.bodyLarge),
          expandedAlignment: Alignment.topCenter,
          collapsedTextColor: Theme.of(context).colorScheme.outline,
          textColor: Theme.of(context).colorScheme.primary,
          trailing: RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(_animation),
            child: RotatedBox(
              quarterTurns: 3,
              child: Container(
                padding: EdgeInsets.all(adaptWidgetWidth(16)),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.onSecondary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back_ios_sharp,
                    size: adaptWidgetWidth(16),
                    color: Theme.of(context).colorScheme.outline),
              ),
            ),
          ),
          children: [
            ListTile(
              title: Container(
                padding: EdgeInsets.only(
                    left: adaptWidgetWidth(18),
                    right: adaptWidgetWidth(60),
                    bottom: adaptWidgetWidth(26)),
                child: Text(
                  widget._text,
                  style: Theme.of(context).textTheme.displaySmall,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
          onExpansionChanged: (bool expanded) {
            setState(
              () {
                showText = expanded;
                if (showText) {
                  _controller.forward();
                } else {
                  _controller.animateTo(0);
                }
              },
            );
          },
        ),
      ),
    );
  }
}
