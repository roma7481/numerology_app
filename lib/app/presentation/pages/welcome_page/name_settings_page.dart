import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/line_widget.dart';

class NameSettingsPage extends StatelessWidget {
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
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildHeader(),
          buildLine(context),
          _buildNameSettingsText(),
          _buildNameDialog(),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
      child: Text(
        Globals.instance.getLanguage().nameSettings,
        style: headerTextStyle,
      ),
    );
  }

  _buildNameSettingsText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Text(
        Globals.instance.getLanguage().nameSettingsText,
        style: contentTextStyle,
      ),
    );
  }

  _buildContinueButton(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                child: buildCustomButton(
                  Globals.instance.getLanguage().continueText,
                  continueButtonColor,
                  () {},
                  continueButtonTextStyle,
                  padding: 32.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildNameDialog() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        Globals.instance.language.enterName,
        style: radioButtonTextStyle,
      ),
    );
  }
}
