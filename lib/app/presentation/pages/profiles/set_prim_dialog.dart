import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';

Future<bool> showProfileDialog(BuildContext context) async {
  var language = Globals.instance.getLanguage();
  bool setAsPrim = await showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: new Text(language.applyProfile),
      content: new Text(language.setProfileAsPrimary),
      actions: <Widget>[
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: () => Navigator.pop(context, true),
          child: Text(language.yes),
        ),
        CupertinoDialogAction(
          onPressed: () => Navigator.pop(context, false),
          child: Text(language.no),
        )
      ],
    ),
  );
  return setAsPrim;
}
