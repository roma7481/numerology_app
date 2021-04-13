import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

class ProfilesPage extends StatefulWidget {
  @override
  _ProfilesPageState createState() => _ProfilesPageState();
}

class _ProfilesPageState extends State<ProfilesPage> {
  @override
  Widget build(BuildContext context) {
    return _buildContent();
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
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [_buildProfile()],
      ),
    );
  }

  Widget _buildProfile() {
    var width = MediaQuery.of(context).size.width;

    return SliverToBoxAdapter(
      child: CustomCard(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'Profile1',
                        style: profilesWhiteText,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.event, color: Colors.white),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        'May 29, 1989',
                        style: profilesWhiteText,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          'L.Name - ',
                          style: profilesBlueText,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('F.Name - ', style: profilesBlueText),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Text('M.Name - ', style: profilesBlueText),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.4),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Text(
                            'Partner - ',
                            style: profilesBlueText,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('W.Date - ', style: profilesBlueText),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: Text('', style: profilesBlueText),
                        ),
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
      padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
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
}
