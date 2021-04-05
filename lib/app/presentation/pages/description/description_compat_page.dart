import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';

class DescriptionPartnerDobBasedPage extends StatefulWidget {
  final String categoryName;
  final Widget page;

  const DescriptionPartnerDobBasedPage({Key key, this.categoryName, this.page})
      : super(key: key);

  @override
  _DescriptionPartnerDobBasedPageState createState() =>
      _DescriptionPartnerDobBasedPageState();
}

class _DescriptionPartnerDobBasedPageState
    extends State<DescriptionPartnerDobBasedPage> {
  var _currentProfile;
  var _selectedDate;
  var _partnerDob;
  var _isPartnerDobSet = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    });
  }

  Widget _buildPageContent(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        _currentProfile = state.profile;
        if (state.profile.partnerDob == null) {
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
    return (categories.first.page as DescriptionPartnerDobBasedPage).page;
  }

  Widget _showForm(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Column(
        children: [
          _partnerDobPicker(context),
          _buildContinueButton(context),
        ],
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

  _onNextPressed(BuildContext context) {
    if (!_isPartnerDobSet) {
      showToast(Globals.instance.language.enterMissingData);
    } else {
      Profile updatedProfile =
          _currentProfile.copyWith(partnerDob: _partnerDob);
      context.read<UserDataCubit>().emitPrimaryUserUpdate(updatedProfile);
      context.read<ProfilesCubit>().emitUpdateProfile(updatedProfile);
    }
  }

  Widget _partnerDobPicker(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.15, bottom: 16.0),
          child: Text(
            Globals.instance.getLanguage().enterPartnerDob,
            style: radioButtonTextStyle,
          ),
        ),
        buildCustomButton(_getButtonText(), partnerDobButtonColor, () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            onConfirm: (date) {
              setState(() {
                _selectedDate = date;
                updatePartnersDobDate(date);
              });
            },
            locale: Globals.instance.getLocaleType(),
            currentTime: DateService.getDateTimeMinusNumYear(25),
          );
        }, dateOfBirthButtonTextStyle),
      ],
    );
  }

  String _getButtonText() {
    if (_selectedDate == null) {
      return Globals.instance.language.partnersDob;
    }
    return DateService.getFormattedDate(_selectedDate);
  }

  void updatePartnersDobDate(DateTime date) {
    setState(() {
      _partnerDob = DateService.toTimestamp(date);
      _isPartnerDobSet = true;
    });
  }
}
