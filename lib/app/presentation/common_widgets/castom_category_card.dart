import 'package:flutter/material.dart';
import 'package:numerology/app/constants/text_styles.dart';

class CustomCategoryCard extends StatelessWidget {
  CustomCategoryCard({
    @required this.header,
    @required this.content,
    @required this.icon,
  });

  final String header;
  final String content;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(),
        _buildContent(context),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _buildCardContent(context)),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Text(
      content,
      style: descriptionContentStyle,
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 8.0,
      ),
      child: Text(
        header,
        style: descriptionHeaderStyle,
      ),
    );
  }
}
