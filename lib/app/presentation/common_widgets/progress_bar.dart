
import 'package:flutter/material.dart';

Widget progressBar() {
  return Container(color: Color.fromRGBO(1, 1, 1, 0), child: Center(child: new SizedBox(
      height: 50.0,
      width: 50.0,
      child: new CircularProgressIndicator(
        value: null,
        strokeWidth: 7.0,
        color: Colors.blue,
      ))),);
}
