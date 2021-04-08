import 'package:flutter/material.dart';
import 'package:numerology/app/presentation/pages/bottom_navigator/main_page.dart';
import 'package:numerology/app/presentation/pages/graphs/bio_graphs_page.dart';
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

void navigateToBioGraphsPage(BuildContext context) async {
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (context) => BioGraphsPage()));
}

void navigateToDescription(BuildContext context, Widget page) async {
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (context) => page));
}
