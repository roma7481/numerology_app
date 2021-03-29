import 'package:flutter/material.dart';
import 'package:numerology/app/presentation/pages/welcome/name_settings_page.dart';

void navigateToNameSettings(BuildContext context) async {
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (context) => NameSettingsPage()));
}

void navigateToDescription(BuildContext context, Widget page) async {
  Navigator.of(context, rootNavigator: true)
      .push(MaterialPageRoute(builder: (context) => page));
}
