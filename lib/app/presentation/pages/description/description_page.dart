import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';

import 'circle_widget.dart';
import 'matrix_line_data.dart';

class DescriptionPage extends StatelessWidget {
  final String header;
  final String calculation;
  final List<CardData> data;

  DescriptionPage({
    this.calculation = '',
    this.header = '',
    this.data = const [],
  });

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text(header), brightness: Brightness.dark),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildNumberIcon(context, calculation),
          _buildList(data),
        ],
      ),
    );
  }

  Widget _buildNumberIcon(BuildContext context, String calculation) {
    if (calculation.isEmpty) {
      return SliverToBoxAdapter(child: Container());
    }
    return SliverToBoxAdapter(
      child: Container(
        width: 400,
        height: 200,
        child: CustomPaint(
          painter: OpenPainter(context, calculation),
        ),
      ),
    );
  }

  Widget _buildCard(String header, String content) {
    if (content.length > 1000) {
      return CustomCard(
          child: ExpandablePanel(
        theme: ExpandableThemeData(iconColor: arrowColor),
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

  Widget _buildList(List<CardData> dataList) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var data = dataList[index];
        return buildExpandCard(data.header, data.description, data.iconPath);
      },
      childCount: dataList.length,
    ));
  }
}
