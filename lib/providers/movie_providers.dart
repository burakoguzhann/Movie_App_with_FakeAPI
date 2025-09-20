import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/movie_service.dart';

class MovieProviders extends ChangeNotifier {
  List<MovieModel> _movieList = [];
  List<MovieModel> get movieList => _movieList;

  void getMovie() async {
    List<MovieModel> MovieData = await MovieService().getMovies();
    _movieList = MovieData;
    notifyListeners();
  }
}
