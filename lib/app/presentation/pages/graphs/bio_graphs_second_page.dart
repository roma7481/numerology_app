import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';
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
    return BlocBuilder<BioSecondCubit, BioSecondState>(
        builder: (context, state) {
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
}
