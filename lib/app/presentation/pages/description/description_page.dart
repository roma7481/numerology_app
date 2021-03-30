import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'circle_widget.dart';

class DescriptionPage extends StatelessWidget {
  final String header;
  final String calculation;
  final Map<String, String> cards;

  DescriptionPage({
    this.calculation = '1',
    this.header = '',
    this.cards = const {},
  });

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
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [
          _buildNumberIcon(context, calculation),
          SliverList(delegate: _buildList(cards))
        ],
      ),
    );
  }

  Widget _buildNumberIcon(BuildContext context, String calculation) {
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
    return CustomCard(
        child: CustomCategoryCard(
      header: header,
      content: content,
    ));
  }

  SliverChildDelegate _buildList(Map<String, String> cards) {
    return SliverChildBuilderDelegate(
      (context, index) {
        var card = cards.entries.toList()[index];
        return _buildCard(card.key, card.value);
      },
      childCount: cards.length,
    );
  }
}
