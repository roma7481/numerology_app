import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/data/models/profile.dart';

import 'graph_widget.dart';

class BioGraphsPage extends StatelessWidget {
  final Profile profile;

  const BioGraphsPage({Key key, this.profile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(builder: (context, state) {
      return _buildPageContent(context);
    });
  }

  Widget _buildPageContent(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _buildContent(context),
    ));
  }

  Widget _buildContent(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: GraphWidget(
              profile: profile,
            ),
          )
        ],
      ),
    );
  }
}
