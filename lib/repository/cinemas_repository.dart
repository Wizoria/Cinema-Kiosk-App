import 'dart:developer';

import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/models/environments/environment.dart';
import 'package:cinema_kiosk_app/data_sources/mock_service/mock_data_manager.dart';
import 'package:cinema_kiosk_app/data_sources/networking/http_manager.dart';
import 'package:cinema_kiosk_app/repository/repository.dart';

class CinemasRepository {
  Future<List<Cinema>> getCinemasByChainId(int cinemaChainId) {
    Repository dataSource;
    if (Environment().config.type == Environment.LOCAL) {
      log('Using mock service...');
      dataSource = MockDataManager();
    } else {
      log('Networking...');
      dataSource = HttpManager();
    }
    return dataSource.getCinemasByChainId(cinemaChainId);
  }
}
