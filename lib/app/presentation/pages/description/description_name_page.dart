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
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/line_widget.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';
import 'package:numerology/app/presentation/pages/welcome/input_text_tile.dart';

class DescriptionNameBasedPage extends StatefulWidget {
  final String categoryName;
  final Widget page;

  const DescriptionNameBasedPage({Key key, this.categoryName, this.page})
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
        if (state.profile.firstName.isEmpty &&
            state.profile.middleName.isEmpty &&
            state.profile.lastName.isEmpty) {
          currentProfile = state.profile;
          return _showForm(context);
        } else {
          return _sowDescriptionPage(state);
        }
      } else if (state is UserDataError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Widget _sowDescriptionPage(UserDataReady state) {
    var categories = state.categories
        .where((category) => category.text == widget.categoryName)
        .toList();
    if (categories.isEmpty) {
      return errorDialog();
    }
    return (categories.first.page as DescriptionNameBasedPage).page;
  }

  SafeArea _showForm(BuildContext context) {
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
        Globals.instance.getLanguage().categoryRequiresName,
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
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: Text(
        Globals.instance.language.nameSettingsNotice,
        style: noticeTextStyle,
      ),
    );
  }

  Future<void> _onNextPressed(
    BuildContext context,
  ) async {
    if (controllerMiddleName.text.isEmpty &&
        controllerFirstName.text.isEmpty &&
        controllerLastName.text.isEmpty) {
      showToast(Globals.instance.language.enterMissingData);
    } else {
      Profile updatedProfile = currentProfile.copyWith(
          firstName: controllerFirstName.text,
          middleName: controllerMiddleName.text,
          lastName: controllerLastName.text);

      context.read<UserDataCubit>().emitPrimaryUserUpdate(updatedProfile);
      context.read<ProfilesCubit>().emitUpdateName(updatedProfile);
    }
  }
}
