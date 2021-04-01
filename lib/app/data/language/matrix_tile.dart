import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';

Widget buildMatrixTileButton(
  String text,
  Function onPressed,
  double sideLength, {
  bool isSelected = false,
}) {
  return Padding(
    padding: const EdgeInsets.all(4.0),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: Container(
        height: sideLength,
        width: sideLength,
        color: isSelected ? selectedTileColor : unselectedTileColor,
        child: TextButton(
            child: Text(
              text,
              style: matrixTileStyle,
            ),
            onPressed: onPressed),
      ),
    ),
  );
}
