import 'dart:convert';
import 'package:cinema_kiosk_app/models/nomenclature_group.dart';
import 'package:flutter/services.dart';
import 'package:cinema_kiosk_app/models/models.dart';
import 'package:cinema_kiosk_app/repository/repository.dart';
import '../../models/advertising_poster.dart';
import '../../ui/screens/cinemarket/cinemarket_model.dart';

class MockDataManager implements Repository {
  Future<List<Movie>> _getMockMovies() async {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 300));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/mock_data/on_sale_wizoria_kyiv_251022.json');
    // Decode to json
    List<dynamic> json = jsonDecode(dataString);

    final movies = <Movie>[];
    for (var data in json) {
      movies.add(Movie.fromJson(data));
    }
    return movies;
  }

  // Loads sample json data from file system
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }

  @override
  Future<List<Movie>> getMoviesByCinemaId(int cinemaId) {
    return _getMockMovies();
  }

  @override
  Future<List<AdvertisingPoster>> getAdvertisingPostersByCinemaId(
      int cinemaId) async {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 300));
    // Load json from file system
    final dataString = await _loadAsset(
        'assets/mock_data/advertising_posters_wizoria_kyiv_251022.json');
    // Decode to json
    List<dynamic> json = jsonDecode(dataString);

    final advertisingPosters = <AdvertisingPoster>[];
    for (var data in json) {
      advertisingPosters.add(AdvertisingPoster.fromJson(data));
    }
    return advertisingPosters;
  }

  @override
  Future<List<Movie>> getComingSoonMoviesByCinemaId(int cinemaId) async {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 300));
    // Load json from file system
    final dataString = await _loadAsset(
        'assets/mock_data/coming_soon_wizoria_kyiv_251022.json');
    // Decode to json
    List<dynamic> json = jsonDecode(dataString);

    final movies = <Movie>[];
    for (var data in json) {
      movies.add(Movie.fromJson(data));
    }
    return movies;
  }

  @override
  Future<List<Cinema>> getCinemasByChainId(int cinemaChainId) async {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 300));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/mock_data/cinemas_wizoria.json');
    // Decode to json
    List<dynamic> json = jsonDecode(dataString);

    final cinemas = <Cinema>[];
    for (var data in json) {
      cinemas.add(Cinema.fromJson(data));
    }
    return cinemas;
  }

  @override
  Future<List<Seat>> getSessionSeatsBySessionId(int sessionId) async {
    // Simulate api request wait time
    // await Future.delayed(const Duration(milliseconds: 300));
    // Load json from file system
    final dataString =
        await _loadAsset('assets/mock_data/cinemas_wizoria.json');
    // Decode to json
    List<dynamic> json = jsonDecode(dataString);

    final sessionSeats = <Seat>[];
    for (var data in json) {
      sessionSeats.add(Seat.fromJson(data));
    }
    return sessionSeats;
  }

  @override
  Future<List<CinemarketBanner>> getCinemarketBannerByCinemaId(
      int sessionId) async {
    final dataString =
        await _loadAsset('assets/mock_data/CinemarketBanner.json');
    // Decode to json
    List<dynamic> json = jsonDecode(dataString);

    final banner = <CinemarketBanner>[];
    for (var data in json) {
      banner.add(CinemarketBanner.fromJson(data));
    }
    return banner;
  }

  @override
  Future<List<NomenclatureGroup>> getCinemarketByCinemaId(int sessionId) async {
    final dataString =
        await _loadAsset('assets/mock_data/Cinemarket.json');
    // Decode to json
    List<dynamic> json = jsonDecode(dataString);

    final nomenclatureItem = <NomenclatureGroup>[];
    for (var data in json) {
      nomenclatureItem.add(NomenclatureGroup.fromJson(data));
    }
    return nomenclatureItem;
  }
}
