import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/language/language_ru.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';
import 'package:numerology/app/presentation/pages/welcome/input_text_tile.dart';
import 'package:numerology/app/presentation/pages/welcome/name_utils.dart';

class DescriptionNameBasedPage extends StatefulWidget {
  final String categoryName;
  final Function getPage;

  const DescriptionNameBasedPage({Key key, this.categoryName, this.getPage})
      : super(key: key);

  @override
  _DescriptionNameBasedPageState createState() =>
      _DescriptionNameBasedPageState();
}

class _DescriptionNameBasedPageState extends State<DescriptionNameBasedPage> {
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerMiddleName = TextEditingController();
  Profile currentProfile;
  bool _shouldInitName;

  @override
  void initState() {
    super.initState();
    _shouldInitName = true;
  }

  @override
  void dispose() {
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerMiddleName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    });
  }

  Widget _buildPageContent(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        if (!isValidName(state.profile)) {
          currentProfile = state.profile;

          if (_shouldInitName) {
            controllerFirstName.value = controllerFirstName.value
                .copyWith(text: currentProfile.firstName);
            controllerLastName.value = controllerLastName.value
                .copyWith(text: currentProfile.lastName);
            controllerMiddleName.value = controllerMiddleName.value
                .copyWith(text: currentProfile.middleName);
            _shouldInitName = false;
          }

          return _showForm(context);
        } else {
          return _showDescriptionPage(state);
        }
      } else if (state is UserDataError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  bool isValidName(Profile profile) {
    return _isValidName(
        profile.firstName, profile.lastName, profile.middleName);
  }

  bool _isValidName(String firstName, String lastName, String middleName) {
    if (firstName.isEmpty || lastName.isEmpty) {
      return false;
    }
    if (Globals.instance.language is LanguageRu && middleName.isEmpty) {
      return false;
    }
    return true;
  }

  FutureBuilder _showDescriptionPage(UserDataReady state) {
    return FutureBuilder(
      future: widget.getPage(state.profile, widget.categoryName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else {
          return progressBar();
        }
      },
    );
  }

  SafeArea _showForm(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: _buildHeader(),
        ),
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
          _buildNameSettingsText(),
          _buildNameDialog(),
          _buildNotice(),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      Globals.instance.getLanguage().nameSettings,
      style: headerTextStyle,
    );
  }

  Widget _buildNameSettingsText() {
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: screenHeight * 0.15, left: 16.0, right: 16.0),
      child: Text(
        Globals.instance.getLanguage().categoryRequiresName,
        textAlign: TextAlign.center,
        style: contentTextStyle,
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
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
      padding: const EdgeInsets.only(top: 28.0, left: 32.0, right: 32.0),
      child: Text(
        Globals.instance.language.nameSettingsNotice,
        style: noticeTextStyle,
      ),
    );
  }

  Future<void> _onNextPressed(
    BuildContext context,
  ) async {
    if (!_isValidName(
      controllerFirstName.text,
      controllerLastName.text,
      controllerMiddleName.text,
    )) {
      showToast(Globals.instance.language.enterMissingData);
    } else if (shouldContainVowels(
      controllerMiddleName.text,
      controllerFirstName.text,
      controllerLastName.text,
    )) {
      showToast(Globals.instance.language.nameShouldContainVowels);
    } else {
      Profile updatedProfile = currentProfile.copyWith(
          firstName: controllerFirstName.text,
          middleName: controllerMiddleName.text,
          lastName: controllerLastName.text);

      context.read<UserDataCubit>().emitPrimaryUserUpdate(updatedProfile);
      context.read<ProfilesCubit>().emitUpdateProfile(updatedProfile);
    }
  }
}
