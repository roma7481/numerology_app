import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/constants/text_styles.dart';

import 'custom_raised_button.dart';

Widget buildCategoryTile(
    {@required String text, @required Function onPressed}) {
  return CustomButton(
    onPressed: onPressed,
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          bottom: -4.0,
          right: -4.0,
          child: SvgPicture.asset(
            'assets/category_images/masks.svg',
            height: 100.0,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 8.0,
          child: Text(
            (text).replaceFirst(RegExp(r' '), '\n'),
            style: categoryTileHeader,
          ),
        ),
      ],
    ),
  );
}
