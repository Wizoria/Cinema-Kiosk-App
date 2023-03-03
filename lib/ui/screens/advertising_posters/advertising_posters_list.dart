import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../models/advertising_poster.dart';
import 'package:cinema_kiosk_app/service/app_manager.dart';
import '../../../models/presence_model.dart';
import '../../../navigation/nav_router.dart';
import '../../../repository/advertising_posters_repository.dart';
import '../../components/dots_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'advertising_posters_model.dart';

class AdvertisingPostersList extends StatefulWidget {
  const AdvertisingPostersList({Key? key}) : super(key: key);

  @override
  State createState() => _AdvertisingPostersListState();
}

class _AdvertisingPostersListState extends State<AdvertisingPostersList> {
  late Future<List<AdvertisingPoster>> _futureAdvertisingPosters;

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _futureAdvertisingPosters = AdvertisingPostersRepository()
        .getAdvertisingPostersByCinemaId(AppManager().cinemaSettings.cinemaId);
  }

  @override
  void dispose() {
    super.dispose();
  }

  callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<AdvertisingPoster>>(
      future: _futureAdvertisingPosters,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<AdvertisingPoster> advertisingPosters =
                snapshot.data as List<AdvertisingPoster>;
            return Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Consumer<AdvertisingPostersModel>(
                    builder: (context, value, child) {
                      return Listener(
                        onPointerDown: (event) => value.pauseCarousel('Down'),
                        onPointerUp: (event) => value.pauseCarousel('Up'),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                    // height: adaptWidgetHeight(1350),
                                    aspectRatio: 0.671,
                                    viewportFraction: 0.84,
                                    enlargeCenterPage: true,
                                    autoPlay: value.isAutoPlayEnabled,
                                    disableCenter: true,
                                    enableInfiniteScroll: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 5),
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 2000),
                                    onPageChanged: callbackFunction,
                                  ),
                                  itemCount: advertisingPosters.length,
                                  itemBuilder: (context, index, realIndex) {
                                    return Container(
                                      width: double.maxFinite,
                                      height: double.maxFinite,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 50, horizontal: 0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(adaptWidgetWidth(40)),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppManager().isDarkThemeOn
                                                ? Colors.white.withOpacity(0.06)
                                                : const Color.fromRGBO(
                                                    0, 0, 0, 0.15),
                                            spreadRadius: 12,
                                            blurRadius: 25,
                                            offset: Offset(0,
                                                0), // changes position of shadow
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                            adaptWidgetHeight(40)),
                                        child: GestureDetector(
                                          onTap: () {
                                            GoRouter.of(context).goNamed(
                                                advertisingPosterForOnSale,
                                                params: {
                                                  "movieOnSaleId":
                                                      advertisingPosters[index]
                                                          .keyVal
                                                          .toString()
                                                });
                                            AppManager().currentScreenIndex = 1;
                                            value.timerOff();
                                            PresenceModel().timerStart();
                                          },
                                          child: CachedNetworkImage(
                                            fit: BoxFit.cover,
                                            imageUrl: advertisingPosters[index]
                                                .imageRef,
                                            placeholder: (context, url) =>
                                                const FractionallySizedBox(
                                              widthFactor: 0.9,
                                              child: FittedBox(
                                                  fit: BoxFit.contain,
                                                  child:
                                                      CircularProgressIndicator(
                                                          strokeWidth: 0.1)),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                DotsIndicator(
                                  itemLength: advertisingPosters.length,
                                  currentIndex: currentIndex,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return const Expanded(
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
