import 'package:cinema_kiosk_app/ui/screens/schedule/session_date_selection_list.dart';
import 'package:cinema_kiosk_app/ui/screens/schedule/session_format_selection_list.dart';
import 'package:cinema_kiosk_app/ui/screens/schedule/session_list_element_schedule.dart';
import 'package:flutter/material.dart';
import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:cinema_kiosk_app/models/movies_on_sale.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import '../../../models/movie.dart';
import '../../../repository/movies_repository.dart';
import 'package:provider/provider.dart';
import '../../../service/common_functions.dart';
import '../../styles/styles.dart';

class SessionListSchedule extends StatefulWidget {
  const SessionListSchedule({Key? key}) : super(key: key);

  @override
  State<SessionListSchedule> createState() => _SessionListScheduleState();
}

class _SessionListScheduleState extends State<SessionListSchedule> {
  late Future<List<Movie>> _futureMovieList;

  @override
  void initState() {
    super.initState();
    _futureMovieList = MoviesRepository()
        .getMoviesByCinemaId(AppManager().cinemaSettings.cinemaId);
    MoviesOnSale().selectedShowDate = getCurrentDate();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: FutureBuilder<List<Movie>>(
        future: _futureMovieList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List<Movie> movies = snapshot.data as List<Movie>;
              MoviesOnSale().allMoviesOnSale = movies;

              return Consumer<MoviesOnSale>(
                builder: (context, movies, child) => Padding(
                  padding: EdgeInsets.only(top: adaptWidgetHeight(70)),
                  child: movies.allShowDates.isNotEmpty
                      ? Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: adaptWidgetHeight(70)),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                'Оберіть дату та формат:',
                                style: Theme.of(context).textTheme.displaySmall,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: adaptWidgetHeight(16),
                                  bottom: adaptWidgetHeight(16),
                                  left: adaptWidgetWidth(70)),
                              child: const SessionDateSelectionList(),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(left: adaptWidgetHeight(70)),
                              child: const SessionFormatSelectionList(),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              padding: EdgeInsets.symmetric(
                                  horizontal: adaptWidgetHeight(66),
                                  vertical: adaptWidgetWidth(24)),
                              child: Text('Найближчий сеанс:',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge),
                            ),
                            movies.filtratedSessionsDateOnSale.isNotEmpty
                                ? movies.filtratedSessionsOnSale.isNotEmpty
                                    ? Expanded(
                                        child: AnimationLimiter(
                                          key: UniqueKey(),
                                          child: ListView.builder(
                                            padding: EdgeInsets.only(
                                                bottom: adaptWidgetHeight(100)),
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: movies
                                                .filtratedSessionsOnSale.length,
                                            itemBuilder: (context, index) {
                                              return AnimationConfiguration
                                                  .staggeredList(
                                                position: index,
                                                duration: const Duration(
                                                    milliseconds: 375),
                                                child: SlideAnimation(
                                                  verticalOffset:
                                                      adaptWidgetHeight(20),
                                                  child: FadeInAnimation(
                                                    child: Padding(
                                                      padding: EdgeInsets.symmetric(
                                                          horizontal:
                                                              adaptWidgetHeight(
                                                                  66)),
                                                      child: MovieSchedule(
                                                        sessionId: movies
                                                            .filtratedSessionsOnSale[
                                                                index]
                                                            .id,
                                                        clickable: true,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      )
                                    : Text('сеансів немає',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineLarge)
                                : Expanded(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            width: adaptWidgetHeight(380),
                                            height: adaptWidgetHeight(380),
                                            AppManager()
                                                        .cinemaSettings
                                                        .cinemaChainId ==
                                                    1
                                                ? "assets/icons/warning_session_wiz.svg"
                                                : "assets/icons/warning_session_cinema.svg",
                                            fit: BoxFit.contain),
                                        SizedBox(
                                          height: adaptWidgetHeight(36),
                                        ),
                                        Text(
                                            'На жаль, сеансів на сьогодні більше немає',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        SizedBox(
                                          height: adaptWidgetHeight(20),
                                        ),
                                        Text('Найближчі сеанси',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium),
                                        SizedBox(
                                          height: adaptWidgetHeight(36),
                                        ),
                                        movies.allShowDates.length > 1
                                            ? SizedBox(
                                                height: adaptWidgetHeight(50),
                                                width: adaptWidgetWidth(250),
                                                child: SessionDateButton(
                                                  dateTime:
                                                      movies.allShowDates[1],
                                                  isActive: true,
                                                  onPressed: () {
                                                    movies.updateCurrentDate(
                                                        movies.allShowDates[1]);
                                                    movies
                                                        .performSessionFiltration();
                                                  },
                                                ),
                                              )
                                            : Text('Сеанси відсутні',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineLarge),
                                        const Expanded(child: SizedBox())
                                      ],
                                    ),
                                  )
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                width: adaptWidgetHeight(580),
                                height: adaptWidgetHeight(580),
                                AppManager().cinemaSettings.cinemaChainId == 1
                                    ? "assets/icons/warning_session_wiz.svg"
                                    : "assets/icons/warning_session_cinema.svg",
                                fit: BoxFit.contain),
                            SizedBox(
                              height: adaptWidgetHeight(36),
                            ),
                            Text('Сеанси відсутні',
                                style:
                                    Theme.of(context).textTheme.headlineLarge),
                          ],
                        ),
                ),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
