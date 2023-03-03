import 'dart:developer';
import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/navigation/nav_router.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import '../../styles/gradient_box_border.dart';
import '../../themes/themes.dart';

class MovieSchedule extends StatelessWidget {
  final int sessionId;
  final bool clickable;

  const MovieSchedule(
      {Key? key, required this.sessionId, this.clickable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    Session currentSession = Session.empty();
    for (Session session in MoviesOnSale().filtratedSessionsOnSale) {
      if (sessionId == session.id) {
        currentSession = session;
      }
    }

    if (currentSession.id == 0) {
      return Text('Session not found: $sessionId');
    }

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(adaptWidgetWidth(24))),
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      margin: EdgeInsets.symmetric(vertical: adaptWidgetHeight(8)),
      child: ListTile(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(adaptWidgetWidth(24))),
        enabled: clickable,
        contentPadding: EdgeInsets.symmetric(
            horizontal: adaptWidgetWidth(24), vertical: adaptWidgetHeight(12)),
        onTap: () {
          log('${currentSession.movieTitle} ${currentSession.id} ${currentSession.date}');
          GoRouter.of(context).pushNamed(scheduleForTicketBooking,
              params: {"sessionId": sessionId.toString()});
        },
        title: Row(
          children: [
            SizedBox(
              width: adaptWidgetWidth(94),
              height: adaptWidgetHeight(150),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(adaptWidgetWidth(4)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: currentSession.movieImageRef,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: adaptWidgetWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            currentSession.movieTitle,
                            overflow: TextOverflow.fade,
                            maxLines: 1,
                            softWrap: false,
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Container(
                          padding: EdgeInsets.all(adaptWidgetWidth(9)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            children: [
                              Text(currentSession.movieAge,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .apply(color: white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: adaptWidgetHeight(4),
                    ),
                    Text(currentSession.movieGenre,
                        style: Theme.of(context).textTheme.displayMedium),
                    SizedBox(
                      height: adaptWidgetHeight(18),
                    ),
                    Row(
                      children: [
                        Text(
                          currentSession.format,
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                              color: currentSession.format == '3D'
                                  ? Theme.of(context).colorScheme.secondary
                                  : Theme.of(context).colorScheme.outline),
                        ),
                        Text(currentSession.formatString,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(color: gray),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: adaptWidgetHeight(12),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (!clickable)
                          Padding(
                            padding:
                                EdgeInsets.only(right: adaptWidgetWidth(30)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Дата сеансу:',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall),
                                SizedBox(
                                  height: adaptWidgetHeight(7),
                                ),
                                Text(
                                    DateFormat('E, dd MMMM', tag)
                                        .format(currentSession.date),
                                    style:
                                        Theme.of(context).textTheme.bodyMedium),
                              ],
                            ),
                          ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Ціна квитка:',
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            SizedBox(
                              height: adaptWidgetHeight(5),
                            ),
                            Row(
                              children: [
                                if (currentSession.price !=
                                    currentSession.priceVIP) ...[
                                  Text(
                                    '${currentSession.price} ₴',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ],
                                if (currentSession.isVip) ...[
                                  if (currentSession.price !=
                                      currentSession.priceVIP)
                                    Text(
                                      ' / ',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  RichText(
                                    text: TextSpan(
                                      text: '${currentSession.priceVIP} ₴',
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: ' LUX',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .apply(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: adaptWidgetWidth(180),
              height: adaptWidgetHeight(84),
              margin: EdgeInsets.all(adaptWidgetWidth(6)),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: GradientBoxBorder(
                  width: adaptWidgetWidth(2),
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.onPrimary,
                    ],
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                  ),
                ),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.onPrimaryContainer,
                  ],
                  begin: FractionalOffset.centerLeft,
                  end: FractionalOffset.centerRight,
                ),
                borderRadius: BorderRadius.circular(adaptWidgetWidth(40)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .apply(color: white),
                        text: currentSession.timeStart,
                        children: <TextSpan>[
                          TextSpan(
                              text: ' - ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .apply(color: white)),
                          TextSpan(
                              text: currentSession.timeEnd,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium!
                                  .apply(color: white)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: adaptWidgetHeight(2),
                    ),
                    Text(
                      'Зал ${currentSession.hallNumber}',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .apply(color: white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
