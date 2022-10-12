import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/mainpage.dart';
import 'package:flutter_movie/provider/favourite_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavouriteMovieProvider(),
      child: const MaterialApp(
        home: MainPage(),
      ),
    );
  }
}
