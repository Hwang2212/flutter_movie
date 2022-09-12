import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/framework.dart';

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
          title: Text(
            "Movie Profile",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Color.fromARGB(229, 0, 0, 0),
        body: loadMovieProfile());
  }

  Widget loadMovieProfile() {
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
                    Color.fromARGB(255, 0, 0, 0)
                  ],
                ),
              ),
            ),
          ]),
          SizedBox(
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
              SizedBox(
                width: 3,
              ),
              Text(
                widget.movie.vote_average.toString() + " / 10.0 ",
                style: TextStyle(
                    fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
              ),
            ],
          ),
          SizedBox(
            height: 1,
          ),
          Text(
            widget.movie.vote_count.toString() + " votes",
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.movie.title,
            style: TextStyle(
                fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            "Released on " + newDate,
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white30,
                  ),
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(26, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
              SizedBox(
                width: 3,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  child: Icon(
                    Icons.share,
                    color: Colors.white30,
                  ),
                  padding:
                      EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(26, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            ],
          ),
          Text(
            widget.movie.original_title,
            style: TextStyle(
                fontSize: 20, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.movie.overview,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 13, color: Color.fromARGB(129, 255, 255, 255)),
          ),
          SizedBox(
            height: 10,
          ),
          widget.movie.adult
              ? Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text("18+"))
              : Container(
                  padding:
                      EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.green[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Children Friendly",
                  )),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
            child: Text(
              language,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
            decoration: BoxDecoration(
                color: Colors.white38, borderRadius: BorderRadius.circular(10)),
          )
        ],
      ),
    );
  }
}
