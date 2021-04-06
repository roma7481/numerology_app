import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/text_styles.dart';

Widget buildBioCategory(BuildContext context) {
  return Container(
    height: 200,
    child: Column(
      children: [
        _buildHeader(Globals.instance.language.dailyBio),
      ],
    ),
  );
}

Widget _buildHeader(String header) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 16.0,
      left: 8.0,
      bottom: 8.0,
    ),
    child: Text(
      header,
      style: descriptionHeaderStyle,
    ),
  );
}
