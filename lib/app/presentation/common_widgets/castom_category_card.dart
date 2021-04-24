import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/constants/text_styles.dart';

class CustomCategoryCard extends StatelessWidget {
  CustomCategoryCard({
    @required this.header,
    @required this.content,
    this.iconPath,
  });

  final String header;
  final String content;
  final String iconPath;

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
          padding: const EdgeInsets.all(16.0),
          child: _buildCardContent(context)),
    );
  }

  Widget _buildCardContent(BuildContext context) {
    return Text(
      content,
      style: descriptionContentStyle(),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        left: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildIcon(),
          Text(
            header,
            style: descriptionHeaderStyle,
          ),
          Opacity(opacity: 0.0, child: _buildIcon()),
        ],
      ),
    );
  }

  Widget _buildIcon() {
    return iconPath != null
        ? SvgPicture.asset(iconPath, height: 20.0)
        : Container();
  }
}
