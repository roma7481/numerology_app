import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/data/models/profile.dart';

Future<bool?> deleteProfileDialog(BuildContext context, Profile profile) async {
  var language = Globals.instance.getLanguage();
  return showDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: new Text(language.deleteProfile),
      content: new Text(language.doYouWantToDelete),
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
}
