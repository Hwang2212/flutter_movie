import 'dart:convert';

List<FavouriteMovieModel> favmoviesFromJson(dynamic str) =>
    List<FavouriteMovieModel>.from(
        (str).map((x) => FavouriteMovieModel.fromJson(x)));

class FavouriteMovieModel {
  late int? id;
  late String? backdrop_path;
  late String? created_at;
  late String? original_language;
  late String? original_title;
  late String? overview;
  late double? popularity;
  late String? poster_path;
  late String? release_date;
  late String? title;
  late bool? video;
  late String? genre_ids;
  late bool? adult;
  late int? vote_count;
  late String? movie_id;
  late num? vote_average;

  FavouriteMovieModel({
    this.id,
    this.backdrop_path,
    this.created_at,
    this.original_language,
    this.original_title,
    this.overview,
    this.popularity,
    this.poster_path,
    this.release_date,
    this.title,
    this.video,
    this.genre_ids,
    this.adult,
    this.vote_count,
    this.movie_id,
    this.vote_average,
  });

  FavouriteMovieModel.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    created_at = json['created_at'];
    backdrop_path = json['backdrop_path'];
    original_language = json['original_language'];
    original_title = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    poster_path = json['poster_path'];
    release_date = json['release_date'];
    title = json['title'];
    video = json['video'];
    genre_ids = json['genre_ids'];
    adult = json['adult'];
    vote_count = json['vote_count'];
    movie_id = json['movie_id'];
    vote_average = json['vote_average'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};

    _data['id'] = id;
    _data['created_at'] = created_at;
    _data['backdrop_path'] = backdrop_path;
    _data['original_language'] = original_language;
    _data['original_title'] = original_title;
    _data['overview'] = overview;
    _data['popularity'] = popularity;
    _data['poster_path'] = poster_path;
    _data['release_date'] = release_date;
    _data['title'] = title;
    _data['video'] = video;
    _data['genre_ids'] = genre_ids;
    _data['adult'] = adult;
    _data['vote_count'] = vote_count;
    _data['movie_id'] = movie_id;
    _data['vote_average'] = vote_average;

    return _data;
  }
}
