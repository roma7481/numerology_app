import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/localization/language/languages.dart';

import 'empty_content.dart';

Widget errorDialog() {
  Languages language = Globals.instance.getLanguage();
  return EmptyContent(
    title: language.errorMessageHeader,
    message: language.errorMessageContent,
  );
}
