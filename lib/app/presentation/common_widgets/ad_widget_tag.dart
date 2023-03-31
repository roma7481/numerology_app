import 'package:flutter/material.dart';

Widget adWidgetTag() {
  return Container(
    width: 14,
    height: 14,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4.0),
      color: Colors.blueAccent,
    ),
    child: const Center(
        child: Text(
          'AD',
          style: TextStyle(
            fontSize: 10,
            color: Colors.white,
          ),
        )),
  );
}