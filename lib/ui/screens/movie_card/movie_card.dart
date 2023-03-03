import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_kiosk_app/models/movie.dart';
import 'package:cinema_kiosk_app/models/movies_on_sale.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:cinema_kiosk_app/ui/components/main_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../models/movies_coming_soon.dart';
import '../../../service/app_manager.dart';
import '../../components/bottom_navigation_buttons.dart';
import '../../styles/marquee.dart';
import '../../themes/themes.dart';
import '../on_sale/sessions_list_with_filtration.dart';

class MovieCard extends StatelessWidget {
  final int movieCardId;

  const MovieCard({Key? key, required this.movieCardId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMovieOnSale = true;

    Movie movie = MoviesOnSale().getMovieById(movieCardId);

    if (movie.id == 0) {
      movie = MoviesComingSoon().getMovieById(movieCardId);
      isMovieOnSale = false;
    }
    // Обробка html тегів опису фільму
    String movieDescription = movie.movieDescription
        .replaceAll('\n', '')
        .replaceAll(' <br> ', '\n')
        .replaceAll('<br> ', '\n')
        .replaceAll(' <br>', '\n')
        .replaceAll('<br>', '\n');
    String movieDescriptionStrong = '';
    int textStart = movieDescription.indexOf('<strong>');
    int textEnd = movieDescription.indexOf('</strong>');
    if (textStart != -1 && textEnd != -1) {
      movieDescriptionStrong =
          movieDescription.substring(textStart + 8, textEnd).trim();
      movieDescription = movieDescription.substring(0, textStart);
    }

    String? tagType;
    String tagName = '';
    Color gradientStart = white.withOpacity(0.8);
    Color gradientEnd = white.withOpacity(0.8);
    bool flag = false;
    if (movie.sessions.isNotEmpty) {
      for (var tag in movie.sessions[0].tags) {
        if (tag.tagType == "sticker_blue" ||
            tag.tagType == "sticker_green" ||
            tag.tagType == "sticker_orange" ||
            tag.tagType == "sticker_orange" ||
            tag.tagType == "sticker" ||
            tag.tagType == "sticker_ukr" ||
            tag.tagType == "sticker_orig_lang_en" ||
            tag.tagType == "sticker_orig_lang_fr" ||
            tag.tagType == "sticker_orig_lang_ger" ||
            tag.tagType == "sticker_orig_lang_rus") {
          tagType = tag.tagType;
          tagName = tag.tagName;
          if (tagType == "sticker_blue") {
            gradientStart = const Color(0xff66AFEE).withOpacity(0.9);
            gradientEnd = const Color(0xff87A1F9).withOpacity(0.9);
          } else if (tagType == "sticker_green") {
            gradientStart = const Color(0xff57D754).withOpacity(0.9);
            gradientEnd = const Color(0xff81D3A2).withOpacity(0.9);
          } else if (tagType == "sticker_orange") {
            gradientStart = const Color(0xffF37722).withOpacity(0.9);
            gradientEnd = const Color(0xffE7A416).withOpacity(0.9);
          } else if (tagType == "sticker_pink") {
            gradientStart = const Color(0xffEC3378).withOpacity(0.9);
            gradientEnd = const Color(0xffEC3378).withOpacity(0.9);
          } else {
            flag = true;
          }
          break;
        }
      }
    }

    return Material(
      child: Column(
        children: [
          const MainHeader(),
          Expanded(
            child: SizedBox(
              width: adaptWidgetWidth(800),
              child: ListView(
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.all(adaptWidgetWidth(40)),
                children: [
                  Column(
                    children: [
                      Container(
                        height: adaptWidgetWidth(900),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(adaptWidgetWidth(30)),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppManager().isDarkThemeOn
                                  ? const Color.fromRGBO(209, 209, 209, 0.10)
                                  : const Color.fromRGBO(0, 0, 0, 0.20),
                              spreadRadius: 8,
                              blurRadius: 22,
                              offset: const Offset(
                                  0, 0), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(adaptWidgetWidth(30)),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              CachedNetworkImage(
                                width: double.maxFinite,
                                height: double.maxFinite,
                                fit: BoxFit.cover,
                                imageUrl: movie.movieImg1,
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      if (tagType != null)
                                        Container(
                                          constraints: BoxConstraints(
                                            minHeight: adaptWidgetHeight(50),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: flag
                                                  ? adaptWidgetWidth(5)
                                                  : adaptWidgetWidth(30)),
                                          alignment: Alignment.center,
                                          margin:
                                              const EdgeInsets.only(top: 12),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                gradientStart,
                                                gradientEnd,
                                              ],
                                              begin:
                                                  FractionalOffset.centerLeft,
                                              end: FractionalOffset.centerRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                adaptWidgetWidth(30)),
                                          ),
                                          child: Row(
                                            children: [
                                              if (flag) ...[
                                                if (tagType == "sticker_ukr")
                                                  SizedBox(
                                                    width: adaptWidgetWidth(42),
                                                    height:
                                                        adaptWidgetWidth(42),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      child: Column(
                                                        children: [
                                                          Flexible(
                                                              flex: 5,
                                                              child: Container(
                                                                  color: Colors
                                                                      .blue)),
                                                          Flexible(
                                                              flex: 5,
                                                              child: Container(
                                                                  color: Colors
                                                                      .yellow)),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                if (tagType ==
                                                    "sticker_orig_lang_en")
                                                  SvgPicture.asset(
                                                      "assets/icons/flag_circle_en.svg",
                                                      fit: BoxFit.contain),
                                                SizedBox(
                                                  width: adaptWidgetWidth(10),
                                                ),
                                              ],
                                              Container(
                                                padding: EdgeInsets.only(
                                                    bottom: tagName.length > 50
                                                        ? 4
                                                        : 0),
                                                constraints: BoxConstraints(
                                                    maxWidth:
                                                        adaptWidgetWidth(400)),
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                  tagName,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .apply(
                                                          color: flag
                                                              ? black
                                                              : white),
                                                ),
                                              ),
                                              if (flag)
                                                SizedBox(
                                                  width: adaptWidgetWidth(20),
                                                ),
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                              if (!isMovieOnSale)
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            bottom: adaptWidgetHeight(20),
                                            right: adaptWidgetWidth(20)),
                                        alignment: Alignment.center,
                                        width: adaptWidgetWidth(140),
                                        height: adaptWidgetHeight(46),
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius: BorderRadius.circular(
                                                adaptWidgetWidth(30))),
                                        child: Text(
                                            movie.releaseDateDescription
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
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: adaptWidgetHeight(34)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: adaptWidgetWidth(530)),
                            // width: adaptWidgetWidth(530),
                            child: MarqueeWidget(
                              direction: Axis.horizontal,
                              child: Text(movie.title,
                                  style:
                                      Theme.of(context).textTheme.titleSmall),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      right: adaptWidgetWidth(10)),
                                  alignment: Alignment.center,
                                  width: adaptWidgetHeight(45),
                                  height: adaptWidgetHeight(45),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: adaptWidgetWidth(1),
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(movie.age,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: adaptWidgetWidth(10)),
                                  alignment: Alignment.center,
                                  width: adaptWidgetHeight(45),
                                  height: adaptWidgetHeight(45),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: adaptWidgetWidth(1),
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                    ),
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                      color:
                                          Theme.of(context).colorScheme.outline,
                                      width: adaptWidgetHeight(18),
                                      height: adaptWidgetHeight(18),
                                      "assets/icons/arrow_clock.svg",
                                      fit: BoxFit.contain),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${movie.runtime.toString()} хв',
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: adaptWidgetHeight(0),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(movie.genre,
                              style: Theme.of(context).textTheme.bodyMedium),
                          SizedBox(
                            height: adaptWidgetHeight(20),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Режисер:   ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: gray),
                              children: <TextSpan>[
                                TextSpan(
                                  text: movie.producer,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: adaptWidgetHeight(14),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Виробництво:   ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: gray),
                              children: <TextSpan>[
                                TextSpan(
                                  text: movie.country,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: adaptWidgetHeight(14),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Сценарій:   ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: gray),
                              children: <TextSpan>[
                                TextSpan(
                                  text: movie.scenarist,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: adaptWidgetHeight(14),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'У головних ролях:   ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: gray),
                              children: <TextSpan>[
                                TextSpan(
                                  text: movie.actors,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: adaptWidgetHeight(14),
                          ),
                          RichText(
                            text: TextSpan(
                              text: 'Опис:   ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .apply(color: gray),
                              children: <TextSpan>[
                                TextSpan(
                                  text: movieDescription,
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                TextSpan(
                                  text: movieDescriptionStrong,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(fontWeightDelta: 700),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: adaptWidgetHeight(40))
                        ],
                      ),
                      SizedBox(height: adaptWidgetHeight(20)),
                      if (isMovieOnSale) ...[
                        movie.sessions.isNotEmpty
                            ? SessionsListWithFiltration(movie: movie)
                            : const SizedBox(),
                      ]
                    ],
                  ),
                ],
              ),
            ),
          ),
          BottomNavigationButtons(
            onPressBack: () => GoRouter.of(context).pop(),
          )
        ],
      ),
    );
  }
}
