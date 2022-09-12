import 'package:flutter/material.dart';
import 'package:flutter_movie/pages/mainpage.dart';

void main() => runApp(MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => MainPage(),
      },
    ));
