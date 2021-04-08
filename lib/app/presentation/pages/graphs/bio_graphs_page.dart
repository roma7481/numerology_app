import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';

import 'bio_pi_charts.dart';
import 'graph_widget.dart';

class BioGraphsPage extends StatefulWidget {
  final Profile profile;

  const BioGraphsPage({Key key, this.profile}) : super(key: key);

  @override
  _BioGraphsPageState createState() => _BioGraphsPageState();
}

class _BioGraphsPageState extends State<BioGraphsPage> {
  var header = DateService.getFormattedDate(DateTime.now());

  @override
  Widget build(BuildContext context) {
    context.read<BioCubit>().emitBioInit(widget.profile);
    return BlocBuilder<BioCubit, BioState>(builder: (context, state) {
      header =
          DateService.getFormattedDate(DateService.fromTimestamp(state.date));
      return _buildPageContent(context, state);
    });
  }

  Widget _buildPageContent(BuildContext context, BioState state) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: Text(header),
      ),
      body: _buildContent(context, state),
    ));
  }

  Widget _buildContent(BuildContext context, BioState state) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildGraphs(),
          _buildPiCharts(state),
          _buildList(state.description)
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildGraphs() {
    return SliverToBoxAdapter(
      child: GraphWidget(
        profile: widget.profile,
      ),
    );
  }

  _buildPiCharts(BioState state) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: CustomCard(
          child: buildBioPiCharts(
              context,
              [
                state.physical,
                state.emotional,
                state.intel,
              ],
              isHeaderVisible: false),
        ),
      ),
    );
  }

  Widget _buildList(List<CardData> description) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = description[index];
        return buildExpandCard(data.header, data.description, data.iconPath);
      },
      childCount: description.length,
    ));
  }
}
