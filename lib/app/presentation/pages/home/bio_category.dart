import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget buildBioCategory(BuildContext context) {
  return Container(
    height: 200,
    child: Column(
      children: [
        _buildHeader(Globals.instance.language.dailyBio),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProgress(context, physicalGradient),
              _buildProgress(context, emotionalGradient),
              _buildProgress(context, intellectGradient),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildProgress(BuildContext context, LinearGradient gradient) {
  return CircularPercentIndicator(
      radius: MediaQuery.of(context).size.width * 0.24,
      lineWidth: 7.0,
      reverse: false,
      percent: 0.8,
      animation: true,
      animationDuration: 2200,
      center: new Text(
        "100%",
        style: bioPercentage,
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: bioCircleBg,
      linearGradient: gradient);
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
