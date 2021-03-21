import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildCustomButton(
  String text,
  Color buttonColor,
  Function onPressed,
  TextStyle textStyle,
) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(24.0),
    child: Container(
      color: buttonColor,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0),
        child: TextButton(
            child: Text(
              text,
              style: textStyle,
            ),
            onPressed: onPressed()),
      ),
    ),
  );
}
