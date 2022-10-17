import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_model.dart';
import 'package:flutter_movie/provider/favourite_provider.dart';
import 'package:flutter_movie/provider/movies_provider.dart';
import 'package:flutter_movie/utils/global.dart';
import 'package:flutter_movie/utils/parse_data_helper.dart';
import 'package:flutter_movie/utils/global.dart' as screensize;
import 'package:flutter_movie/utils/widget_helpers.dart';
import '../service/api_service.dart';
import 'package:flutter_movie/pages/movieprofile.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key, this.model, this.allmovie}) : super(key: key);
  final MovieModel? model;
  final MovieModel? allmovie;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<MovieProvider>().getAllMovie();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromARGB(229, 0, 0, 0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Movies to Binge!",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(147, 255, 255, 255)),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: allMovieList())
          ],
        ),
      ),
    );
  }

// LOAD ALL MOVIES
  Widget allMovieList() {
    final provider = Provider.of<FavouriteMovieProvider>(context);
    return Consumer<MovieProvider>(builder: ((context, value, child) {
      final movies = value.movies; // Store movie data in var movies

      return value.isLoading //If Loading show
          ? Center(child: showLoadingIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                // Formatting Language
                var language = ParseData()
                    .convertLanguage(movies[index].original_language);

                // Format Datetime
                var newDate = ParseData()
                    .convertDatetimeFormat(movies[index].release_date);
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MovieProfile(movie: movies[index])));
                  },
                  child: Stack(children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(33, 55, 55, 55),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      margin: const EdgeInsets.only(bottom: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/w500/${movies[index].poster_path!}",
                              width: 100,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 25,
                              ),
                              Container(
                                width: 250,
                                child: Text(
                                  movies[index].title!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                language,
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(129, 255, 255, 255),
                                    fontStyle: FontStyle.italic),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 13,
                                    color: Colors.yellow[300],
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "${movies[index].vote_average} / 10.0 ",
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(129, 255, 255, 255)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Icon(
                                    Icons.calendar_month,
                                    size: 13,
                                    color: Color.fromARGB(129, 255, 255, 255),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    newDate,
                                    style: const TextStyle(
                                        fontSize: 13,
                                        color:
                                            Color.fromARGB(129, 255, 255, 255)),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      provider
                                          .toggleFavouriteMovie(movies[index]);
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                    'Added to Favourite List'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text('OK'))
                                                ],
                                              ));
                                    },
                                    child: provider.isFavourite(movies[index])
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite,
                                            color: Colors.white30,
                                          ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              26, 255, 255, 255),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Icon(
                                        Icons.share,
                                        color: Colors.white30,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                );
              },
            );
    }));
  }

// Old Code for calling movies
  // Widget loadAllMovies() {
  //   return FutureBuilder(
  //     future: APIService.getMovies(),
  //     builder: (
  //       BuildContext context,
  //       AsyncSnapshot<List<MovieModel>?> allmovies,
  //     ) {
  //       if (allmovies.hasData) {
  //         return allMovieList();
  //       } else {
  //         return Padding(
  //             padding: EdgeInsets.all(10),
  //             child: Text(
  //               "Loading Data",
  //               style: TextStyle(fontSize: 20, color: Colors.white38),
  //             ));
  //       }
  //     },
  //   );
  // }
}

// LOAD 5 MOST POPULAR MOVIES
//   Widget top5MovieList(movies) {
//     return ListView.builder(
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         itemCount: movies.length,
//         itemBuilder: (context, index) {
//           return InkWell(
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) =>
//                           MovieProfile(movie: movies[index])));
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Flexible(
//                   child: Stack(alignment: Alignment.center, children: [
//                     Container(
//                       constraints: BoxConstraints(minHeight: 300),
//                       padding: EdgeInsetsDirectional.only(start: 4, end: 4),
//                       child: Image.network("https://image.tmdb.org/t/p/w500/" +
//                           movies[index].poster_path),
//                     ),
//                     Container(
//                       width: 200,
//                       padding: const EdgeInsets.all(5.0),
//                       alignment: Alignment.bottomCenter,
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: <Color>[
//                             Colors.black.withAlpha(0),
//                             Colors.black12,
//                             Color.fromARGB(255, 0, 0, 0)
//                           ],
//                         ),
//                       ),
//                       child: Text(
//                         movies[index].title,
//                         style: TextStyle(color: Colors.white, fontSize: 20.0),
//                       ),
//                     ),
//                   ]),
//                 )
//               ],
//             ),
//           );
//         });
//   }
