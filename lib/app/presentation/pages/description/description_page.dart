import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'circle_widget.dart';

class DescriptionPage extends StatelessWidget {
  final int calculation;
  final String description;

  DescriptionPage({this.calculation, this.description});

  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Daily Number'),
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
          _buildNumberIcon(context, calculation.toString()),
          _buildDescriptionCard('header', description),
          _buildInfoCard('header', 'info'),
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

  Widget _buildDescriptionCard(String header, String content) {
    return SliverToBoxAdapter(
      child: CustomCard(
          child: CustomCategoryCard(
        header: header,
        content: content,
      )),
    );
  }

  Widget _buildInfoCard(String header, String content) {
    return SliverToBoxAdapter(
      child: CustomCard(
          child: CustomCategoryCard(
        header: header,
        content: content,
      )),
    );
  }
}
