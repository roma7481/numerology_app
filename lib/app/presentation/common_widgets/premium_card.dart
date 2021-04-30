import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/card_header.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';

Widget buildPremiumCard(
  BuildContext context,
  String header,
  String description,
  String iconPath,
) {
  return CustomCard(
    child: _customButton(
        onPressed: () => navigateToPremium(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildHeader(header, iconPath),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: Text(description,
                  maxLines: 2,
                  style: descriptionContentStyle(),
                  overflow: TextOverflow.ellipsis),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Text(Globals.instance.language.readMorePremium,
                  textAlign: TextAlign.start, style: readMoreStyle),
            ),
          ],
        )),
  );
}

Widget _customButton({Widget child, VoidCallback onPressed}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: GestureDetector(
      onTap: onPressed,
      child: Container(
        child: child,
      ),
    ),
  );
}
