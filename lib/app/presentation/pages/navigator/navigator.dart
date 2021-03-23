import 'package:flutter/material.dart';
import 'package:numerology/app/presentation/pages/welcome_page/name_settings_page.dart';

void navigateToNameSettings(BuildContext context) async {
  Navigator.of(context, rootNavigator: true).pop();
  await Navigator.push(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => NameSettingsPage(),
    ),
  );
}
