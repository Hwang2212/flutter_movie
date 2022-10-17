import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_model.dart';
import 'package:flutter_movie/service/api_service.dart';

// Movie Provider to get all movie data
class MovieProvider with ChangeNotifier {
  // final APIService _movieService = APIService.instance;
  List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;
  bool isLoading = false;

  Future<void> getAllMovie() async {
    isLoading = true;
    notifyListeners();

    final response = await APIService.getMovies();

    _movies = response!;
    isLoading = false;
    notifyListeners();
  }
}
