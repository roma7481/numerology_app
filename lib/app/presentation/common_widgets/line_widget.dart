import 'package:flutter/material.dart';

Widget buildLine(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Container(
      height: 1.0,
      width: MediaQuery.of(context).size.width * 0.68,
      color: Colors.white,
    ),
  );
}
