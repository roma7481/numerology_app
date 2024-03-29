
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';

Widget progressBar() {
  return Container(color: backgroundColor, child: Center(child: new SizedBox(
      height: 50.0,
      width: 50.0,
      child: new CircularProgressIndicator(
        value: null,
        strokeWidth: 7.0,
        color: Colors.blue,
      ))),);
}
