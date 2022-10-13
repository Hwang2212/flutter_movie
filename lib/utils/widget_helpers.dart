import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget showLoadingIndicator() {
  if (Platform.isIOS) {
    return const CupertinoActivityIndicator();
  } else {
    return const CircularProgressIndicator();
  }
}
