import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'custom_raised_button.dart';

Widget buildCategoryTile(
    {@required String text, @required Function onPressed}) {
  return CustomButton(
    onPressed: onPressed,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        SvgPicture.asset(
          'assets/category_images/masks.svg',
          height: 130.0,
        ),
        Positioned(
          left: 8.0,
          top: 8.0,
          child: Text(
            (text).replaceFirst(RegExp(r' '), '\n'),
            style: new TextStyle(
                fontFamily: 'CallingAngelsPersonalUse',
                fontSize: 20.0,
                color: Colors.black),
          ),
        ),
      ],
    ),
  );
}
