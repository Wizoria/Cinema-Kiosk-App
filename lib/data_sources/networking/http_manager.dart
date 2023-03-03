import 'dart:convert';
import 'dart:developer';
import 'package:cinema_kiosk_app/models/environments/environment.dart';
import 'package:cinema_kiosk_app/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:cinema_kiosk_app/repository/repository.dart';
import '../../models/advertising_poster.dart';
import '../../models/nomenclature_group.dart';
import '../../service/app_manager.dart';
import '../../ui/screens/cinemarket/cinemarket_model.dart';

class HttpManager implements Repository {
  @override
  Future<List<Movie>> getMoviesByCinemaId(int cinemaId) async {
    String endpoint = "${Environment().config.apiHost}/ua/on-sale-by-cinema?idcinema=$cinemaId";

    // log('Networking...');

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      // Go through each recipe and convert json to SimpleRecipe object.
      final movies = <Movie>[];
      for (var value in json) {
        movies.add(Movie.fromJson(value));
      }
      return movies;
    } else {
      log(response.body);
      return <Movie>[];
    }
  }

  @override
  Future<List<AdvertisingPoster>> getAdvertisingPostersByCinemaId(int cinemaId) async {
    String endpoint = "${Environment().config.apiHost}/promotion-posters/$cinemaId";

    // log('Networking...');

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      // Go through each recipe and convert json to SimpleRecipe object.
      final advertisingPosters = <AdvertisingPoster>[];
      for (var value in json) {
        advertisingPosters.add(AdvertisingPoster.fromJson(value));
      }
      return advertisingPosters;
    } else {
      log(response.body);
      return <AdvertisingPoster>[];
    }
  }

  @override
  Future<List<Movie>> getComingSoonMoviesByCinemaId(int cinemaId) async {
    String endpoint = "${Environment().config.apiHost}/ua/coming-soon-by-cinema?idcinema=$cinemaId";

    // log('Networking...');

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      // Go through each recipe and convert json to SimpleRecipe object.
      final movies = <Movie>[];
      for (var value in json) {
        movies.add(Movie.fromJson(value));
      }
      return movies;
    } else {
      log(response.body);
      return <Movie>[];
    }
  }

  @override
  Future<List<Cinema>> getCinemasByChainId(int cinemaChainId) async {
    String cinemaChainStringId = 'wizoria';
    if (AppManager().cinemaSettings.cinemaChainId == 2) {
      cinemaChainStringId = 'cinemacity';
    }
    String endpoint = "${Environment().config.apiHost}/ua/cinemas/$cinemaChainStringId";

    // log('Networking...');

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      // Go through each recipe and convert json to SimpleRecipe object.
      final cinemas = <Cinema>[];
      for (var value in json) {
        cinemas.add(Cinema.fromJson(value));
      }
      return cinemas;
    } else {
      log(response.body);
      return <Cinema>[];
    }
  }

  @override
  Future<List<Seat>> getSessionSeatsBySessionId(int sessionId) async {
    String endpoint = "${Environment().config.apiHost}/tickets-on-session?idSession=$sessionId";

    // log('Networking...');

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      // Go through each recipe and convert json to SimpleRecipe object.
      final sessionSeats = <Seat>[];
      for (var value in json) {
        sessionSeats.add(Seat.fromJson(value));
      }
      return sessionSeats;
    } else {
      log(response.body);
      return <Seat>[];
    }
  }

  @override
  Future<List<CinemarketBanner>> getCinemarketBannerByCinemaId(int cinemaId) async {
    String endpoint = "${Environment().config.apiHost}/ua/cinemarket/3";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);

      final check = <CinemarketBanner>[];
      for (var value in json) {
        check.add(CinemarketBanner.fromJson(value));
      }
      return check;
    } else {
      log(response.body);
      return <CinemarketBanner>[];
    }
  }

  @override
  Future<List<NomenclatureGroup>> getCinemarketByCinemaId(int cinemaId) async {
    String endpoint = "${Environment().config.apiHost}/ua/cinemarket/3";

    final response = await http.get(Uri.parse(endpoint));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);

      final check = <NomenclatureGroup>[];
      for (var value in json) {
        check.add(NomenclatureGroup.fromJson(value));
      }
      return check;
    } else {
      log(response.body);
      return <NomenclatureGroup>[];
    }
  }

}
