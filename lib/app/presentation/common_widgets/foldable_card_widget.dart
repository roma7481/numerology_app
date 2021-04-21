import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'castom_category_card.dart';

Widget buildExpandCard(String header, String content, String iconPath) {
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
          iconPath != null
              ? SvgPicture.asset(iconPath, height: 20.0)
              : Container(),
          Text(
            header,
            style: descriptionHeaderStyle,
          ),
          Opacity(
              opacity: 0.0,
              child: iconPath != null
                  ? SvgPicture.asset(iconPath, height: 20.0)
                  : Container()),
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
