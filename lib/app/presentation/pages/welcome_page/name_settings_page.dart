import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/line_widget.dart';

import 'name_dialog.dart';

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
          _buildNotice(),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 16.0),
      child: Text(
        Globals.instance.getLanguage().nameSettings,
        style: headerTextStyle,
      ),
    );
  }

  Widget _buildNameSettingsText() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
        Globals.instance.getLanguage().nameSettingsText,
        style: contentTextStyle,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
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
                  () => _onNextPressed(),
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

  Widget _buildNameDialog() {
    return NameDialog();
  }

  Widget _buildNotice() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
        Globals.instance.language.nameSettingsNotice,
        style: noticeTextStyle,
      ),
    );
  }

  Future<void> _onNextPressed() async {}
}
