import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'custom_raised_button.dart';

Widget buildDayCategory({
  @required String text,
  @required Function onPressed,
  @required String imagePath,
  content,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: CustomButton(
        onPressed: onPressed,
        child: Container(
          height: 220,
          child: Stack(
            children: [
              CustomCard(
                child: Column(
                  children: [
                    _buildHeader(text),
                    _buildContent(content),
                  ],
                ),
              ),
              _buildReadMore(),
              _buildImage(imagePath),
            ],
          ),
        )),
  );
}

Widget _buildReadMore() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Align(
      alignment: Alignment.bottomLeft,
      child: Text(
        Globals.instance.language.readMore,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: personalDayText,
      ),
    ),
  );
}

Text _buildContent(content) {
  return Text(
    content,
    maxLines: 3,
    overflow: TextOverflow.ellipsis,
    style: personalDayText,
  );
}

Widget _buildImage(String imagePath) {
  return Positioned(
    bottom: -5.0,
    right: -1.0,
    child: SvgPicture.asset(
      imagePath,
      height: 70.0,
    ),
  );
}

Widget _buildHeader(String header) {
  return Padding(
    padding: const EdgeInsets.only(
      top: 16.0,
      left: 8.0,
      bottom: 8.0,
    ),
    child: Text(
      header,
      style: descriptionHeaderStyle,
    ),
  );
}
