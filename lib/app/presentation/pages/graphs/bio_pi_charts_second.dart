import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:percent_indicator/percent_indicator.dart';

Widget buildBioPiChartsSecond(BuildContext context, List<double> bio) {
  var _language = Globals.instance.language;

  return Container(
    child: CustomCard(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBio(context, spiritGradient, _language.spiritBio,
                        bioNamePhis, bio[0]),
                    _buildBio(context, awareGradient, _language.awareBio,
                        bioNameEmotion, bio[1]),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildBio(context, intuitGradient, _language.intellectBio,
                        bioNamePhis, bio[2]),
                    _buildBio(context, aestheticGradient,
                        _language.aestheticBio, bioNameEmotion, bio[3]),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Column _buildBio(BuildContext context, LinearGradient gradient, String text,
    TextStyle style, double value) {
  return Column(
    children: [
      _buildProgressChart(context, gradient, value),
      _buildProgressName(text, style),
    ],
  );
}

Widget _buildProgressName(String text, TextStyle style) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: style,
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
