import 'package:flutter/material.dart';
import 'movie.dart';

class MoviesComingSoon with ChangeNotifier {
  static MoviesComingSoon? _moviesComingSoon;

  MoviesComingSoon._internal();

  factory MoviesComingSoon() {
    _moviesComingSoon ??= MoviesComingSoon._internal();
    return _moviesComingSoon!;
  }

  List<Movie> allMoviesComingSoon = [];

  Movie getMovieById(int movieId) {
    Movie searchedMovie = Movie.empty();
    for (Movie movie in allMoviesComingSoon) {
      if (movie.id == movieId) {
        searchedMovie = movie;
      }
    }
    return searchedMovie;
  }
}
