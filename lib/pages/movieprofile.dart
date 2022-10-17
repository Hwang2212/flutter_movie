import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_movie/provider/favourite_provider.dart';
import 'package:flutter_movie/utils/widget_helpers.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class MovieProfile extends StatefulWidget {
  const MovieProfile({super.key, required this.movie});

  final movie;

  @override
  State<MovieProfile> createState() => _MovieProfileState();
}

class _MovieProfileState extends State<MovieProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            "Movie Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(229, 0, 0, 0),
        body: loadMovieProfile());
  }

  Widget loadMovieProfile() {
    final provider = Provider.of<FavouriteMovieProvider>(context);

    // Format Languages
    var language = widget.movie.original_language;
    if (language == "en") {
      language = "English";
    } else if (language == "ja") {
      language = "Japanese";
    } else if (language == "te") {
      language = "Telugu";
    }

    // Formatting Dates
    DateTime releaseDate =
        DateFormat("yyyy-MM-dd").parse(widget.movie.release_date);
    String newDate = DateFormat("yyyy-MM-dd").format(releaseDate);
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
                child: Image.network("https://image.tmdb.org/t/p/w500/" +
                    widget.movie.backdrop_path)),
            Container(
              height: 240,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.black.withAlpha(0),
                    Colors.black12,
                    const Color.fromARGB(255, 0, 0, 0)
                  ],
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.star,
                size: 13,
                color: Colors.yellow[300],
              ),
              const SizedBox(
                width: 3,
              ),
              Text(
                widget.movie.vote_average.toString() + " / 10.0 ",
                style: const TextStyle(
                    fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
              ),
            ],
          ),
          const SizedBox(
            height: 1,
          ),
          Text(
            widget.movie.vote_count.toString() + " votes",
            style: const TextStyle(
                fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.movie.title,
            style: const TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "Released on " + newDate,
            style: const TextStyle(
                fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  provider.toggleFavouriteMovie(widget.movie);
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Added to Favourite List'),
                            actions: [
                              TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'))
                            ],
                          ));
                },
                child: provider.isFavourite(widget.movie)
                    ? iconButton(const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ))
                    : iconButton(
                        const Icon(
                          Icons.favorite,
                          color: Colors.white30,
                        ),
                      ),
              ),
              const SizedBox(
                width: 3,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: const Icon(
                    Icons.share,
                    color: Colors.white30,
                  ),
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(26, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ],
          ),
          Text(
            widget.movie.original_title,
            style: const TextStyle(
                fontSize: 20, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.movie.overview,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          const SizedBox(
            height: 10,
          ),
          widget.movie.adult
              ? Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text("18+"))
              : Container(
                  padding: const EdgeInsets.only(
                      left: 30, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: const Text(
                    "Children Friendly",
                  )),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Text(
              language,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
            decoration: BoxDecoration(
                color: Colors.white38, borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
