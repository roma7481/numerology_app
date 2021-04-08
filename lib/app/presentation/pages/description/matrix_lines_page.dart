import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';

import 'matrix_line_data.dart';
import 'matrix_utils.dart';

class MatrixLinesPage extends StatelessWidget {
  final String header;
  final String calculation;
  final List<CardData> description;
  final List<int> matrix;
  final Map<String, String> info;

  const MatrixLinesPage({
    Key key,
    this.header = '',
    this.calculation = '',
    this.description = const [],
    this.matrix = const [],
    this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(header),
        backgroundColor: backgroundColor,
      ),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
      width: double.infinity,
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: buildMatrix(context, matrix)),
          _buildList(),
          _buildInfo(),
        ],
      ),
    );
  }

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = description[index];
        return buildExpandCard(data.header, data.description, data.iconPath);
      },
      childCount: description.length,
    ));
  }

  Widget _buildInfo() {
    return SliverToBoxAdapter(
      child: CustomCard(
        child: CustomCategoryCard(
          header: info.keys.first,
          content: info.values.first,
        ),
      ),
    );
  }
}
