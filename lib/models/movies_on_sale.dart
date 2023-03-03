import 'movie.dart';
import 'tag_marker.dart';
import 'session.dart';
import 'package:cinema_kiosk_app/service/common_functions.dart';
import 'package:flutter/material.dart';

// Клас потрібний щоб швидко і без запиту в базу повертати дані при фільтрації чи зміні дати
class MoviesOnSale with ChangeNotifier {
  static MoviesOnSale? _moviesOnSale;

  MoviesOnSale._internal();

  factory MoviesOnSale() {
    _moviesOnSale ??= MoviesOnSale._internal();
    return _moviesOnSale!;
  }

  final List<DateTime> _allShowDates = [];

  DateTime selectedShowDate = getCurrentDate();

  String selectedShowFormat = 'All';

  List<Movie> _allMoviesOnSale = [];

  // Призначення змінної - зберігати інший склад фільмів у випадках коли на фільм більше немає
  // сеансів і його не потрібно показувати, а також в інших випадках коли загальна кількість
  // фільмів відрізняється від тієї яка має відображатись.
  final List<Movie> _filtratedMoviesOnSale = [];

  final List<Session> _filtratedSessionsDateOnSale = [];

  final List<Session> _filtratedSessionsOnSale = [];

  final List<TagMarker> _allFormatTags = [];

  // List<TagMarker> _selectedFormatTags = [];

  List<DateTime> get allShowDates => _allShowDates;

  List<Movie> get allMoviesOnSale => _allMoviesOnSale;

  List<Movie> get filtratedMoviesOnSale => _filtratedMoviesOnSale;

  List<Session> get filtratedSessionsDateOnSale => _filtratedSessionsDateOnSale;

  List<Session> get filtratedSessionsOnSale => _filtratedSessionsOnSale;

  List<TagMarker> get allFormatTags => _allFormatTags;

  updateCurrentDate(DateTime newDate) {
    selectedShowDate = newDate;
    notifyListeners();
  }

  updateCurrentFormat(String format) {
    selectedShowFormat = format;
    notifyListeners();
  }

  Movie getMovieById(int movieId) {
    Movie searchedMovie = Movie.empty();
    for (Movie movie in _filtratedMoviesOnSale) {
      if (movie.id == movieId) {
        searchedMovie = movie;
      }
    }
    return searchedMovie;
  }

  performSessionFiltration() {
    _filtratedSessionsOnSale.clear();
    _filtratedSessionsDateOnSale.clear();
    for (Movie movie in _allMoviesOnSale) {
      movie.selectedShowDate = selectedShowDate;
      movie.performMovieSessionsDateFiltration();
      for (Session session in movie.filtratedSessions) {
        _filtratedSessionsDateOnSale.add(session);
        if (selectedShowFormat == 'All' ||
            selectedShowFormat == '2D' && session.is2D ||
            selectedShowFormat == '3D' && session.is3D ||
            selectedShowFormat == '4DX' && session.is4DX ||
            selectedShowFormat == 'Atmos' && session.isAtmos ||
            selectedShowFormat == 'Laser' && session.isLaser) {
          _filtratedSessionsOnSale.add(session);
        }
      }
    }

    _filtratedSessionsOnSale.sort((a, b) => a.date.compareTo(b.date));
  }

  set allMoviesOnSale(List<Movie> value) {
    _allMoviesOnSale = value;

    _allShowDates.clear();
    _allFormatTags.clear();
    _filtratedMoviesOnSale.clear();
    _filtratedSessionsOnSale.clear();

    for (Movie movie in _allMoviesOnSale) {
      movie.resetMovieSessionsDateFiltration();

      // TODO: Реалізувати фільтрацію _filtratedMoviesOnSale
      _filtratedMoviesOnSale.add(movie);

      for (DateTime showDate in movie.allShowDates) {
        var dateContain = _allShowDates.where((element) => element == showDate);
        if (dateContain.isEmpty) {
          _allShowDates.add(showDate);
        }
      }
      _allShowDates.sort((a, b) => a.compareTo(b));
    }

    performSessionFiltration();

    for (Movie movie in filtratedMoviesOnSale) {
      for (Session session in movie.sessions) {
        for (TagMarker tagMarker in session.tags) {
          var formatContain =
              _allFormatTags.where((element) => element.id == tagMarker.id);
          if (formatContain.isEmpty && (tagMarker.tagType == 'format')) {
            _allFormatTags.add(tagMarker);
          }
        }
      }
    }

    _filtratedSessionsOnSale.sort((a, b) => a.date.compareTo(b.date));
    _allFormatTags.sort((a, b) => a.tagName.compareTo(b.tagName));
  }
}
