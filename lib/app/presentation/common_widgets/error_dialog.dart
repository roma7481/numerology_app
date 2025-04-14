import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';

import 'empty_content.dart';

Widget errorDialog() {
  final language = Globals.instance.getLanguage();

  return EmptyContent(
    title: language.errorMessageHeader,
    message: language.errorMessageContent,
  );
}

