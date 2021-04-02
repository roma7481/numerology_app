import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/data/language/matrix_tile.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'matrix_line_data.dart';

class MatrixLinesPage extends StatelessWidget {
  final String header;
  final String calculation;
  final List<MatrixLineData> description;

  const MatrixLinesPage({
    Key key,
    this.header = '',
    this.calculation = '',
    this.description = const [],
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
          _buildMatrix(context),
          _buildList(),
          // SliverList(delegate: _buildList(description))
        ],
      ),
    );
  }

  Widget _buildMatrix(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context),
                _buildMatrixTile(context),
                _buildMatrixTile(context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context),
                _buildMatrixTile(context),
                _buildMatrixTile(context),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context),
                _buildMatrixTile(context),
                _buildMatrixTile(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixTile(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var sideLength = height * 0.1;
    return buildMatrixTileButton(
      '9999',
      () {},
      sideLength,
    );
  }

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = description[index];
        return _buildCard(data.header, data.description);
      },
      childCount: description.length,
    ));
  }

  Widget _buildCard(String header, String content) {
    if (content.length > 1000) {
      return CustomCard(
          child: ExpandablePanel(
        theme: ExpandableThemeData(iconColor: Colors.white),
        header: _buildHeader(header),
        collapsed: _buildCardContent(content: content, isFolded: true),
        expanded: _buildCardContent(
          content: content,
        ),
      ));
    } else {
      return CustomCard(
          child: CustomCategoryCard(
        header: header,
        content: content,
      ));
    }
  }

  Widget _buildHeader(String header) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 48.0,
        ),
        child: Text(
          header,
          style: descriptionHeaderStyle,
        ),
      ),
    );
  }

  Widget _buildCardContent({String content, bool isFolded = false}) {
    if (isFolded) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          content,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: descriptionContentStyle,
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        content,
        style: descriptionContentStyle,
      ),
    );
  }
}
