import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import '../../../models/movie.dart';
import 'package:cinema_kiosk_app/service/app_manager.dart';
import '../../../models/movies_coming_soon.dart';
import '../../../navigation/nav_router.dart';
import '../../../repository/coming_soon_repository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../themes/themes.dart';

class ComingSoonList extends StatefulWidget {
  const ComingSoonList({Key? key}) : super(key: key);

  @override
  State createState() => _ComingSoonListState();
}

class _ComingSoonListState extends State<ComingSoonList> {
  late Future<List<Movie>> _futureMovieList;

  @override
  void initState() {
    super.initState();
    _futureMovieList = ComingSoonRepository()
        .getComingSoonMoviesByCinemaId(AppManager().cinemaSettings.cinemaId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: _futureMovieList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Movie> movies = snapshot.data as List<Movie>;

            MoviesComingSoon().allMoviesComingSoon = movies;
            return Column(
              children: [
                SizedBox(
                  height: adaptWidgetHeight(70),
                ),
                Text(AppLocalizations.of(context)!.comingSoon,
                    style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(
                  height: adaptWidgetHeight(20),
                ),
                Expanded(
                  child: AnimationLimiter(
                    child: GridView.builder(
                      padding: EdgeInsets.symmetric(
                          vertical: adaptWidgetHeight(20),
                          horizontal: adaptWidgetWidth(70)),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 0.56,
                        crossAxisSpacing: adaptWidgetWidth(16),
                        mainAxisSpacing: adaptWidgetHeight(16),
                      ),
                      scrollDirection: Axis.vertical,
                      itemCount: movies.length,
                      itemBuilder: (context, index) {
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 1,
                          child: ScaleAnimation(
                            scale: 0.95,
                            child: FadeInAnimation(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppManager().isDarkThemeOn
                                          ? const Color.fromRGBO(
                                              209, 209, 209, 0.10)
                                          : const Color.fromRGBO(0, 0, 0, 0.25),
                                      spreadRadius: 3,
                                      blurRadius: 20,
                                      offset: const Offset(
                                          0, 0), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () => GoRouter.of(context)
                                      .goNamed(comingSoonForMovieCard, params: {
                                    "movieId": movies[index].id.toString()
                                  }),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                        adaptWidgetWidth(10)),
                                    child: Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: double.maxFinite,
                                          height: double.maxFinite,
                                          imageUrl:
                                              movies[index].movieImgMobile2,
                                          placeholder: (context, url) =>
                                              const FractionallySizedBox(
                                                widthFactor: 0.9,
                                                child: FittedBox(fit: BoxFit.contain,child: CircularProgressIndicator(strokeWidth: 0.5)),
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              bottom: adaptWidgetHeight(20),
                                              right: adaptWidgetWidth(10)),
                                          alignment: Alignment.center,
                                          width: adaptWidgetWidth(140),
                                          height: adaptWidgetHeight(46),
                                          decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  Theme.of(context)
                                                      .colorScheme
                                                      .onPrimary,
                                                ],
                                                begin:
                                                    FractionalOffset.centerLeft,
                                                end: FractionalOffset
                                                    .centerRight,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      adaptWidgetWidth(30))),
                                          child: Text(movies[index].releaseDateDescription
                                              .replaceAll("Прем'єра", 'з'),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall!
                                                  .apply(color: white),
                                              textAlign: TextAlign.center),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
