import 'package:cinema_kiosk_app/models/nomenclature_group.dart';
import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/ui/screens/cinemarket/cinemarket_model.dart';

import '../models/advertising_poster.dart';

abstract class Repository {
  Future<List<Movie>> getMoviesByCinemaId(int cinemaId);

  Future<List<AdvertisingPoster>> getAdvertisingPostersByCinemaId(int cinemaId);

  Future<List<Movie>> getComingSoonMoviesByCinemaId(int cinemaId);

  Future<List<Cinema>> getCinemasByChainId(int cinemaChainId);

  Future<List<Seat>> getSessionSeatsBySessionId(int sessionId);

  Future<List<CinemarketBanner>> getCinemarketBannerByCinemaId(int cinemaId);

  Future<List<NomenclatureGroup>> getCinemarketByCinemaId(int sessionId);
}
