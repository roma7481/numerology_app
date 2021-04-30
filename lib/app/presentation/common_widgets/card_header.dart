import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/constants/text_styles.dart';

Widget buildHeader(String header, String iconPath) {
  return Center(
    child: Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 24.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconPath != null
              ? SvgPicture.asset(iconPath, height: 20.0)
              : Container(),
          Flexible(
            child: Text(
              header,
              overflow: TextOverflow.ellipsis,
              style: descriptionHeaderStyle,
            ),
          ),
          Opacity(
              opacity: 0.0,
              child: iconPath != null
                  ? SvgPicture.asset(iconPath, height: 20.0)
                  : Container()),
        ],
      ),
    ),
  );
}
