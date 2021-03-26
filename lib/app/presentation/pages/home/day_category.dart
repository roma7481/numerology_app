import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numerology/app/constants/text_styles.dart';

import 'custom_raised_button.dart';

Widget buildDayCategory({
  @required BuildContext context,
  @required String text,
  @required Function onPressed,
  @required String imagePath,
}) {
  double width = MediaQuery.of(context).size.width * 0.9;

  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: CustomButton(
        onPressed: onPressed,
        child: Container(
          height: 170,
          width: width,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Positioned(
                bottom: -1.0,
                right: -4.0,
                child: SvgPicture.asset(
                  imagePath,
                  height: 70.0,
                ),
              ),
              Positioned(
                left: 8.0,
                top: 8.0,
                child: Text(
                  text.replaceFirst(RegExp(r' '), '\n'),
                  style: categoryTileHeader,
                ),
              ),
            ],
          ),
        )),
  );
}
