// LOAD ALL MOVIES
  // Widget allMovieList(movies) {
  //   return Expanded(
  //     child: GridView.builder(
  //         gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
  //             maxCrossAxisExtent: 400,
  //             childAspectRatio: 0.75,
  //             crossAxisSpacing: 3,
  //             mainAxisSpacing: 3),
  //         shrinkWrap: true,
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
  //             child: Stack(alignment: Alignment.center, children: [
  //               Container(
  //                 decoration: BoxDecoration(
  //                     color: Colors.blueGrey,
  //                     borderRadius: BorderRadius.circular(15)),
  //                 child: Image.network("https://image.tmdb.org/t/p/w500/" +
  //                     movies[index].poster_path),
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.all(5.0),
  //                 alignment: Alignment.bottomCenter,
  //                 decoration: BoxDecoration(
  //                   gradient: LinearGradient(
  //                     begin: Alignment.topCenter,
  //                     end: Alignment.bottomCenter,
  //                     colors: <Color>[
  //                       Colors.black.withAlpha(0),
  //                       Colors.black12,
  //                       Color.fromARGB(255, 0, 0, 0)
  //                     ],
  //                   ),
  //                 ),
  //                 child: Text(
  //                   movies[index].title,
  //                   style: TextStyle(color: Colors.white, fontSize: 20.0),
  //                 ),
  //               ),
  //             ]),
  //           );
  //         }),
  //   );
  // }

  // Widget loadAllMovies() {
  //   return FutureBuilder(
  //     future: APIService.getMovies(),
  //     builder: (
  //       BuildContext context,
  //       AsyncSnapshot<List<MovieModel>?> allmovies,
  //     ) {
  //       if (allmovies.hasData) {
  //         return allMovieList(allmovies.data);
  //       } else {
  //         return Center(child: CircularProgressIndicator());
  //       }
  //     },
  //   );
  // }