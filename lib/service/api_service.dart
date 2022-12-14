import 'dart:convert';
import 'dart:developer';
import 'package:flutter_movie/config.dart';
import 'package:flutter_movie/model/favourite_movie_model.dart';
import 'package:flutter_movie/model/movie_model.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

class APIService {
  static var client = http.Client();

  // Get All Movies
  static Future<List<MovieModel>?> getMovies() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.movieURL);

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return moviesFromJson(data);
    } else {
      return null;
    }
  }

  // Get Top 5 Movie by Popularity List
  static Future<List<MovieModel>?> getTop5Movies() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.movieURL + "/top5");

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return moviesFromJson(data);
    } else {
      return null;
    }
  }

  // Get Favourite List
  static Future<List<FavouriteMovieModel>?> getFavouriteMovies() async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};

    var url = Uri.http(Config.apiURL, Config.movieURL + "/favourites");

    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      return favmoviesFromJson(data);
    } else {
      return null;
    }
  }

  // Add Movie to Favourite List
  static Future<bool> addToFavourite(movie_id) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var movieId = jsonEncode({"movie_id": movie_id.toString()});
    var url = Uri.http(Config.apiURL, Config.movieURL + "/addfavourite");
    var response =
        await client.post(url, headers: requestHeaders, body: movieId);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  // Delete Movie from Favourite List by ID
  static Future<bool> deleteFavourite(id) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(
        Config.apiURL, Config.movieURL + "/favourites/" + id.toString());
    var movieId = jsonEncode({"id": id.toString()});
    var response =
        await client.delete(url, headers: requestHeaders, body: movieId);

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
