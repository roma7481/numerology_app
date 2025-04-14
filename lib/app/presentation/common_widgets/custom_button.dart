import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildCustomButton(
    String text, Color? buttonColor, Function? onPressed, TextStyle textStyle,
    {double padding = 8.0}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(24.0),
    child: Container(
      color: buttonColor,
      child: Padding(
        padding: EdgeInsets.only(left: padding, right: padding),
        child: TextButton(
            child: Text(
              text,
              style: textStyle,
            ),
            onPressed: onPressed as void Function()?),
      ),
    ),
  );
}
