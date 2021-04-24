library app.globals;

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_en.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/language/data_parser_en.dart';
import 'package:numerology/app/localization/language/language_en.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/localization/locale_utils.dart';

class Globals {
  Globals._(
      {this.language = const LanguageEn(),
      this.textSize = 18.0,
      this.localeType = LocaleType.en,
      this.dataParser = const DataParserEn(),
      this.forecastCalcUtils = const CalcUtilsEn(),
      this.localeCode = 'en'});

  static final instance = Globals._();

  double textSize;
  Languages language;
  LocaleType localeType;
  DataParser dataParser;
  ForecastCalcUtils forecastCalcUtils;
  String localeCode;

  void setLocale({@required String localeCode}) {
    this.localeCode = localeCode;
    this.language = LocaleUtils.selectLanguage(localeCode);
    this.localeType = LocaleUtils.getTimePickerLocale(localeCode);
    this.dataParser = LocaleUtils.getDataParser(localeCode);
    this.forecastCalcUtils = LocaleUtils.getForecastUtils(localeCode);
  }

  String getLocale() {
    return localeCode;
  }

  ForecastCalcUtils getForecastUtils() {
    return this.forecastCalcUtils;
  }

  Languages getLanguage() {
    return this.language;
  }

  LocaleType getLocaleType() {
    return this.localeType;
  }

  DataParser getDataParser() {
    return this.dataParser;
  }

  void setTextSize({@required double textSize}) {
    this.textSize = textSize;
  }

  double getTextSize() {
    return textSize;
  }
}
