import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';

import 'language_picker.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    });
  }

  SafeArea _buildPageContent(BuildContext context) {
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
            LanguagePicker(),
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
        Globals.instance.getLanguage().welcomeToNumerology,
        style: headerTextStyle,
      ),
    );
  }

  _buildWelcomeText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        Globals.instance.getLanguage().welcomeText,
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
            Globals.instance.getLanguage().selectDateOfBirth,
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
