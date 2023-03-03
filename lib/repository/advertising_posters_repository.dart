import 'dart:developer';

import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/models/environments/environment.dart';
import 'package:cinema_kiosk_app/data_sources/mock_service/mock_data_manager.dart';
import 'package:cinema_kiosk_app/data_sources/networking/http_manager.dart';
import 'package:cinema_kiosk_app/repository/repository.dart';
import 'package:cinema_kiosk_app/ui/screens/advertising_posters/advertising_posters.dart';

import '../models/advertising_poster.dart';

class AdvertisingPostersRepository {
  Future<List<AdvertisingPoster>> getAdvertisingPostersByCinemaId(int cinemaId) {
    Repository dataSource;
    if (Environment().config.type == Environment.LOCAL) {
      log('Using mock service...');
      dataSource = MockDataManager();
      // return dataSource.getMoviesByCinemaId(cinemaId);
    } else {
      log('Networking...');
      dataSource = HttpManager();
      // return dataSource.getMoviesByCinemaId(cinemaId);
    }
    return dataSource.getAdvertisingPostersByCinemaId(cinemaId);
  }
}
