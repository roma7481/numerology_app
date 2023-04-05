import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/line_widget.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';

import 'input_text_tile.dart';
import 'name_utils.dart';

class NameSettingsPage extends StatefulWidget {
  final int dob;

  const NameSettingsPage({Key key, this.dob}) : super(key: key);

  @override
  _NameSettingsPageState createState() => _NameSettingsPageState();
}

class _NameSettingsPageState extends State<NameSettingsPage> {
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerMiddleName = TextEditingController();

  @override
  void dispose() {
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerMiddleName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfilesCubit, ProfilesState>(listener:
        (context, state) {
      if (state is ProfilesInit) {
        context.read<UserDataCubit>().emitPrimaryUserUpdate(state.profile);
        navigateToMainPage(context);
      }
    }, child:
        BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    }));
  }

  SafeArea _buildPageContent(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: height * 0.1, bottom: 16.0),
      child: Text(
        Globals.instance.getLanguage().nameSettings,
        style: headerTextStyle,
      ),
    );
  }

  Widget _buildNameSettingsText() {
    return Padding(
      padding: const EdgeInsets.only(left: 32.0, right: 32.0),
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0, bottom: 8.0),
              child: Container(
                child: buildCustomButton(
                  Globals.instance.getLanguage().continueText,
                  yellowButtonColor,
                  () => _onNextPressed(context),
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
    var lang = Globals.instance.language;
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Column(
        children: [
          _buildTextInputHeader(),
          buildTextInputTile(context, lang.firstName, controllerFirstName),
          buildTextInputTile(context, lang.lastName, controllerLastName),
          buildTextInputTile(context, lang.middleName, controllerMiddleName),
        ],
      ),
    );
  }

  Text _buildTextInputHeader() {
    return Text(
      Globals.instance.language.enterName,
      style: radioButtonTextStyle,
    );
  }

  Widget _buildNotice() {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, left: 32.0, right: 32.0),
      child: Text(
        Globals.instance.language.nameSettingsNotice,
        style: noticeTextStyle,
      ),
    );
  }

  Future<void> _onNextPressed(
    BuildContext context,
  ) async {
    if (shouldContainVowels(
      controllerMiddleName.text,
      controllerFirstName.text,
      controllerLastName.text,
    )) {
      showToast(Globals.instance.language.nameShouldContainVowels);
    } else {
      context.read<ProfilesCubit>().emitInitProfile(Profile(
            isSelected: 1,
            dob: widget.dob,
            profileName: Globals.instance.language.defaultProfileName,
            middleName: controllerMiddleName.text,
            firstName: controllerFirstName.text,
            lastName: controllerLastName.text,
          ));
    }
  }
}
