import 'package:flutter/cupertino.dart';
import 'package:numerology/app/constants/text_styles.dart';

import 'custom_button.dart';

Widget buildStandardButton({
  required String text,
  Color? color,
  Function? onPressed,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            child: buildCustomButton(
              text,
              color,
              onPressed,
              continueButtonTextStyle,
              padding: 32.0,
            ),
          ),
        ),
      ],
    ),
  );
}
