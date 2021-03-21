import 'package:flutter/material.dart';
import 'package:numerology/app/constants/text_styles.dart';

buildLanguagePicker(BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 36.0, bottom: 8.0),
        child: Text(
          'Please chose language',
          style: radioButtonTextStyle,
        ),
      ),
      Column(
        children: [
          _buildRadioButton(context, 'English'),
          _buildRadioButton(context, 'Russian'),
          _buildRadioButton(context, 'Spanish'),
        ],
      ),
    ],
  );
}

Padding _buildRadioButton(BuildContext context, String text) {
  final double screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.only(left: screenWidth * 0.24),
    child: Row(
      children: [
        new Radio(
          fillColor: radioButtonColor,
          value: 0,
          groupValue: 'English',
          onChanged: (_) {},
        ),
        new Text(
          text,
          style: languageTextStyle,
        ),
      ],
    ),
  );
}