import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/services/ads/ad_service.dart';
import 'package:numerology/app/presentation/pages/bottom_navigator/main_page.dart';
import 'package:numerology/app/presentation/pages/description/description_page.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';
import 'package:numerology/app/presentation/pages/graphs/bio_graphs_page.dart';
import 'package:numerology/app/presentation/pages/pay_wall/pay_wall.dart';
import 'package:numerology/app/presentation/pages/welcome/name_settings_page.dart';

void navigateToNameSettings(BuildContext context, int dob) async {
  Navigator.of(context, rootNavigator: true).pop();
  await Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => NameSettingsPage(dob: dob),
    ),
  );
}

void navigateToMainPage(BuildContext context) async {
  Navigator.of(context, rootNavigator: true).pop();
  await Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => MainPage(),
    ),
  );
}

void navigateToPremium(BuildContext context) {
  Navigator.of(context, rootNavigator: true).push(new MaterialPageRoute(
    builder: (BuildContext context) {
      return new PayWall();
    },
  ));
}

Future<void> navigateToBioGraphsPage(BuildContext context) async {
  await AdManager.showInterstitial();
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (context) => BioGraphsPage()));
}

Future<void> navigateToPage(BuildContext context, Widget page) async {
  await AdManager.showInterstitial();
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (context) => page));
}

Future<void> navigateToDescriptionPage(
  BuildContext context,
  String header,
  String calculation,
  List<CardData> description,
) async {
  await AdManager.showInterstitial();
  Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
      builder: (context) => DescriptionPage(
        header: header,
        calculation: calculation,
        data: description,
      )));
}
