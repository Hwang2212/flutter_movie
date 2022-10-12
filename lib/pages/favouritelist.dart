// import 'package:flutter/material.dart';
// import 'package:flutter_movie/model/favourite_movie_model.dart';
// import 'package:flutter_movie/pages/movieprofile.dart';
// import 'package:flutter_movie/service/api_service.dart';
// import 'package:intl/intl.dart';

// class FavouriteList extends StatefulWidget {
//   const FavouriteList({Key? key, this.allmovies}) : super(key: key);
//   final FavouriteMovieModel? allmovies;
//   @override
//   State<FavouriteList> createState() => _FavouriteListState();
// }

// class _FavouriteListState extends State<FavouriteList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: Text(
//           "Favourite Movies",
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(229, 0, 0, 0),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 20.0,
//             ),
//             SizedBox(height: 600, child: loadAllFavouriteMovies())
//           ],
//         ),
//       ),
//     );
//   }

//   // LOAD ALL Favourite MOVIES
//   Widget allMovieList(movies) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: movies.length,
//       itemBuilder: (context, index) {
//         // Formatting Language
//         var language = movies[index].original_language;
//         if (language == "en") {
//           language = "English";
//         } else if (language == "ja") {
//           language = "Japanese";
//         } else if (language == "te") {
//           language = "Telugu";
//         }
//         // Formatting Dates
//         DateTime releaseDate =
//             DateFormat("yyyy-MM-dd").parse(movies[index].release_date);
//         String newDate = DateFormat("yyyy-MM-dd").format(releaseDate);

//         // Parsing Date from Favourite Table
//         DateTime dateFavourite =
//             DateFormat("yyyy-MM-dd").parse(movies[index].created_at);
//         String dateFav = DateFormat("yyyy-MM-dd").format(dateFavourite);

//         return InkWell(
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => MovieProfile(movie: movies[index])));
//           },
//           child: Stack(children: [
//             Container(
//               decoration: BoxDecoration(
//                   color: Color.fromARGB(33, 55, 55, 55),
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(12),
//                       bottomRight: Radius.circular(12))),
//               margin: EdgeInsets.only(bottom: 5),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(5),
//                     child: Image.network(
//                       "https://image.tmdb.org/t/p/w500/" +
//                           movies[index].poster_path,
//                       width: 100,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 20,
//                   ),

//                   // Viewing DATA
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             " Date Added to Favourites: " + dateFav,
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 color: Color.fromARGB(129, 255, 255, 255)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: 250,
//                         child: Text(
//                           movies[index].title,
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Text(
//                         language,
//                         style: TextStyle(
//                             fontSize: 13,
//                             color: Color.fromARGB(129, 255, 255, 255),
//                             fontStyle: FontStyle.italic),
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Icon(
//                             Icons.star,
//                             size: 13,
//                             color: Colors.yellow[300],
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             movies[index].vote_average.toString() + " / 10.0 ",
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 color: Color.fromARGB(129, 255, 255, 255)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 5,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Icon(
//                             Icons.calendar_month,
//                             size: 13,
//                             color: Color.fromARGB(129, 255, 255, 255),
//                           ),
//                           SizedBox(
//                             width: 5,
//                           ),
//                           Text(
//                             newDate,
//                             style: TextStyle(
//                                 fontSize: 13,
//                                 color: Color.fromARGB(129, 255, 255, 255)),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               setState(() {
//                                 // Set State here to Update Screen Once Deleted Item
//                                 APIService.deleteFavourite(movies[index].id);
//                                 showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                           title: Text('Deleted Movie'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () =>
//                                                     Navigator.pop(context),
//                                                 child: Text('OK'))
//                                           ],
//                                         ));
//                               });
//                             },
//                             child: Container(
//                               child: Icon(
//                                 Icons.delete,
//                                 color: Colors.red[300],
//                               ),
//                               padding: EdgeInsets.only(
//                                   left: 10, right: 10, top: 10, bottom: 10),
//                               decoration: BoxDecoration(
//                                   color: Color.fromARGB(26, 255, 255, 255),
//                                   borderRadius: BorderRadius.circular(5)),
//                             ),
//                           ),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           InkWell(
//                             onTap: () {/* For Now No Functions */},
//                             child: Container(
//                               child: Icon(
//                                 Icons.share,
//                                 color: Colors.white30,
//                               ),
//                               padding: EdgeInsets.only(
//                                   left: 10, right: 10, top: 10, bottom: 10),
//                               decoration: BoxDecoration(
//                                   color: Color.fromARGB(26, 255, 255, 255),
//                                   borderRadius: BorderRadius.circular(5)),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ]),
//         );
//       },
//     );
//   }

//   Widget loadAllFavouriteMovies() {
//     return FutureBuilder(
//       future: APIService.getFavouriteMovies(),
//       builder: (
//         BuildContext context,
//         AsyncSnapshot<List<FavouriteMovieModel>?> allmovies,
//       ) {
//         if (allmovies.hasData) {
//           return allMovieList(allmovies.data);
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
// }
