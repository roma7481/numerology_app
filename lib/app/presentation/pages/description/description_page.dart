import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/castom_category_card.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'circle_widget.dart';

class DescriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          _buildNumberIcon(context),
          _buildDescriptionCard(),
        ],
      ),
    );
  }

  Widget _buildNumberIcon(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: 400,
        height: 200,
        child: CustomPaint(
          painter: OpenPainter(context, '11'),
        ),
      ),
    );
  }

  Widget _buildDescriptionCard() {
    return SliverToBoxAdapter(
      child: CustomCard(
          child: CustomCategoryCard(
        header: 'wew',
        content: 'weqewqewq',
        icon: null,
      )),
    );
  }
}
