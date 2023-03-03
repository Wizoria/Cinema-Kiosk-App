import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../models/movie.dart';
import '../../../models/movies_on_sale.dart';
import '../../../navigation/nav_router.dart';
import '../../../service/common_functions.dart';
import '../../styles/gradient_box_border.dart';
import '../../styles/scrolling_with_dimming.dart';
import '../../styles/styles.dart';
import '../../themes/themes.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SessionsListWithFiltration extends StatefulWidget {
  const SessionsListWithFiltration({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  State<SessionsListWithFiltration> createState() =>
      _SessionsListWithFiltration();
}

class _SessionsListWithFiltration extends State<SessionsListWithFiltration> {
  void _changeDate(int movieId, DateTime selectedDate) {
    for (Movie movie in MoviesOnSale().filtratedMoviesOnSale) {
      if (movie.id == movieId) {
        widget.movie.performMovieSessionsDateFiltration();
      }
    }
    AppManager().uniqueKeyOnSale = UniqueKey();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
              alignment: Alignment.bottomLeft,
              child: Text(
                'Оберіть дату:',
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Container(
              height: adaptWidgetHeight(55),
              margin: EdgeInsets.symmetric(vertical: adaptWidgetWidth(20)),
              alignment: Alignment.topLeft,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  AnimationLimiter(
                    child: ScrollingWithDimming.builder(
                      options: Options(
                        height: adaptWidgetWidth(55),
                        sizeItem: adaptWidgetWidth(105),
                      ),
                      itemCount: widget.movie.allShowDates.length,
                      // itemCount: 15,
                      itemBuilder: (context, index) =>
                          AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          horizontalOffset: adaptWidgetHeight(50),
                          child: FadeInAnimation(
                            child: Container(
                              margin:
                                  EdgeInsets.only(right: adaptWidgetWidth(10)),
                              child: SessionDateButton(
                                dateTime: widget.movie.allShowDates[index],
                                isActive: daysOfDatesEqualAreEqual(
                                    widget.movie.allShowDates[index],
                                    widget.movie.selectedShowDate),
                                onPressed: () {
                                  MoviesOnSale().updateCurrentDate(
                                      widget.movie.allShowDates[index]);
                                  MoviesOnSale().updateCurrentFormat('All');
                                  MoviesOnSale().performSessionFiltration();
                                  _changeDate(widget.movie.id,
                                      widget.movie.allShowDates[index]);
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: adaptWidgetWidth(440),
              child: Column(
                children: [
                  SizedBox(
                    height: adaptWidgetHeight(10),
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: widget.movie.filtratedSessions.isNotEmpty
                        ? Text(
                            'Оберіть потрібний сеанс:',
                            style: Theme.of(context).textTheme.displaySmall,
                          )
                        : widget.movie.allShowDates.length > 1
                            ? Text(
                                'Найближчий сеанс:',
                                style: Theme.of(context).textTheme.displaySmall,
                              )
                            : SizedBox(
                                height: adaptWidgetHeight(30),
                              ),
                  ),
                  SizedBox(height: adaptWidgetHeight(12)),
                  widget.movie.filtratedSessions.isNotEmpty
                      ? AnimationLimiter(
                          key: AppManager().uniqueKeyOnSale,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const ClampingScrollPhysics(),
                            itemCount: widget.movie.filtratedSessions.length,
                            itemBuilder: (context, sessionIndex) {
                              return AnimationConfiguration.staggeredList(
                                position: sessionIndex,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: adaptWidgetHeight(20),
                                  child: FadeInAnimation(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: adaptWidgetHeight(5),
                                      ),
                                      height: adaptWidgetHeight(66),
                                      child: MaterialButton(
                                        elevation: 0,
                                        hoverElevation: 0,
                                        focusElevation: 0,
                                        highlightElevation: 0,
                                        padding: EdgeInsets.zero,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(55)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surface,
                                        onPressed: () {
                                          GoRouter.of(context).pushNamed(
                                            onSaleForTicketBooking,
                                            params: {
                                              "sessionId": widget
                                                  .movie
                                                  .filtratedSessions[
                                                      sessionIndex]
                                                  .id
                                                  .toString()
                                            },
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Container(
                                              width: adaptWidgetWidth(200),
                                              margin: EdgeInsets.all(
                                                  adaptWidgetWidth(4)),
                                              alignment: Alignment.center,
                                              height: double.maxFinite,
                                              decoration: BoxDecoration(
                                                  border: GradientBoxBorder(
                                                    width: adaptWidgetWidth(2),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .primary,
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .onPrimary,
                                                      ],
                                                      begin: FractionalOffset
                                                          .centerLeft,
                                                      end: FractionalOffset
                                                          .centerRight,
                                                    ),
                                                  ),
                                                  gradient: LinearGradient(
                                                    colors: [
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .primaryContainer,
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onPrimaryContainer,
                                                    ],
                                                    begin: FractionalOffset
                                                        .centerLeft,
                                                    end: FractionalOffset
                                                        .centerRight,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              child: RichText(
                                                text: TextSpan(
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall!
                                                      .apply(color: white),
                                                  text: widget
                                                      .movie
                                                      .filtratedSessions[
                                                          sessionIndex]
                                                      .timeStart,
                                                  children: <TextSpan>[
                                                    const TextSpan(text: ' - '),
                                                    TextSpan(
                                                        text: widget
                                                            .movie
                                                            .filtratedSessions[
                                                                sessionIndex]
                                                            .timeEnd,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .apply(
                                                                color: white)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: adaptWidgetWidth(14),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    if (widget
                                                            .movie
                                                            .filtratedSessions[
                                                                sessionIndex]
                                                            .price !=
                                                        widget
                                                            .movie
                                                            .filtratedSessions[
                                                                sessionIndex]
                                                            .priceVIP) ...[
                                                      Text(
                                                        '${widget.movie.filtratedSessions[sessionIndex].price} ₴',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ],
                                                    if (widget
                                                        .movie
                                                        .filtratedSessions[
                                                            sessionIndex]
                                                        .isVip) ...[
                                                      if (widget
                                                              .movie
                                                              .filtratedSessions[
                                                                  sessionIndex]
                                                              .price !=
                                                          widget
                                                              .movie
                                                              .filtratedSessions[
                                                                  sessionIndex]
                                                              .priceVIP)
                                                        Text(
                                                          ' / ',
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyLarge,
                                                        ),
                                                      Text(
                                                        '${widget.movie.filtratedSessions[sessionIndex].priceVIP} ₴',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                      Text(
                                                        ' LUX',
                                                        textHeightBehavior:
                                                            const TextHeightBehavior(
                                                                applyHeightToLastDescent:
                                                                    false),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .labelSmall!
                                                            .apply(
                                                                color: Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .secondary),
                                                      ),
                                                    ]
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: adaptWidgetHeight(4),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      widget
                                                          .movie
                                                          .filtratedSessions[
                                                              sessionIndex]
                                                          .format,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .apply(
                                                              color: widget
                                                                          .movie
                                                                          .filtratedSessions[
                                                                              sessionIndex]
                                                                          .format ==
                                                                      '3D'
                                                                  ? Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .secondary
                                                                  : gray),
                                                    ),
                                                    Text(
                                                      widget
                                                          .movie
                                                          .filtratedSessions[
                                                              sessionIndex]
                                                          .formatString,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .apply(color: gray),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      : widget.movie.allShowDates.length > 1
                          ? Padding(
                              padding:
                                  EdgeInsets.only(top: adaptWidgetHeight(10)),
                              child: SizedBox(
                                height: adaptWidgetHeight(60),
                                width: adaptWidgetWidth(200),
                                child: SessionDateButton(
                                    dateTime: widget.movie.allShowDates[1],
                                    isActive: true,
                                    onPressed: () {
                                      MoviesOnSale().updateCurrentDate(
                                          widget.movie.allShowDates[1]);
                                      MoviesOnSale().updateCurrentFormat('All');
                                      MoviesOnSale().performSessionFiltration();
                                      _changeDate(widget.movie.id,
                                          widget.movie.allShowDates[1]);
                                    }),
                              ),
                            )
                          : Text(
                              'Сеанси відсутні',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
