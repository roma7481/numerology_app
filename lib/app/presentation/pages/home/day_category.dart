import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/text_styles.dart';

import 'custom_raised_button.dart';

Widget buildDayCategory({
  @required String header,
  @required Function onPressed,
  @required String imagePath,
  @required content,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: CustomButton(
        onPressed: onPressed,
        child: Container(
          height: 200,
          child: Stack(
            children: [
              Column(
                children: [
                  _buildHeader(header),
                  _buildContent(content),
                ],
              ),
              _buildIcon(),
              _buildReadMore(),
              _buildImage(imagePath),
            ],
          ),
        )),
  );
}

Widget _buildIcon() {
  return Align(
    alignment: Alignment.topRight,
    child: Padding(
      padding: const EdgeInsets.only(top: 16.0, right: 8.0),
      child: IconTheme(
        data: new IconThemeData(color: Colors.white),
        child: Icon(
          Icons.keyboard_arrow_right,
        ),
      ),
    ),
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

Widget _buildContent(content) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
    child: Text(
      content,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: personalDayText,
    ),
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
  return Center(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        header,
        style: descriptionHeaderStyle,
      ),
    ),
  );
}
