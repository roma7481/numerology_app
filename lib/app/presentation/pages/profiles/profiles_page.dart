import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';
import 'package:numerology/app/presentation/pages/home/custom_raised_button.dart';

import 'edit_profile_en.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  List<Profile> _profiles = [];

  @override
  Widget build(BuildContext context) {
    context.read<ProfilesCubit>().emitGetProfiles();
    return BlocBuilder<ProfilesCubit, ProfilesState>(builder: (context, state) {
      if (state is ProfilesReady) {
        _profiles = state.profiles;
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
    );
  }

  Widget _buildPageBody() {
    var mainProfile =
        _profiles.firstWhere((profile) => profile.isSelected == 1);
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [_buildProfile(mainProfile)],
      ),
    );
  }

  Widget _buildProfile(Profile profile) {
    var width = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            children: [
              Stack(children: [_buildPrimInfo(profile), _buildCheckbox()]),
              _buildSecondaryInfo(profile, width),
              _buildLine(),
              _buildEditBtn(profile),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildSecondaryInfo(Profile profile, double width) {
    var language = Globals.instance.language;
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSecondary('${language.firstName} - ', profile.firstName),
              _buildSecondary('${language.lastName} - ', profile.lastName),
              _buildSecondary('${language.middleName} - ', profile.middleName),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.05),
            child: Column(
              children: [
                _buildSecondary('Partner - ',
                    DateService.fromTimestampToString(profile.partnerDob),
                    widthDelta: 0.25),
                _buildSecondary('W.Date - ',
                    DateService.fromTimestampToString(profile.weddingDate),
                    widthDelta: 0.25),
                _buildSecondary('', '', widthDelta: 0.25),
              ],
            ),
          )
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

  Widget _buildEditBtn(Profile profile) {
    return CustomButton(
      onPressed: () => navigateToPage(
        context,
        EditProfileEn(profile: profile),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
        child: Row(
          children: [
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.78),
      child: Checkbox(value: true, onChanged: (value) {}),
    );
  }
}
