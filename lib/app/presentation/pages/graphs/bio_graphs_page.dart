import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';

import 'bio_pi_charts.dart';
import 'graph_widget.dart';

class BioGraphsPage extends StatefulWidget {
  const BioGraphsPage({Key key}) : super(key: key);

  @override
  _BioGraphsPageState createState() => _BioGraphsPageState();
}

class _BioGraphsPageState extends State<BioGraphsPage> {
  Profile profile;
  var header = DateService.getFormattedDate(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        profile = state.profile;
      } else if (state is UserDataLoading) {
        showCupertinoProgressBar();
      }
      return _buildPageContent(context);
    });
  }

  Widget _buildPageContent(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: _buildHeader(),
      ),
      body: _buildContent(context),
    ));
  }

  Widget _buildHeader() {
    return BlocBuilder<BioCubit, BioState>(builder: (context, state) {
      header =
          DateService.getFormattedDate(DateService.fromTimestamp(state.date));
      return Text(header);
    });
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildGraphs(),
          _buildPiCharts(),
          _buildList(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildGraphs() {
    return SliverToBoxAdapter(
      child: GraphWidget(
        profile: profile,
      ),
    );
  }

  _buildPiCharts() {
    return BlocBuilder<BioCubit, BioState>(builder: (context, state) {
      return SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.only(top: 24.0),
          child: CustomCard(
            child: buildBioPiCharts(
                context,
                [
                  state.bio[0],
                  state.bio[1],
                  state.bio[2],
                ],
                isHeaderVisible: false),
          ),
        ),
      );
    });
  }

  Widget _buildList() {
    return BlocBuilder<BioCubit, BioState>(builder: (context, state) {
      return SliverList(
          delegate: SliverChildBuilderDelegate(
        (context, index) {
          var data = state.description[index];
          return buildExpandCard(data.header, data.description, data.iconPath);
        },
        childCount: state.description.length,
      ));
    });
  }
}
