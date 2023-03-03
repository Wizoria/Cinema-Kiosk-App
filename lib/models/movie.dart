import 'package:cinema_kiosk_app/models/tag_marker.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'session.dart';

class Movie {
  int id = 0;
  // int idMovie = 0;
  String title = '';
  String age = '';
  String ageDesc = '';
  int runtime = 0;
  String genre = '';
  int sort = 0;
  DateTime releaseDate = DateTime.now();
  String format = '';
  String actors = '';
  String scenarist = '';
  String country = '';
  String producer = '';
  String movieImg1 = '';
  String movieImgMobile1 = '';
  String movieImgMobile2 = '';
  DateTime dateActualityPictures = DateTime.now();
  String originalMovieName = '';
  String movieLanguage = '';
  DateTime lastShowDate = DateTime.now();
  String releaseDateDescription = '';
  String purchaseWarningText = '';
  String movieDescription = '';
  bool isComingSoon = false;
  List<Session> sessions = [];

  List<Session> filtratedSessions = [];
  List<DateTime> allShowDates = [];
  DateTime selectedShowDate = getCurrentDate();

  resetMovieSessionsDateFiltration() {
    selectedShowDate = getCurrentDate();
    performMovieSessionsDateFiltration();
  }

  performMovieSessionsDateFiltration() {
    filtratedSessions.clear();

    for (Session session in sessions) {
      if (daysOfDatesEqualAreEqual(session.date, selectedShowDate)) {
          filtratedSessions.add(session);
      }
    }

    filtratedSessions.sort((a, b) => a.date.compareTo(b.date));
  }

  Movie({
    required this.id,
    // required this.idMovie,
    required this.title,
    required this.age,
    required this.runtime,
    required this.genre,
    required this.sort,
    required this.releaseDate,
    required this.format,
    required this.actors,
    required this.scenarist,
    required this.country,
    required this.producer,
    required this.movieImg1,
    required this.movieImgMobile1,
    required this.movieImgMobile2,
    required this.dateActualityPictures,
    required this.originalMovieName,
    required this.movieLanguage,
    required this.lastShowDate,
    required this.releaseDateDescription,
    required this.purchaseWarningText,
    required this.isComingSoon,
    required this.movieDescription,
    this.sessions = const [],
    this.allShowDates = const [],
    this.filtratedSessions = const [],
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final sessions = <Session>[];

    if (json['sessions'] != null) {
      json['sessions'].forEach((v) {
        sessions.add(Session.fromJson(v));
      });
    }

    DateTime releaseDate = getDateFromString(json['releaseDate']);
    DateTime dateActualityPictures = getDateFromString(json['dateActualityPictures']);
    DateTime lastShowDate = getDateFromString(json['lastShowDate']);

    int runtime = json['runtime'];

    List<DateTime> allShowDates = [];
    for (Session session in sessions) {
      session.timeEnd = '${session.date.add(Duration(minutes: runtime)).hour}:${session.date.add(Duration(minutes: runtime)).minute}';
      for (TagMarker tagmarker in session.tags) {
        if (tagmarker.tagType == 'date') {
          var tagDate = getDateFromString(tagmarker.tagName);
          var dateContain = allShowDates.where((element) => element == tagDate);
          if (dateContain.isEmpty) {
            allShowDates.add(tagDate);
          }
        }
      }
      session.movieId = json['idMovie'];
      session.movieTitle = json['movie'];
      session.movieGenre = json['genre'];
      session.movieAge = json['age'];
      session.movieImageRef = json['movieImgMobile2'];
    }

    bool todayIsAdded = false;
    for (DateTime date in allShowDates) {
      if (daysOfDatesEqualAreEqual(date, getCurrentDate())) {
        todayIsAdded = true;
      }
    }
    if (!todayIsAdded) {
      allShowDates.add(DateTime(getCurrentDate().year, getCurrentDate().month, getCurrentDate().day));
      allShowDates.sort((a, b) => a.compareTo(b));
    }

    allShowDates.sort((a, b) => a.compareTo(b));

    List<Session> filtratedSessions = [];
    DateTime selectedShowDate = getCurrentDate();
    for (Session session in sessions) {
      if (daysOfDatesEqualAreEqual(session.date, selectedShowDate)) {
        filtratedSessions.add(session);
      }
    }
    filtratedSessions.sort((a, b) => a.date.compareTo(b.date));

    // sessions.removeWhere((element) => element.isServiceSession == true);

    return Movie(
      id: json['idMovie'] ?? 0,
      // idMovie: json['idMovie'] ?? 0,
      title: json['movie'] ?? '',
      age: json['age'] ?? '',
      runtime: json['runtime'] ?? '',
      genre: json['genre'] ?? '',
      sort: json['sort'] ?? '',
      releaseDate: releaseDate,
      format: json['format'] ?? '',
      actors: json['actors'] ?? '',
      scenarist: json['scenarist'] ?? '',
      country: json['country'] ?? '',
      producer: json['producer'] ?? '',
      movieImg1: json['movieImg1'] ?? '',
      movieImgMobile1: json['movieImgMobile1'] ?? '',
      movieImgMobile2: json['movieImgMobile2'] ?? '',
      dateActualityPictures: dateActualityPictures,
      originalMovieName: json['originalMovieName'] ?? '',
      movieLanguage: json['movieLanguage'] ?? '',
      lastShowDate: lastShowDate,
      releaseDateDescription: json['releaseDateDescription'] ?? '',
      purchaseWarningText: json['purchaseWarningText'] ?? '',
      isComingSoon: json['isComingSoon'] ?? false,
      movieDescription: json['movieDescription'] ?? '',
      sessions: sessions,
      allShowDates: allShowDates,
      filtratedSessions: filtratedSessions,
    );
  }

  @override
  String toString() {
    return 'Movie{id: $id, title: $title, filtratedSessions: $filtratedSessions}';
  }

  Movie.empty() {
    id = 0;
    title = 'Empty';
    age = '';
    ageDesc = '';
    runtime = 0;
    genre = '';
    sort = 0;
    releaseDate = DateTime.now();
    format = '';
    actors = '';
    scenarist = '';
    country = '';
    producer = '';
    movieImg1 = '';
    movieImgMobile1 = '';
    movieImgMobile2 = '';
    dateActualityPictures = DateTime.now();
    originalMovieName = '';
    movieLanguage = '';
    lastShowDate = DateTime.now();
    releaseDateDescription = '';
    purchaseWarningText = '';
    movieDescription = '';
    isComingSoon = false;
    sessions = [];
  }
}
