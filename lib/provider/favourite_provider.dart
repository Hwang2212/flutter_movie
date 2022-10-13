import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_model.dart';

class FavouriteMovieProvider extends ChangeNotifier {
  List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void toggleFavouriteMovie(MovieModel movie) {
    final isFavourite = _movies.contains(movie);
    if (isFavourite) {
      _movies.remove(movie);
    } else {
      _movies.add(movie);
    }
    notifyListeners();
  }

  bool isFavourite(MovieModel movie) {
    final isFavourite = _movies.contains(movie);
    return isFavourite;
  }

  void clearFavouriteMovie() {
    _movies = [];
    notifyListeners();
  }
}
