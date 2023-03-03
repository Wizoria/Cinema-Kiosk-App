import 'package:cinema_kiosk_app/ui/screens/advertising_posters/advertising_posters_buy_now_button.dart';
import 'package:flutter/material.dart';
import '../../../service/app_manager.dart';
import 'advertising_posters_list.dart';
import '../../components/main_header.dart';

class AdvertisingPosters extends StatelessWidget {
  const AdvertisingPosters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppManager().context = context;
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          MainHeader(),
          AdvertisingPostersList(),
          AdvertisingPostersBuyNowButton(),
        ],
      ),
    );
  }
}
