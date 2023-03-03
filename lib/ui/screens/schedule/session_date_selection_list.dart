import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../../styles/scrolling_with_dimming.dart';
import '../../styles/styles.dart';

class SessionDateSelectionList extends StatefulWidget {
  const SessionDateSelectionList({
    Key? key,
  }) : super(key: key);

  @override
  State<SessionDateSelectionList> createState() =>
      _SessionDateSelectionListState();
}

class _SessionDateSelectionListState extends State<SessionDateSelectionList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoviesOnSale>(
      builder: (context, movie, child) {
        return Stack(
          alignment: Alignment.centerRight,
          children: [
            AnimationLimiter(
              child: ScrollingWithDimming.builder(
                options: Options(
                  // width: adaptWidgetWidth(910),
                  height: adaptWidgetWidth(55),
                  sizeItem: adaptWidgetWidth(105),
                ),
                itemCount: movie.allShowDates.length,
                itemBuilder: (context, index) =>
                    AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    horizontalOffset: adaptWidgetHeight(50),
                    child: FadeInAnimation(
                      child: Container(
                        margin: EdgeInsets.only(right: adaptWidgetWidth(10)),
                        child: SessionDateButton(
                          dateTime: movie.allShowDates[index],
                          isActive: (daysOfDatesEqualAreEqual(
                              movie.selectedShowDate,
                              movie.allShowDates[index])),
                          onPressed: () {
                            movie.updateCurrentDate(movie.allShowDates[index]);
                            movie.performSessionFiltration();
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
