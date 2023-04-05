import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/constants.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';

class DescriptionWeddingBasedPage extends StatefulWidget {
  final String categoryName;
  final Function getPage;

  const DescriptionWeddingBasedPage({
    Key key,
    this.categoryName,
    this.getPage,
  }) : super(key: key);

  @override
  _DescriptionWeddingBasedPageState createState() =>
      _DescriptionWeddingBasedPageState();
}

class _DescriptionWeddingBasedPageState
    extends State<DescriptionWeddingBasedPage> {
  var _currentProfile;
  var _selectedDate;
  var _weddingDate;
  var _isWeddingSet = false;

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
        if (state.profile.weddingDate == null) {
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
    return FutureBuilder(
      future: widget.getPage(state.profile, widget.categoryName),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else if (snapshot.hasError) {
          return errorDialog();
        } else {
          return progressBar();
        }
      },
    );
  }

  Widget _showForm(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: _buildHeader(),
        ),
        body: _buildContent(context),
      ),
    );
  }

  Widget _buildHeader() {
    return Text(
      Globals.instance.getLanguage().weddingDate,
      style: headerTextStyle,
    );
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      child: Column(
        children: [
          _weddingDatePicker(context),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 56.0, bottom: 8.0),
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
    );
  }

  _onNextPressed(BuildContext context) {
    if (!_isWeddingSet) {
      showToast(Globals.instance.language.enterMissingData);
    } else {
      Profile updatedProfile =
          _currentProfile.copyWith(weddingDate: _weddingDate);
      context.read<UserDataCubit>().emitPrimaryUserUpdate(updatedProfile);
      context.read<ProfilesCubit>().emitUpdateProfile(updatedProfile);
    }
  }

  Widget _weddingDatePicker(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height * 0.25, bottom: 48.0),
          child: Text(
            Globals.instance.getLanguage().enterWeddingDate,
            style: radioButtonTextStyle,
          ),
        ),
        buildCustomButton(_getButtonText(), weddingDateButtonColor, () {
          DatePicker.showDatePicker(
            context,
            showTitleActions: true,
            onConfirm: (date) {
              setState(() {
                _selectedDate = date;
                updateWeddingDate(date);
              });
            },
            minTime: minDate,
            locale: Globals.instance.getLocaleType(),
            currentTime: DateService.getDateTimeMinusNumYear(25),
          );
        }, dateOfBirthButtonTextStyle),
      ],
    );
  }

  String _getButtonText() {
    if (_selectedDate == null) {
      return Globals.instance.language.weddingDate;
    }
    return DateService.getFormattedDate(_selectedDate);
  }

  void updateWeddingDate(DateTime date) {
    setState(() {
      _weddingDate = DateService.toTimestamp(date);
      _isWeddingSet = true;
    });
  }
}
