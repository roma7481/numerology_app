import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/services/ads/show_banner.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/common_widgets/list_space_tile.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';

import 'bio_pi_charts_second.dart';
import 'graph_widget.dart';

class BioGraphsSecondPage extends StatefulWidget {

  @override
  _BioGraphsSecondPageState createState() => _BioGraphsSecondPageState();
}

class _BioGraphsSecondPageState extends State<BioGraphsSecondPage> {

  Profile profile;
  var header = DateService.getFormattedDate(DateTime.now());

  BannerAd _banner;
  AdWidget _adWidget;

  @override
  Widget build(BuildContext context) {
    _banner = getBanner();
    _adWidget = _banner == null ? null : AdWidget(ad: _banner);

    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        profile = state.profile;
        context.read<BioSecondCubit>().emitBioInit(profile);
      } else if (state is UserDataLoading) {
        showCupertinoProgressBar();
      }
      return _buildPageContent(context);
    });
  }

  Widget _buildPageContent(BuildContext context) {
    return FutureBuilder<bool>(
        future: PremiumController.instance.isAdsFree(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return progressBar();
            default:
              if (snapshot.hasError) {
                return SliverToBoxAdapter(
                  child: errorDialog(),
                );
              } else {
                var isPremium = snapshot.data;
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    brightness: Brightness.dark,
                    title: _buildHeader(),
                  ),
                  body: _buildContent(context, isPremium),
                  bottomNavigationBar:
                      showBanner(_adWidget, _banner, isPremium),
                );
              }
          }
        });
  }

  Widget _buildHeader() {
    return BlocBuilder<BioSecondCubit, BioSecondState>(
        builder: (context, state) {
      header =
          DateService.getFormattedDate(DateService.fromTimestamp(state.date));
      return Text(header);
    });
  }

  Container _buildContent(BuildContext context, bool isPremium) {
    var listHeight = calcListHeight(context, _banner, isPremium);
    return Container(
      color: backgroundColor,
      child: Wrap(
        children: [
          Column(
            children: [
              SizedBox(
                height: listHeight,
                child: CustomScrollView(
                  slivers: [
                    _buildGraphs(),
                    _buildPiCharts(),
                    _buildList(isPremium),
                    buildSpaceBox(context),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildGraphs() {
    return SliverToBoxAdapter(
      child: GraphWidget(
        profile: profile,
        isPrimaryBioGraph: false,
      ),
    );
  }

  Widget _buildPiCharts() {
    return BlocBuilder<BioSecondCubit, BioSecondState>(
        builder: (context, state) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: buildBioPiChartsSecond(
            context,
            state.bio,
          ),
        ),
      );
    });
  }

  Widget _buildList(bool isPremium) {
    return BlocBuilder<BioSecondCubit, BioSecondState>(
        builder: (context, state) {
      return SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          var data = state.description[index];
          return Column(
            children: [
              showAdInList(state.description, index, isPremium),
              ExpandableTile(data.header, data.description,
                  iconPath: data.iconPath),
            ],
          );
        },
        childCount: state.description.length,
      ));
    });
  }
}
