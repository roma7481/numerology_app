import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/line_widget.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';

import 'birthday_picker.dart';
import 'language_picker.dart';

class WelcomePage extends StatelessWidget {
  static bool isBirthdaySet = false;
  static int dob = DateService.getTimeInMilli(DateService.getCurrentDate());

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfilesCubit, ProfilesState>(listener:
        (context, state) {
      if (state is ProfilesInit) {
        context.read<UserDataCubit>().emitPrimaryUserUpdate(state.profileId);
      }
    }, child:
        BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    }));
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
    return BirthdayPicker(onClick: updateBirthday);
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
                  () {
                    _onContinuePressed(context);
                  },
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

  void _onContinuePressed(BuildContext context) async {
    if (!isBirthdaySet) {
      showToast(Globals.instance.language.enterBirthdayWarning);
    } else {
      context.read<ProfilesCubit>().emitInitProfile(Profile(dob: dob));
    }
  }

  void updateBirthday() {
    isBirthdaySet = true;
  }
}
