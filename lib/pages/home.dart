import 'package:flutter/material.dart';
import 'package:flutter_movie/model/movie_model.dart';
import 'package:flutter_movie/provider/favourite_provider.dart';
import 'package:flutter_movie/utils/global.dart';
import 'package:flutter_movie/utils/parse_data_helper.dart';
import 'package:flutter_movie/utils/parse_data_helper.dart';
import 'package:flutter_movie/utils/global.dart' as screensize;
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Color.fromARGB(229, 0, 0, 0),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // SizedBox(
            //   height: 300,
            //   child: loadTop5Movies(),
            // ),
            Text(
              "Check out Other Movies",
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(147, 255, 255, 255)),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height,
                child: loadAllMovies())
          ],
        ),
      ),
    );
  }

//

// LOAD ALL MOVIES
  Widget allMovieList(movies) {
    final provider = Provider.of<FavouriteMovieProvider>(context);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: movies.length,
      itemBuilder: (context, index) {
        // Formatting Language
        var language =
            ParseData().convertLanguage(movies[index].original_language);

        // Format Datetime
        var newDate =
            ParseData().convertDatetimeFormat(movies[index].release_date);
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieProfile(movie: movies[index])));
          },
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(33, 55, 55, 55),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(12),
                      bottomRight: Radius.circular(12))),
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Image.network(
                      "https://image.tmdb.org/t/p/w500/" +
                          movies[index].poster_path,
                      width: 100,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        width: 250,
                        child: Text(
                          movies[index].title,
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        language,
                        style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(129, 255, 255, 255),
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
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
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            movies[index].vote_average.toString() + " / 10.0 ",
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(129, 255, 255, 255)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 13,
                            color: Color.fromARGB(129, 255, 255, 255),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            newDate,
                            style: TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(129, 255, 255, 255)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: () {
                              provider.toggleFavouriteMovie(movies[index]);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text('Added to Favourite List'),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('OK'))
                                        ],
                                      ));
                            },
                            child: provider.isFavourite(movies[index])
                                ? Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite,
                                    color: Colors.white30,
                                  ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              child: Icon(
                                Icons.share,
                                color: Colors.white30,
                              ),
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(26, 255, 255, 255),
                                  borderRadius: BorderRadius.circular(5)),
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
  }

  Widget loadAllMovies() {
    return FutureBuilder(
      future: APIService.getMovies(),
      builder: (
        BuildContext context,
        AsyncSnapshot<List<MovieModel>?> allmovies,
      ) {
        if (allmovies.hasData) {
          return allMovieList(allmovies.data);
        } else {
          return Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Loading Data",
                style: TextStyle(fontSize: 20, color: Colors.white38),
              ));
        }
      },
    );
  }
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
