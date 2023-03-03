import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../../../repository/cinemarket_banner_repository.dart';
import '../../../service/app_manager.dart';
import '../../../service/common_functions.dart';
import '../../components/dots_indicator.dart';
import '../../themes/themes.dart';
import 'cinemarket_model.dart';

class CinemarketBannerWidget extends StatefulWidget {
  const CinemarketBannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<CinemarketBannerWidget> createState() => _CinemarketBannerWidgetState();
}

class _CinemarketBannerWidgetState extends State<CinemarketBannerWidget> {
  late Future<List<CinemarketBanner>> _futureBanner;

  @override
  void initState() {
    super.initState();
    _futureBanner = CinemarketBannerRepository()
        .getCinemarketBannerByCinemaId(AppManager().cinemaSettings.cinemaId);
  }

  final controller = CarouselController();
  int currentIndex = 0;

  callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<CinemarketBanner>>(
      future: _futureBanner,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<CinemarketBanner> banner =
                snapshot.data as List<CinemarketBanner>;
            return Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CarouselSlider.builder(
                        carouselController: controller,
                        options: CarouselOptions(
                          height: adaptWidgetHeight(240),
                          initialPage: 0,
                          viewportFraction: 1,
                          onPageChanged: callbackFunction,
                        ),
                        itemCount: banner.length,
                        itemBuilder: (context, index, realIndex) => Image.asset(
                              banner[index].image,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            )
                        //     CachedNetworkImage(
                        //   fit: BoxFit.contain,
                        //   imageUrl: !!!,
                        //   placeholder: (context, url) =>
                        //       const CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) =>
                        //       const Icon(Icons.error),
                        // ),
                        ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: adaptWidgetWidth(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          MaterialButton(
                            onPressed: () => controller.previousPage(),
                            minWidth: adaptWidgetWidth(24),
                            height: adaptWidgetHeight(24),
                            shape: const CircleBorder(),
                            child: RotatedBox(
                              quarterTurns: 0,
                              child: Container(
                                padding: EdgeInsets.all(adaptWidgetWidth(6)),
                                decoration: BoxDecoration(
                                  color: white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_back_ios_sharp,
                                    size: adaptWidgetWidth(16), color: white),
                              ),
                            ),
                          ),
                          MaterialButton(
                            onPressed: () => controller.nextPage(),
                            minWidth: adaptWidgetWidth(24),
                            height: adaptWidgetHeight(24),
                            shape: const CircleBorder(),
                            child: RotatedBox(
                              quarterTurns: 2,
                              child: Container(
                                padding: EdgeInsets.all(adaptWidgetWidth(6)),
                                decoration: BoxDecoration(
                                  color: white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(Icons.arrow_back_ios_sharp,
                                    size: adaptWidgetWidth(16), color: white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: adaptWidgetHeight(10),
                ),
                DotsIndicator(
                  itemLength: banner.length,
                  currentIndex: currentIndex,
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
