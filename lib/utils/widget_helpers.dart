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

Widget iconButton(icon) {
  return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: const Color.fromARGB(26, 255, 255, 255),
          borderRadius: BorderRadius.circular(5)),
      child: icon);
}
