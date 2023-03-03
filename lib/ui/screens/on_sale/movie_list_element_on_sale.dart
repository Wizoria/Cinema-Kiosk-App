import 'package:cached_network_image/cached_network_image.dart';
import 'package:cinema_kiosk_app/models/movies_on_sale.dart';
import 'package:cinema_kiosk_app/ui/screens/on_sale/sessions_list_with_filtration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../models/movie.dart';
import '../../../navigation/nav_router.dart';
import '../../../service/app_manager.dart';
import '../../../service/common_functions.dart';
import '../../styles/marquee.dart';
import '../../themes/themes.dart';

class MovieListElementOnSale extends StatefulWidget {
  final int movieId;

  const MovieListElementOnSale({Key? key, required this.movieId})
      : super(key: key);

  @override
  State createState() => _MovieListElementOnSaleState();
}

class _MovieListElementOnSaleState extends State<MovieListElementOnSale> {
  @override
  Widget build(BuildContext context) {
    Movie movie = MoviesOnSale().getMovieById(widget.movieId);
    String? tagType;
    String tagName = '';
    Color gradientStart = white.withOpacity(0.9);
    Color gradientEnd = white.withOpacity(0.9);
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
            gradientStart = const Color(0xff66AFEE).withOpacity(0.8);
            gradientEnd = const Color(0xff87A1F9).withOpacity(0.8);
          } else if (tagType == "sticker_green") {
            gradientStart = const Color(0xff57D754).withOpacity(0.8);
            gradientEnd = const Color(0xff81D3A2).withOpacity(0.8);
          } else if (tagType == "sticker_orange") {
            gradientStart = const Color(0xffF37722).withOpacity(0.8);
            gradientEnd = const Color(0xffE7A416).withOpacity(0.8);
          } else if (tagType == "sticker_pink") {
            gradientStart = const Color(0xffEC3378).withOpacity(0.8);
            gradientEnd = const Color(0xffEC3378).withOpacity(0.8);
          } else {
            flag = true;
          }
          break;
        }
      }
    }

    return ListView(
      padding: EdgeInsets.only(bottom: adaptWidgetHeight(30)),
      children: [
        SizedBox(
          height: adaptWidgetHeight(10),
        ),
        Container(
          margin: EdgeInsets.all(adaptWidgetWidth(30)),
          height: adaptWidgetHeight(1074),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.all(
              Radius.circular(adaptWidgetWidth(50)),
            ),
            boxShadow: [
              BoxShadow(
                color: AppManager().isDarkThemeOn
                    ? const Color.fromRGBO(209, 209, 209, 0.10)
                    : const Color.fromRGBO(0, 0, 0, 0.15),
                spreadRadius: 8,
                blurRadius: 22,
                offset: const Offset(0, 0), // changes position of shadow
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(adaptWidgetWidth(50)),
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).goNamed(onSaleForMovieCard,
                    params: {"movieId": movie.id.toString()});
              },
              child: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: double.maxFinite,
                    imageUrl: movie.movieImg1,
                    placeholder: (context, url) => const FractionallySizedBox(
                      widthFactor: 0.9,
                      child: FittedBox(
                          fit: BoxFit.contain,
                          child: CircularProgressIndicator(strokeWidth: 0.2)),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              margin: const EdgeInsets.only(top: 12),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    gradientStart,
                                    gradientEnd,
                                  ],
                                  begin: FractionalOffset.centerLeft,
                                  end: FractionalOffset.centerRight,
                                ),
                                borderRadius:
                                    BorderRadius.circular(adaptWidgetWidth(30)),
                              ),
                              child: Row(
                                children: [
                                  if (flag) ...[
                                    if (tagType == "sticker_ukr")
                                      SizedBox(
                                        width: adaptWidgetWidth(42),
                                        height: adaptWidgetWidth(42),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          child: Column(
                                            children: [
                                              Flexible(
                                                  flex: 5,
                                                  child: Container(
                                                      color: Colors.blue)),
                                              Flexible(
                                                  flex: 5,
                                                  child: Container(
                                                      color: Colors.yellow)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (tagType == "sticker_orig_lang_en")
                                      SvgPicture.asset(
                                          "assets/icons/flag_circle_en.svg",
                                          fit: BoxFit.contain),
                                    SizedBox(
                                      width: adaptWidgetWidth(10),
                                    ),
                                  ],
                                  Container(
                                    padding: EdgeInsets.only(
                                        bottom: tagName.length > 50 ? 4 : 0),
                                    constraints: BoxConstraints(
                                        maxWidth: adaptWidgetWidth(400)),
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      softWrap: true,
                                      tagName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .apply(color: flag ? black : white),
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
                      Container(
                        padding: EdgeInsets.only(
                            left: adaptWidgetWidth(62),
                            right: adaptWidgetWidth(44)),
                        color: const Color.fromRGBO(0, 0, 0, 0.5),
                        height: adaptWidgetHeight(100),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth: adaptWidgetWidth(490)),
                                  child: MarqueeWidget(
                                    direction: Axis.horizontal,
                                    child: Text(movie.title,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall!
                                            .apply(color: white)),
                                  ),
                                ),
                                SizedBox(height: adaptWidgetHeight(10)),
                                Text(movie.genre,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium!
                                        .apply(color: white)),
                              ],
                            ),
                            Row(
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
                                      color: white,
                                    ),
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(movie.age,
                                      style: TextStyle(
                                          color: white,
                                          fontSize: adaptWidgetWidth(16))),
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
                                      color: white,
                                    ),
                                    color: Colors.transparent,
                                    shape: BoxShape.circle,
                                  ),
                                  child: SvgPicture.asset(
                                      width: adaptWidgetHeight(18),
                                      height: adaptWidgetHeight(18),
                                      "assets/icons/arrow_clock.svg",
                                      fit: BoxFit.contain),
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: adaptWidgetWidth(18)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    '${movie.runtime.toString()} хв',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .apply(color: white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: adaptWidgetHeight(20)),
        Container(
          padding: EdgeInsets.symmetric(horizontal: adaptWidgetWidth(90)),
          child: SessionsListWithFiltration(movie: movie),
        ),
      ],
    );
  }
}
