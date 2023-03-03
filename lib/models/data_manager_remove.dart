import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/models/environments/environment.dart';
import 'package:cinema_kiosk_app/data_sources/mock_service/mock_data_manager.dart';
import 'package:cinema_kiosk_app/data_sources/networking/http_manager.dart';

import '../repository/repository.dart';

class DataManager {
  Future<List<Movie>> getMoviesByCinemaId(int cinemaId) {
    Repository dataSource;
    if (Environment().config.type == Environment.LOCAL) {
      dataSource = MockDataManager();
      // return dataSource.getMoviesByCinemaId(cinemaId);
    } else {
      dataSource = HttpManager();
      // return dataSource.getMoviesByCinemaId(cinemaId);
    }
    return dataSource.getMoviesByCinemaId(cinemaId);
  }
}
