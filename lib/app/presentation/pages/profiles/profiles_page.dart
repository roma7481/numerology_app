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
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        profile.profileName,
                        style: profilesWhiteText,
                      ),
                    ),
                    _buildCheckbox(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Row(
                  children: [
                    Icon(Icons.event, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        DateService.getFormattedDate(
                            DateService.fromTimestamp(profile.dob)),
                        style: profilesWhiteText,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSecondaryInfo('F.Name - ', profile.firstName),
                      _buildSecondaryInfo('L.Name - ', profile.lastName),
                      _buildSecondaryInfo('M.Name - ', profile.middleName),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.05),
                    child: Column(
                      children: [
                        _buildSecondaryInfo('Partner - ', 'profile.partnerDob',
                            widthDelta: 0.25),
                        _buildSecondaryInfo('W.Date - ', '', widthDelta: 0.25),
                        _buildSecondaryInfo('', '', widthDelta: 0.25),
                      ],
                    ),
                  )
                ],
              ),
              _buildLine(),
              _buildEditBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryInfo(String header, String value,
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
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.90,
        color: Colors.white,
      ),
    );
  }

  Widget _buildEditBtn() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
      child: Row(
        children: [
          Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildCheckbox() {
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width * 0.55),
      child: Checkbox(value: true, onChanged: (value) {}),
    );
  }
}
