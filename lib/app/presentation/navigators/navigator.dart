import 'package:flutter/material.dart';
import 'package:numerology/app/presentation/pages/bottom_navigator/main_page.dart';
import 'package:numerology/app/presentation/pages/welcome_page/text_input_tile.dart';

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
