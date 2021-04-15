import 'package:flutter/cupertino.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';

void showYesNoDialog(BuildContext context, Function onYes) {
  var language = Globals.instance.getLanguage();
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: new Text(language.applyProfile),
      content: new Text(language.setProfileAsPrimary),
      actions: <Widget>[
        CupertinoDialogAction(
          onPressed: () => onYes(),
          child: Text(language.yes),
        ),
        CupertinoDialogAction(
          onPressed: () {},
          child: Text(language.no),
        )
      ],
    ),
  );
}
