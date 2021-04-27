import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

Widget buildBioPiCharts(BuildContext context, List<double> bio,
    {bool isHeaderVisible = true}) {
  var _language = Globals.instance.language;
  var bioPhis = bio[0];
  var bioEmotion = bio[1];
  var bioIntel = bio[2];

  return Container(
    // height: isHeaderVisible ? 210 : 150,
    child: Wrap(
      children: [
        Column(
          children: [
            _buildHeader(isHeaderVisible),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildBio(context, physicalGradient, _language.physicalBio,
                      bioNamePhis, bioPhis),
                  _buildBio(context, emotionalGradient, _language.emotionalBio,
                      bioNameEmotion, bioEmotion),
                  _buildBio(context, intellectGradient, _language.intellectBio,
                      bioNameIntel, bioIntel),
                ],
              ),
            ),
          ],
        )
      ],
    ),
  );
}

Column _buildBio(BuildContext context, LinearGradient gradient, String text,
    TextStyle style, double value) {
  return Column(
    children: [
      _buildProgressChart(context, gradient, value),
      _buildProgressName(context, text, style),
    ],
  );
}

Widget _buildImage() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: IconTheme(
      data: new IconThemeData(color: Colors.white),
      child: new Icon(Icons.chevron_right),
    ),
  );
}

Widget _buildProgressName(BuildContext context, String text, TextStyle style) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Text(
        text,
        overflow: TextOverflow.ellipsis,
        style: style,
      ),
    ),
  );
}

Widget _buildProgressChart(
    BuildContext context, LinearGradient gradient, double value) {
  var percent = value.toStringAsFixed(0);
  return CircularPercentIndicator(
      radius: MediaQuery.of(context).size.width * 0.24,
      lineWidth: 7.0,
      reverse: value.isNegative,
      percent: double.parse((value.abs() * 0.01).toStringAsFixed(1)),
      animation: true,
      animationDuration: 2200,
      center: new Text(
        percent.toString() + '%',
        style: bioPercentage,
      ),
      circularStrokeCap: CircularStrokeCap.round,
      backgroundColor: bioCircleBg,
      linearGradient: gradient);
}

Widget _buildHeader(bool isHeaderVisible) {
  if (!isHeaderVisible) {
    return Container();
  }
  return Padding(
    padding: const EdgeInsets.only(
      top: 16.0,
      left: 8.0,
      bottom: 8.0,
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Opacity(
          opacity: 0.0,
          child: _buildImage(),
        ),
        Flexible(
          child: Text(
            Globals.instance.language.dailyBio,
            style: descriptionHeaderStyle,
          ),
        ),
        _buildImage(),
      ],
    ),
  );
}
