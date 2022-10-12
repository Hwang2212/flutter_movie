import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_model.dart';
import 'package:flutter_movie/service/api_service.dart';

class AllMovieProvider with ChangeNotifier {
  MovieModel allMovies = MovieModel();
  bool loading = false;

  getAllMovie(context) async {
    loading = true;
    allMovies = await APIService.getMovies(context);
    loading = false;

    notifyListeners();
  }
}
