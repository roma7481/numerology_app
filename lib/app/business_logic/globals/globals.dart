library app.globals;

import 'package:numerology/app/localization/language/language_en.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/localization/locale_utils.dart';

class Globals {
  Globals._({
    this.textSize = 18.0,
    this.language = const LanguageEn(),
  });

  static final instance = Globals._();

  double textSize;
  Languages language;

  void setLocale({required String localeCode}) {
    this.language = LocaleUtils.selectLanguage(localeCode);
  }

  Languages getLanguage() {
    return this.language;
  }
}
