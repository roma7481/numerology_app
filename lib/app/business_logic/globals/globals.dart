library app.globals;

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/localization/language/language_en.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/localization/locale_utils.dart';

class Globals {
  Globals._({
    this.language = const LanguageEn(),
    this.localeType = LocaleType.en,
  });

  static final instance = Globals._();

  Languages language;
  LocaleType localeType;

  void setLocale({@required String localeCode}) {
    this.language = LocaleUtils.selectLanguage(localeCode);
    this.localeType = LocaleUtils.getTimePickerLocale(localeCode);
  }

  Languages getLanguage() {
    return this.language;
  }

  LocaleType getLocaleType() {
    return this.localeType;
  }
}
