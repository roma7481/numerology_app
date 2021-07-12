import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_en.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_es.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_fr.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_pt.dart';
import 'package:numerology/app/business_logic/cubit/forecast/calc_utils_ru.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/language/data_parser_en.dart';
import 'package:numerology/app/data/language/data_parser_es.dart';
import 'package:numerology/app/data/language/data_parser_fr.dart';
import 'package:numerology/app/data/language/data_parser_pt.dart';
import 'package:numerology/app/data/language/data_parser_ru.dart';

import 'language/language_en.dart';
import 'language/language_es.dart';
import 'language/language_fr.dart';
import 'language/language_pt.dart';
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

  static bool containsNonVowels(String text) {
    String vowels = "aeiouAEIOUаэыуояеёюиАЭЫУОЯЕЁЮИàáãâéêíóôõúüéàèùâêîôûäëüçïœÿ";

    for (int i = 0; i < text.length; i++) {
      var char = text[i];
      if (!vowels.contains(char.toLowerCase())) {
        return true;
      }
    }
    return false;
  }

  static List<TextInputFormatter> keyboardInputFormatter() {
    /// Need to add a keyboard formatter for every language we add ///
    var formatter = new FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z]+|[А-Яа-я]+|[Ñ]+|[ñ]+"
        r"|[é]+|[à]+|[è]+|[ù]+|[â]+|[ê]+|[î]+|[ô]+|[û]+|[ä]+|[ë]+|[ü]+|[ç]+|[ï]+|[œ]+|[ÿ]+" //FR
        r"|[à]+|[á]+|[ã]+|[â]+|[é]+|[ê]+|[í]+|[ó]+|[ô]+|[õ]+|[ú]+|[ü]+|[ç]+" //ES
        r"|[À]+|[Á]+|[Ã]+|[Â]+|[É]+|[Ê]+|[Í]+|[Ó]+|[Ô]+|[Õ]+|[Ú]+|[Ü]+|[Ç]+|\s"));
    return [formatter];
  }

  static List<TextInputFormatter> keyboardInputFormatterWithNumbers() {
    /// Need to add a keyboard formatter for every language we add ///
    var formatter = new FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z0-9]+|[А-Яа-я0-9]+|[Ñ0-9]+|[ñ0-9]+"
        r"|[é0-9]+|[à0-9]+|[è0-9]+|[ù0-9]+|[â0-9]+|[ê0-9]+|[î0-9]+|[ô0-9]+|[û0-9]+|[ä0-9]+|[ë0-9]+|[ü0-9]+|[ç0-9]+|[ï0-9]+|[œ0-9]+|[ÿ0-9]+" //FR
        r"|[É0-9]+|[À0-9]+|[È0-9]+|[Ù0-9]+|[Â0-9]+|[Ê0-9]+|[Î0-9]+|[Ô0-9]+|[Û0-9]+|[Ä0-9]+|[Ë0-9]+|[Ü0-9]+|[Ç0-9]+|[Ï0-9]+|[Œ0-9]+|[Ÿ0-9]+" //FR capitalized
        r"|[à0-9]+|[á0-9]+|[ã0-9]+|[â0-9]+|[é0-9]+|[ê0-9]+|[í0-9]+|[ó0-9]+|[ô0-9]+|[õ0-9]+|[ú0-9]+|[ü0-9]+|[ç0-9]+" //ES
        r"|[À0-9]+|[Á0-9]+|[Ã0-9]+|[Â0-9]+|[É0-9]+|[Ê0-9]+|[Í0-9]+|[Ó0-9]+|[Ô0-9]+|[Õ0-9]+|[Ú0-9]+|[Ü0-9]+|[Ç0-9]+|\s"));
    return [formatter];
  }

  static Map<int, LanguageItem> allLanguages = {
    0: LanguageItem(en, english),
    1: LanguageItem(ru, russian),
    2: LanguageItem(es, spanish),
    3: LanguageItem(pt, portuguese),
    4: LanguageItem(fr, french),
  };

  static ForecastCalcUtils getForecastUtils(String localeCode) {
    switch (localeCode) {
      case en:
        return CalcUtilsEn();
      case ru:
        return CalcUtilsRu();
      case es:
        return CalcUtilsEs();
      case pt:
        return CalcUtilsPt();
      case fr:
        return CalcUtilsFr();
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
      case pt:
        return LanguagePt();
      case fr:
        return LanguageFr();
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
      case pt:
        return LocaleType.pt;
        break;
      case fr:
        return LocaleType.fr;
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
      case pt:
        return DataParserPt();
        break;
      case fr:
        return DataParserFr();
        break;
      default:
        return DataParserEn();
    }
  }
}
