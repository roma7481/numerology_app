import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/line_widget.dart';
import 'package:numerology/app/presentation/common_widgets/standard_button.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';

import 'language_picker.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool isBirthdaySet = false;
  var _selectedDate;
  int dob;

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
          _buildWelcomeText(),
          LanguagePicker(),
          _buildDOBPicker(context),
          _buildContinueButton(context),
        ],
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
        Globals.instance.getLanguage().welcomeText,
        style: contentTextStyle,
      ),
    );
  }

  _buildDOBPicker(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
        listener: (context, state) {},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Text(
                Globals.instance.getLanguage().selectDateOfBirth,
                style: radioButtonTextStyle,
              ),
            ),
            buildCustomButton(_getButtonText(), dateOfBirthButtonColor, () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    _selectedDate = date;
                    updateBirthday(date);
                  });
                },
                locale: Globals.instance.getLocaleType(),
                currentTime: DateService.getDateTimeMinusNumYear(25),
              );
            }, dateOfBirthButtonTextStyle),
          ],
        ));
  }

  String _getButtonText() {
    if (_selectedDate == null) {
      return Globals.instance.language.dateOfBirth;
    }
    return DateService.getFormattedDate(_selectedDate);
  }

  _buildContinueButton(BuildContext context) {
    return buildContinueButton(
      text: Globals.instance.getLanguage().continueText,
      color: yellowButtonColor,
      onPressed: _onContinuePressed,
    );
  }

  void _onContinuePressed() async {
    if (!isBirthdaySet) {
      showToast(Globals.instance.language.enterBirthdayWarning);
    } else {
      navigateToNameSettings(context, dob);
    }
  }

  void updateBirthday(DateTime date) {
    setState(() {
      dob = DateService.toTimestamp(date);
      isBirthdaySet = true;
    });
  }
}
