import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/services/ads/native_admob_controller.dart';
import 'package:numerology/app/business_logic/services/ads/show_banner.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';

import 'bio_pi_charts_second.dart';
import 'graph_widget.dart';

class BioGraphsSecondPage extends StatefulWidget {
  final NativeAdmobController adController;

  const BioGraphsSecondPage(this.adController);

  @override
  _BioGraphsSecondPageState createState() => _BioGraphsSecondPageState();
}

class _BioGraphsSecondPageState extends State<BioGraphsSecondPage> {
  final NativeAdmobController adController = NativeAdmobController();

  Profile profile;
  var header = DateService.getFormattedDate(DateTime.now());

  BannerAd _banner;
  AdWidget _adWidget;

  @override
  Widget build(BuildContext context) {
    _banner = getBanner();
    _banner.load();
    _adWidget = AdWidget(ad: _banner);

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
    return BlocBuilder<BioSecondCubit, BioSecondState>(
        builder: (context, state) {
      if (state is BioSecondStateReady) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            brightness: Brightness.dark,
            title: _buildHeader(state),
          ),
          body: _buildContent(context, state),
        ));
      } else if (state is BioSecondStateError) {
        return errorDialog();
      }
      return progressBar();
    });
  }

  Widget _buildHeader(BioSecondStateReady state) {
    header =
        DateService.getFormattedDate(DateService.fromTimestamp(state.date));
    return Text(header);
  }

  Widget _buildContent(BuildContext context, BioSecondStateReady state) {
    var listHeight = calcListHeight(context, _banner);

    return Container(
      color: backgroundColor,
      child: Column(
        children: [
          SizedBox(
            height: listHeight,
            child: CustomScrollView(
              slivers: [
                _buildGraphs(),
                _buildPiCharts(state),
                _buildList(state),
              ],
            ),
          ),
          showBanner(_adWidget, _banner),
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

  Widget _buildPiCharts(BioSecondStateReady state) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: buildBioPiChartsSecond(
          context,
          state.bio,
        ),
      ),
    );
  }

  Widget _buildList(BioSecondStateReady state) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = state.description[index];
        return Column(
          children: [
            showAdInList(adController, state.description, index),
            buildExpandCard(data.header, data.description, data.iconPath),
          ],
        );
      },
      childCount: state.description.length,
    ));
  }
}
