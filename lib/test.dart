import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_movie/app/app.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  void updateAppState() {
    MyApp.instance.appState = 0;
  }

  void getAppState() {
    log(MyApp.instance.appState.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
