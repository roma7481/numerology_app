import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/constants/strings.dart';

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
  static List<TextInputFormatter> keyboardInputFormatter() {
    /// Need to add a keyboard formatter for every language we add ///
    var formatter = new FilteringTextInputFormatter.allow(
        RegExp(r"[a-zA-Z]+|[А-Яа-я]+|[Ñ]+|[ñ]+|\s"));
    return [formatter];
  }

  static Map<int, LanguageItem> allLanguages = {
    0: LanguageItem(en, english),
    1: LanguageItem(ru, russian),
    2: LanguageItem(es, spanish),
  };

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
}
