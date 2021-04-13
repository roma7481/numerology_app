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
import 'package:numerology/app/presentation/pages/welcome/input_text_tile.dart';

class EditProfileEn extends StatefulWidget {
  final Profile profile;

  const EditProfileEn({Key key, this.profile}) : super(key: key);

  @override
  _EditProfileEnState createState() => _EditProfileEnState();
}

class _EditProfileEnState extends State<EditProfileEn> {
  var _dob = DateTime.now();
  var _partnerDob;

  final controllerProfileName = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerLastName = TextEditingController();
  final controllerMiddleName = TextEditingController();

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
    BlocListener<UserDataCubit, UserDataState>(listener: (context, state) {
      if (state is UserDataReady) {
        _dob = DateService.fromTimestamp(state.profile.dob);

        if (state.profile.partnerDob != null) {
          _partnerDob = DateService.fromTimestamp(state.profile.partnerDob);
        }
      }
    });

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
          _buildPartnerDobSettings(),
        ],
      ),
    );
  }

  Center _buildInputField(
      String text, TextEditingController controller, String hint) {
    if (text != null && text.isNotEmpty) {
      controller.text = text;
    }
    return buildTextInputTile(context, hint, controller);
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
        _buildInputField(widget.profile.profileName, controllerProfileName,
            language.profileName),
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
      _dob = date;
      var updatedProfile =
          widget.profile.copyWith(dob: DateService.toTimestamp(date));
      context.read<ProfilesCubit>().emitUpdateProfile(updatedProfile);
      context.read<UserDataCubit>().emitPrimaryUserUpdate(updatedProfile);
    });
  }

  void _updatePartnerDob(DateTime date) {
    setState(() {
      _partnerDob = date;
      var updatedProfile =
          widget.profile.copyWith(partnerDob: DateService.toTimestamp(date));
      context.read<ProfilesCubit>().emitUpdateProfile(updatedProfile);
      context.read<UserDataCubit>().emitPrimaryUserUpdate(updatedProfile);
    });
  }

  String _getDobText() {
    return DateService.getFormattedDate(_dob);
  }

  String _getPartnerDobText() {
    return _partnerDob == null
        ? Globals.instance.language.partnersDob
        : DateService.getFormattedDate(_partnerDob);
  }
}
