import 'dart:math';

import 'package:flutter/cupertino.dart';
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
import 'package:numerology/app/localization/language/language_es.dart';
import 'package:numerology/app/localization/language/language_ru.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';
import 'package:numerology/app/presentation/common_widgets/standard_button.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';
import 'package:numerology/app/presentation/pages/profiles/set_prim_dialog.dart';
import 'package:numerology/app/presentation/pages/welcome/input_text_tile.dart';

class EditProfile extends StatefulWidget {
  final Profile profile;
  final bool isNewProfile;

  const EditProfile({
    Key key,
    this.profile,
    this.isNewProfile = false,
  }) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var _dob;
  var _partnerDob;
  var _weddingDate;
  var _updatedProfile;
  var _coupleDate;
  var _wasUpdated = false;

  final controllerProfileName = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerMiddleName = TextEditingController();

  @override
  void initState() {
    _updatedProfile = widget.profile.copyWith();
    if (widget.profile.dob != null) {
      _dob = DateService.fromTimestamp(widget.profile.dob);
    }
    if (widget.profile.partnerDob != null) {
      _partnerDob = DateService.fromTimestamp(widget.profile.partnerDob);
    }
    if (widget.profile.weddingDate != null) {
      _weddingDate = DateService.fromTimestamp(widget.profile.weddingDate);
    }
    if (widget.profile.coupleDate != null) {
      _coupleDate = DateService.fromTimestamp(widget.profile.coupleDate);
    }

    controllerProfileName.value = controllerProfileName.value.copyWith(
      text: widget.profile.profileName.isEmpty
          ? getDefaultProfileName()
          : widget.profile.profileName,
    );
    controllerFirstName.value = controllerProfileName.value
        .copyWith(text: widget.profile.firstName ?? '');
    controllerLastName.value = controllerProfileName.value
        .copyWith(text: widget.profile.lastName ?? '');
    controllerMiddleName.value = controllerProfileName.value
        .copyWith(text: widget.profile.middleName ?? '');
    super.initState();
  }

  String getDefaultProfileName() {
    var random = Random.secure();
    return Globals.instance.language.profile +
        '_' +
        (random.nextInt(899) + 100).toString();
  }

  @override
  void dispose() {
    controllerProfileName.dispose();
    controllerFirstName.dispose();
    controllerLastName.dispose();
    controllerMiddleName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _buildPageBody(),
      ),
    );
  }

  Widget _buildPageBody() {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildProfileName(),
        ],
      ),
    );
  }

  Widget _buildProfileName() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          _buildProfileSettings(),
          _buildUsernameSettings(),
          _buildDobSettings(),
          _buildSecondarySettings(),
          _padding(),
          _buildButtons(),
        ],
      ),
    );
  }

  Widget _padding() {
    double height = MediaQuery.of(context).size.height;
    return SizedBox(
      height: height * 0.13,
    );
  }

  Widget _buildSecondarySettings() {
    if (Globals.instance.language is LanguageRu) {
      return _buildRu();
    } else if (Globals.instance.language is LanguageEs) {
      return _buildEs();
    }
    return _buildEn();
  }

  Widget _buildEn() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _buildPartnerDobSettings(),
      SizedBox(
        width: 10.0,
      ),
      _buildWeddingDateSettings(),
    ]);
  }

  Widget _buildRu() {
    return _buildPartnerDobSettings();
  }

  Widget _buildEs() {
    return _buildCoupleDateSettings();
  }

  Widget _buildButtons() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      _buildContinueBtn(),
      _buildCancelBtn(),
    ]);
  }

  Center _buildInputField(
      String text, TextEditingController controller, String hint,
      {bool canInputNumbers = false}) {
    return buildTextInputTile(context, hint, controller, onChanged: () {
      setState(() {
        _wasUpdated = true;
      });
    }, canInputNumbers: canInputNumbers);
  }

  Widget _buildHeader(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Text(
        text,
        style: headerTextStyle,
      ),
    );
  }

  Widget _buildProfileSettings() {
    var language = Globals.instance.language;
    return Column(
      children: [
        _buildHeader(Globals.instance.language.profileName),
        _buildInputField(controllerProfileName.text, controllerProfileName,
            language.profileName,
            canInputNumbers: true),
      ],
    );
  }

  Widget _buildUsernameSettings() {
    var language = Globals.instance.language;
    return Column(
      children: [
        _buildHeader(Globals.instance.language.usersName),
        _buildInputField(
            widget.profile.firstName, controllerFirstName, language.firstName),
        _buildInputField(
            widget.profile.lastName, controllerLastName, language.lastName),
        _buildInputField(widget.profile.middleName, controllerMiddleName,
            language.middleName),
      ],
    );
  }

  Widget _buildDobSettings() {
    return Column(
      children: [
        _buildHeader(Globals.instance.language.dob),
        _buildDOBPicker(_getDobText(), _updateDob),
      ],
    );
  }

  Widget _buildPartnerDobSettings() {
    return Column(
      children: [
        _buildHeader(Globals.instance.language.partnersDob),
        _buildDOBPicker(_getPartnerDobText(), _updatePartnerDob),
      ],
    );
  }

  Widget _buildCoupleDateSettings() {
    return Column(
      children: [
        _buildHeader(Globals.instance.language.coupleDateProfiles),
        _buildDOBPicker(_getCoupleText(), _updateCoupleDate),
      ],
    );
  }

  Widget _buildWeddingDateSettings() {
    return Column(
      children: [
        _buildHeader(Globals.instance.language.weddingDate),
        _buildDOBPicker(_getWeddingDateText(), _updateWeddingDate),
      ],
    );
  }

  _buildDOBPicker(String btnText, Function onClick) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: BlocListener<LanguageCubit, LanguageState>(
          listener: (context, state) {},
          child: buildCustomButton(btnText, dateOfBirthButtonColor, () {
            DatePicker.showDatePicker(
              context,
              showTitleActions: true,
              onConfirm: (date) {
                setState(() {
                  onClick(date);
                });
              },
              locale: Globals.instance.getLocaleType(),
              currentTime: DateService.getDateTimeMinusNumYear(25),
            );
          }, dateOfBirthButtonTextStyle)),
    );
  }

  void _updateDob(DateTime date) {
    setState(() {
      _wasUpdated = true;
      _dob = date;
    });
  }

  void _updatePartnerDob(DateTime date) {
    setState(() {
      _wasUpdated = true;
      _partnerDob = date;
    });
  }

  void _updateCoupleDate(DateTime date) {
    setState(() {
      _wasUpdated = true;
      _coupleDate = date;
    });
  }

  void _updateWeddingDate(DateTime date) {
    setState(() {
      _wasUpdated = true;
      _weddingDate = date;
    });
  }

  String _getDobText() {
    return _dob == null
        ? Globals.instance.language.dob
        : DateService.getFormattedDate(_dob);
  }

  String _getPartnerDobText() {
    return _partnerDob == null
        ? Globals.instance.language.partnersDob
        : DateService.getFormattedDate(_partnerDob);
  }

  String _getCoupleText() {
    return _coupleDate == null
        ? Globals.instance.language.coupleDateProfiles
        : DateService.getFormattedDate(_coupleDate);
  }

  String _getWeddingDateText() {
    return _weddingDate == null
        ? Globals.instance.language.weddingDate
        : DateService.getFormattedDate(_weddingDate);
  }

  Widget _buildContinueBtn() {
    return buildStandardButton(
      text: Globals.instance.getLanguage().continueText,
      color: yellowButtonColor,
      onPressed: _onContinue,
    );
  }

  Future<void> _onContinue() async {
    if (_dob == null) {
      showToast(Globals.instance.language.enterBirthdayWarning);
      return;
    }

    if (_updatedProfile != null && _wasUpdated) {
      _updatedProfile = _updatedProfile.copyWith(
          dob: DateService.toTimestamp(_dob),
          profileName: controllerProfileName.text,
          firstName: controllerFirstName.text,
          lastName: controllerLastName.text,
          middleName: controllerMiddleName.text,
          partnerDob:
              _partnerDob != null ? DateService.toTimestamp(_partnerDob) : null,
          coupleDate:
              _coupleDate != null ? DateService.toTimestamp(_coupleDate) : null,
          weddingDate: _weddingDate != null
              ? DateService.toTimestamp(_weddingDate)
              : null);

      widget.isNewProfile
          ? await _addNewProfile(_updatedProfile)
          : await _updateExistingProfile(_updatedProfile);
    }

    Navigator.of(context).pop();
    _wasUpdated = false;
  }

  Future<void> _addNewProfile(Profile profile) async {
    bool setAsPrim = await showProfileDialog(context);
    if (setAsPrim) {
      await context.read<ProfilesCubit>().emitAddPrimProfile(profile);
      // context.read<UserDataCubit>().emitPrimaryUserUpdate(primProfile);
    } else {
      await context.read<ProfilesCubit>().emitAddProfile(profile);
    }
  }

  Future<void> _updateExistingProfile(Profile profile) async {
    await context.read<ProfilesCubit>().emitUpdateProfile(profile);
    await context.read<UserDataCubit>().emitPrimaryUserUpdate(profile);
  }

  Widget _buildCancelBtn() {
    return buildStandardButton(
      text: Globals.instance.getLanguage().cancel,
      color: greyButtonColor,
      onPressed: () {
        _wasUpdated = false;
        Navigator.of(context).pop();
      },
    );
  }
}
