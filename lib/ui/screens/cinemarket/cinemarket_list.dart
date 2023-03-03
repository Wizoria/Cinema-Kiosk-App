import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../models/nomenclature_group.dart';
import '../../../repository/cinemarket_repository.dart';
import '../../../service/app_manager.dart';
import '../../../service/common_functions.dart';
import '../../styles/styles.dart';
import '../../themes/themes.dart';
import '../schedule/session_list_element_schedule.dart';
import 'cinemarket_banner.dart';
import 'cinemarket_model.dart';

class CinemarketList extends StatefulWidget {
  const CinemarketList({
    Key? key,
    required this.sessionId,
  }) : super(key: key);
  final int sessionId;

  @override
  State<CinemarketList> createState() => _CinemarketListState();
}

class _CinemarketListState extends State<CinemarketList> {
  late Future<List<NomenclatureGroup>> _futureCheck;

  @override
  void initState() {
    super.initState();
    _futureCheck = CinemarketRepository()
        .getCinemarketByCinemaId(AppManager().cinemaSettings.cinemaId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NomenclatureGroup>>(
      future: _futureCheck,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<NomenclatureGroup> nomenclature =
                snapshot.data as List<NomenclatureGroup>;
            CinemarketModel().nomenclature = nomenclature;
            return Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: adaptWidgetHeight(30),
                  ),
                  widget.sessionId == 0
                      ? Column(
                          children: [
                            SizedBox(
                                height: adaptWidgetHeight(280),
                                child: const CinemarketBannerWidget()),
                            SizedBox(
                              height: adaptWidgetHeight(20),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: adaptWidgetWidth(65)),
                                  child: Text(
                                    'Кіномаркет',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: adaptWidgetHeight(28),
                            )
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: adaptWidgetWidth(65)),
                          child: Column(
                            children: [
                              MovieSchedule(
                                sessionId: widget.sessionId,
                              ),
                              const TicketReservationTime(text: 'Кіномаркет'),
                            ],
                          ),
                        ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: adaptWidgetWidth(65)),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: adaptWidgetWidth(145),
                                child: Consumer<CinemarketModel>(
                                  builder: (context, value, child) =>
                                      ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: nomenclature.length,
                                    itemBuilder: (context, index) =>
                                        CinemarketNomenclatureGroup(
                                            name:
                                                value.nomenclature[index].name,
                                            image:
                                                value.nomenclature[index].image,
                                            isActive:
                                                value.currentIndex == index,
                                            onPressed: () => value
                                                .callbackButtonCurrentIndex(
                                                    index)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: adaptWidgetWidth(40),
                              ),
                              Expanded(
                                child: Consumer<CinemarketModel>(
                                    builder: (context, value, child) {
                                  return AnimationLimiter(
                                    key: ValueKey(
                                        CinemarketModel().currentIndex),
                                    child: GridView.builder(
                                      padding: EdgeInsets.only(
                                          bottom: adaptWidgetHeight(120)),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 4,
                                        childAspectRatio: 0.7,
                                        crossAxisSpacing: adaptWidgetWidth(15),
                                        mainAxisSpacing: adaptWidgetHeight(15),
                                      ),
                                      scrollDirection: Axis.vertical,
                                      itemCount:
                                          value.currentNomenclature.length,
                                      itemBuilder: (context, index) =>
                                          AnimationConfiguration.staggeredGrid(
                                        position: index,
                                        duration:
                                            const Duration(milliseconds: 375),
                                        columnCount: 2,
                                        child: ScaleAnimation(
                                          scale: 0.9,
                                          child: FadeInAnimation(
                                            child: CinemarketItemNomenclature(
                                              id: value
                                                  .currentNomenclature[index]
                                                  .id,
                                              name: value
                                                  .currentNomenclature[index]
                                                  .name,
                                              image: value
                                                  .currentNomenclature[index]
                                                  .image,
                                              price: value
                                                  .currentNomenclature[index]
                                                  .price,
                                              amount: value.getAmount(value
                                                  .currentNomenclature[index]
                                                  .id),
                                              isActive: value.getAmount(value
                                                      .currentNomenclature[
                                                          index]
                                                      .id) !=
                                                  0,
                                              onPressed: () =>
                                                  value.callbackNomenclature(
                                                true,
                                                value.currentNomenclature[index]
                                                    .id,
                                                value.currentNomenclature[index]
                                                    .name,
                                                value.currentNomenclature[index]
                                                    .price,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ],
                          ),
                          Container(
                            height: adaptWidgetHeight(90),
                            margin:
                                EdgeInsets.only(bottom: adaptWidgetHeight(16)),
                            child: Consumer<CinemarketModel>(
                              builder: (context, value, child) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      CinemarketModel().selectedProducts.length,
                                  itemBuilder: (context, index) => Container(
                                    margin: EdgeInsets.only(
                                        right: adaptWidgetWidth(16)),
                                    // constraints: BoxConstraints(minWidth: adaptWidgetWidth(210),maxWidth: adaptWidgetWidth(300)),
                                    // width: adaptWidgetWidth(260),
                                    // height: adaptWidgetHeight(90),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          adaptWidgetWidth(20)),
                                      // color: Theme.of(context).colorScheme.primary,
                                      gradient: LinearGradient(
                                        colors: [
                                          Theme.of(context).colorScheme.primary,
                                          Theme.of(context)
                                              .colorScheme
                                              .onPrimary
                                        ],
                                        begin: FractionalOffset.centerLeft,
                                        end: FractionalOffset.centerRight,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: adaptWidgetWidth(10),
                                              vertical: adaptWidgetHeight(4)),
                                          child: MaterialButton(
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
                                            shape: const CircleBorder(),
                                            padding: EdgeInsets.all(
                                                adaptWidgetWidth(4)),
                                            minWidth: 14,
                                            height: 14,
                                            child: SvgPicture.asset(
                                                width: adaptWidgetHeight(12),
                                                height: adaptWidgetHeight(12),
                                                "assets/icons/dagger_close.svg",
                                                color: white,
                                                fit: BoxFit.contain),
                                            onPressed: () =>
                                                value.removeNomenclature(value
                                                    .selectedProducts[index]
                                                    .id),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: adaptWidgetWidth(18)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  value.selectedProducts[index]
                                                      .name,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .apply(color: white)),
                                              SizedBox(
                                                width: adaptWidgetWidth(10),
                                              ),
                                              Row(
                                                children: [
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: adaptWidgetWidth(28),
                                                    height:
                                                        adaptWidgetWidth(28),
                                                    decoration:
                                                        const BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color:
                                                                Colors.white),
                                                    child: Text(
                                                      value
                                                          .selectedProducts[
                                                              index]
                                                          .amount
                                                          .toString(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodySmall!
                                                          .apply(color: black),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: adaptWidgetWidth(8),
                                                  ),
                                                  SizedBox(
                                                    width: adaptWidgetWidth(70),
                                                    child: Text(
                                                      '${removeTrailingZeros(value.selectedProducts[index].totalPrice)} ₴',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displayMedium!
                                                          .apply(color: white),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
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
