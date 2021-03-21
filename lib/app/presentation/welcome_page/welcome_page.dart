import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';

import 'immage_picker.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _buildHeader(),
            _buildLine(context),
            _buildWelcomeText(),
            buildLanguagePicker(context),
            _buildDOBPicker(),
            _buildContinueButton(context),
          ],
        ),
      ),
    );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
      child: Text(
        'Welcome to numerology',
        style: headerTextStyle,
      ),
    );
  }

  _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        'Let\'s start by setting your language and date of birth. Date of birth is required for Numerological calculations.',
        style: contentTextStyle,
      ),
    );
  }

  _buildDOBPicker() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
          child: Text(
            'Please enter date of birth',
            style: radioButtonTextStyle,
          ),
        ),
        buildCustomButton('January 21, 2021', dateOfBirthButtonColor, () {},
            dateOfBirthButtonTextStyle),
      ],
    );
  }

  Padding _buildLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.68,
        color: Colors.white,
      ),
    );
  }

  _buildContinueButton(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: buildCustomButton(
              'Continue',
              continueButtonColor,
                  () {},
              continueButtonTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
