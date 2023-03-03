import 'dart:developer';
import 'package:cinema_kiosk_app/repository/repository.dart';
import '../data_sources/mock_service/mock_data_manager.dart';
import '../data_sources/networking/http_manager.dart';
import '../models/environments/environment.dart';
import '../ui/screens/cinemarket/cinemarket_model.dart';

class CinemarketBannerRepository {
  Future<List<CinemarketBanner>> getCinemarketBannerByCinemaId(int cinemaId) {
    Repository dataSource;
    if (true // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // Environment().config.type == Environment.LOCAL
    ) {
      log('Using mock service...');
      dataSource = MockDataManager();
      // return dataSource.getMoviesByCinemaId(cinemaId);
    } else {
      log('Networking...');
      dataSource = HttpManager();
      // return dataSource.getMoviesByCinemaId(cinemaId);
    }
    return dataSource.getCinemarketBannerByCinemaId(cinemaId);
  }
}