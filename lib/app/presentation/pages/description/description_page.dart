import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/services/ads/native_admob_controller.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';

import 'circle_widget.dart';
import 'matrix_line_data.dart';

class DescriptionPage extends StatelessWidget {
  final String header;
  final String calculation;
  final List<CardData> data;
  final NativeAdmobController adController;

  DescriptionPage(
    this.adController, {
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

  Widget _buildList(List<CardData> data) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var item = data[index];
        return Column(children: [
          showAdInList(adController, data, index),
          buildExpandCard(item.header, item.description, item.iconPath),
        ]);
      },
      childCount: data.length,
    ));
  }
}
