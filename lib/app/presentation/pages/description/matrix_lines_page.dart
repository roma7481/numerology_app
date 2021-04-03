import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          _buildMatrix(context),
          _buildList(),
          _buildInfo(),
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
                _buildMatrixTile(context, matrix[0]),
                _buildMatrixTile(context, matrix[3]),
                _buildMatrixTile(context, matrix[6]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context, matrix[1]),
                _buildMatrixTile(context, matrix[4]),
                _buildMatrixTile(context, matrix[7]),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildMatrixTile(context, matrix[2]),
                _buildMatrixTile(context, matrix[5]),
                _buildMatrixTile(context, matrix[8]),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMatrixTile(BuildContext context, int lineSum) {
    var height = MediaQuery.of(context).size.height;
    var sideLength = height * 0.1;
    return buildMatrixTileButton(
      lineSum.toString().replaceAll('0', '-'),
      () {},
      sideLength,
    );
  }

  Widget _buildList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = description[index];
        return _buildCard(data.header, data.description, data.iconPath);
      },
      childCount: description.length,
    ));
  }

  Widget _buildCard(String header, String content, String iconPath) {
    if (content.length > 1000) {
      return CustomCard(
          child: ExpandablePanel(
        theme: ExpandableThemeData(iconColor: arrowColor),
        header: _buildHeader(header, iconPath),
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
        iconPath: iconPath,
      ));
    }
  }

  Widget _buildHeader(String header, String iconPath) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 24.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(iconPath, height: 20.0),
            Text(
              header,
              style: descriptionHeaderStyle,
            ),
            Opacity(
                opacity: 0.0, child: SvgPicture.asset(iconPath, height: 20.0)),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent({String content, bool isFolded = false}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(content,
          maxLines: isFolded ? 4 : 2000,
          style: descriptionContentStyle,
          overflow: isFolded ? TextOverflow.ellipsis : TextOverflow.visible),
    );
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
