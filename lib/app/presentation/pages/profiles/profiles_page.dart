import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/language/language_es.dart';
import 'package:numerology/app/localization/language/language_ru.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';
import 'package:numerology/app/presentation/pages/home/custom_raised_button.dart';

import 'delete_dialog.dart';
import 'edit_profile.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  List<Profile> _profiles = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfilesCubit, ProfilesState>(builder: (context, state) {
      if (state is ProfilesReady) {
        _profiles = state.profiles;
        return _buildContent();
      } else if (state is ProfilesInit) {
        _profiles = [state.profile];
        return _buildContent();
      } else if (state is ProfilesError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        title: Text(Globals.instance.language.profiles),
      ),
      body: _buildPageBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => navigateToPage(
          context,
          EditProfile(
            profile: Profile(),
            isNewProfile: true,
          ),
        ),
        child: new IconTheme(
          data: new IconThemeData(color: Colors.black),
          child: new Icon(Icons.add),
        ),
        backgroundColor: fabColor,
      ),
    );
  }

  Widget _buildPageBody() {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildList(),
        ],
      ),
    );
  }

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var profile = _profiles[index];
        return _buildProfile(profile);
      },
      childCount: _profiles.length,
    ));
  }

  Widget _buildProfile(Profile profile) {
    return CustomCard(
      child: ExpansionTile(
        initiallyExpanded: profile.isSelected == 1,
        title: Padding(
          padding: const EdgeInsets.only(left: 12.0, bottom: 8.0),
          child: Column(
            children: [
              Stack(
                  children: [_buildPrimInfo(profile), _buildCheckbox(profile)]),
            ],
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Column(
              children: [
                _buildSecondaryInfo(profile),
                _buildLine(),
                _buildEditDeleteBtn(profile),
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding _buildSecondaryInfo(Profile profile) {
    var language = Globals.instance.language;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          _buildNameInfo(language, profile),
          _buildCustomInfo(profile)
        ],
      ),
    );
  }

  Column _buildNameInfo(Languages language, Profile profile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSecondary('${language.firstName} - ', profile.firstName),
        _buildSecondary('${language.lastName} - ', profile.lastName),
        _buildSecondary('${language.middleName} - ', profile.middleName),
      ],
    );
  }

  Padding _buildCustomInfo(Profile profile) {
    if (Globals.instance.language is LanguageRu) {
      return _buildRu(profile);
    } else if (Globals.instance.language is LanguageEs) {
      return _buildEs(profile);
    }
    return _buildEn(profile);
  }

  Padding _buildRu(Profile profile) {
    var width = MediaQuery.of(context).size.width;

    var language = Globals.instance.language;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.001),
      child: Column(
        children: [
          _buildSecondary('${language.partnerProfiles} - ',
              DateService.fromTimestampToString(profile.partnerDob),
              widthDelta: 0.25),
          _buildSecondary('', '', widthDelta: 0.25),
          _buildSecondary('', '', widthDelta: 0.25),
        ],
      ),
    );
  }

  Padding _buildEs(Profile profile) {
    var width = MediaQuery.of(context).size.width;
    var language = Globals.instance.language;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.001),
      child: Column(
        children: [
          _buildSecondary('${language.coupleDateProfiles} - ',
              DateService.fromTimestampToString(profile.coupleDate),
              widthDelta: 0.25),
          _buildSecondary('', '', widthDelta: 0.25),
          _buildSecondary('', '', widthDelta: 0.25),
        ],
      ),
    );
  }

  Padding _buildEn(Profile profile) {
    var width = MediaQuery.of(context).size.width;
    var language = Globals.instance.language;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.001),
      child: Column(
        children: [
          _buildSecondary('${language.partnerProfiles} - ',
              DateService.fromTimestampToString(profile.partnerDob),
              widthDelta: 0.25),
          _buildSecondary('${language.weddingDateProfiles} - ',
              DateService.fromTimestampToString(profile.weddingDate),
              widthDelta: 0.25),
          _buildSecondary('', '', widthDelta: 0.25),
        ],
      ),
    );
  }

  Column _buildPrimInfo(Profile profile) {
    return Column(
      children: [
        _buildPrimeInfo(Icons.person, profile.profileName),
        _buildPrimeInfo(
            Icons.event, DateService.fromTimestampToString(profile.dob))
      ],
    );
  }

  Widget _buildPrimeInfo(IconData icon, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              value,
              style: profilesWhiteText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondary(String header, String value,
      {double widthDelta = 0.2}) {
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
      ),
      child: Row(
        children: [
          Text(header, style: profilesBlueText),
          SizedBox(
              width: width * widthDelta,
              child: Text(value,
                  overflow: TextOverflow.ellipsis, style: profilesWhiteText)),
        ],
      ),
    );
  }

  Widget _buildLine() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 8.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEditDeleteBtn(Profile profile) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      _buildEdit(profile),
      _buildDelete(profile),
    ]);
  }

  Widget _buildEdit(Profile profile) {
    return CustomButton(
      onPressed: () => navigateToPage(
        context,
        EditProfile(profile: profile),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildCheckbox(Profile profile) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.60, top: height * 0.005),
      child: Checkbox(
          value: profile.isSelected == 1,
          onChanged: (value) async {
            await context.read<ProfilesCubit>().emitSetPrimProfile(profile);
            await context.read<UserDataCubit>().emitPrimaryUserUpdate(profile);
          }),
    );
  }

  Widget _buildDelete(Profile profile) {
    if (_profiles.length <= 1) {
      return Container();
    }
    return CustomButton(
      onPressed: () async {
        bool shouldDelete = await deleteProfileDialog(context, profile);
        if (shouldDelete) {
          if (profile.isSelected == 1) {
            var newPrim = await context
                .read<ProfilesCubit>()
                .emitDeletePrimProfile(profile);
            context.read<UserDataCubit>().emitPrimaryUserUpdate(newPrim);
          } else {
            context.read<ProfilesCubit>().emitDeleteProfile(profile);
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
