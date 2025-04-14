import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/constants/text_styles.dart';

import 'custom_raised_button.dart';

Widget buildCategoryTile({
  required BuildContext context,
  required String text,
  required Function onPressed,
  required String imagePath,
}) {
  var width = MediaQuery.of(context).size.width;
  return CustomButton(
    onPressed: onPressed as void Function(),
    child: Stack(
      alignment: Alignment.bottomRight,
      children: [
        Positioned(
          bottom: -1.0,
          right: -4.0,
          child: SvgPicture.asset(
            imagePath,
            height: width * 0.22,
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
