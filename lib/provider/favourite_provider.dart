import 'package:flutter/material.dart';

class FavouriteMovieProvider extends ChangeNotifier {
  List<String> _movies = [];
  List<String> get movies => _movies;

  void toggleFavouriteMovie(String movie) {
    final isFavourite = _movies.contains(movie);
    if (isFavourite) {
      _movies.remove(movie);
    } else {
      _movies.add(movie);
    }
    notifyListeners();
  }

  void clearFavouriteMovie() {
    _movies = [];
    notifyListeners();
  }
}
