import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_kiosk_app/ui/screens/on_sale/movie_list_element_on_sale.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cinema_kiosk_app/repository/movies_repository.dart';
import '../../../models/movie.dart';
import 'package:cinema_kiosk_app/service/app_manager.dart';
import 'package:cinema_kiosk_app/models/movies_on_sale.dart';
import '../../../service/common_functions.dart';

class MovieListOnSale extends StatefulWidget {
  const MovieListOnSale({Key? key, required this.movieOnSaleId})
      : super(key: key);
  final int movieOnSaleId;

  @override
  State createState() => _MovieListOnSaleState();
}

class _MovieListOnSaleState extends State<MovieListOnSale> {
  late Future<List<Movie>> _futureMovieList;

  @override
  void initState() {
    super.initState();
    _futureMovieList = MoviesRepository()
        .getMoviesByCinemaId(AppManager().cinemaSettings.cinemaId);
    MoviesOnSale().selectedShowDate = getCurrentDate();
  }

  callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() => MoviesOnSale().selectedShowDate = getCurrentDate());
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("MovieListOnSale params ${widget.movieOnSaleId}");
    }
    int initialPage = 0;
    return FutureBuilder<List<Movie>>(
      future: _futureMovieList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            List<Movie> movies = snapshot.data as List<Movie>;

            MoviesOnSale().allMoviesOnSale = movies;
            if (widget.movieOnSaleId != 0) {
              for (int i = 0; i < MoviesOnSale().allMoviesOnSale.length; i++) {
                if (widget.movieOnSaleId ==
                    MoviesOnSale().allMoviesOnSale[i].id) {
                  initialPage = i;
                }
              }
            }
            return Padding(
              padding: EdgeInsets.only(top: adaptWidgetWidth(40)),
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  enlargeFactor: 0.2,
                  height: double.infinity,
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  initialPage: initialPage,
                  onPageChanged: callbackFunction,
                ),
                itemCount: MoviesOnSale().filtratedMoviesOnSale.length,
                itemBuilder: (context, index, realIndex) =>
                    MovieListElementOnSale(
                  movieId: MoviesOnSale().filtratedMoviesOnSale[index].id,
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
