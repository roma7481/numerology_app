import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_en.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_es.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_ru.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/language/data_parser_en.dart';
import 'package:numerology/app/data/language/data_parser_es.dart';
import 'package:numerology/app/data/language/data_parser_ru.dart';

import 'language/language_en.dart';
import 'language/language_es.dart';
import 'language/language_ru.dart';
import 'language/languages.dart';

class LanguageItem {
  LanguageItem(
    this.locale,
    this.languageName,
  );

  final String locale;
  final String languageName;
}

class LocaleUtils {
  static bool containsVowels(String text) {
    String vowels = "aeiouAEIOUаэыуояеёюиАЭЫУОЯЕЁЮИ";

    for (int i = 0; i < text.length; i++) {
      var char = text[i];
      if (vowels.contains(char)) {
        return true;
      }
    }
    return false;
  }

  static List<TextInputFormatter> keyboardInputFormatter() {
    /// Need to add a keyboard formatter for every language we add ///
    var formatter = new FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z]+|[А-Яа-я]+|[Ñ]+|[ñ]+|\s"));
    return [formatter];
  }

  static List<TextInputFormatter> keyboardInputFormatterWithNumbers() {
    /// Need to add a keyboard formatter for every language we add ///
    var formatter = new FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z0-9]+|[А-Яа-я0-9]+|[Ñ0-9]+|[ñ0-9]+|\s"));
    return [formatter];
  }

  static Map<int, LanguageItem> allLanguages = {
    0: LanguageItem(en, english),
    1: LanguageItem(ru, russian),
    2: LanguageItem(es, spanish),
  };

  static ForecastCalcUtils getForecastUtils(String localeCode) {
    switch (localeCode) {
      case en:
        return CalcUtilsEn();
      case ru:
        return CalcUtilsRu();
      case es:
        return CalcUtilsEs();
      default:
        return CalcUtilsEn();
    }
  }

  static Languages selectLanguage(String localeCode) {
    switch (localeCode) {
      case en:
        return LanguageEn();
      case ru:
        return LanguageRu();
      case es:
        return LanguageEs();
      default:
        return LanguageEn();
    }
  }

  static LocaleType getTimePickerLocale(String localeCode) {
    switch (localeCode) {
      case en:
        return LocaleType.en;
        break;
      case ru:
        return LocaleType.ru;
        break;
      case es:
        return LocaleType.es;
        break;
      default:
        return LocaleType.en;
    }
  }

  static DataParser getDataParser(String localeCode) {
    switch (localeCode) {
      case en:
        return DataParserEn();
        break;
      case ru:
        return DataParserRu();
        break;
      case es:
        return DataParserEs();
        break;
      default:
        return DataParserEn();
    }
  }
}
