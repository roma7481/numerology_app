import 'package:numerology/app/localization/locale_utils.dart';

bool shouldContainVowels(String fName, String lName, String mName) {
  if ((fName == null || fName.isEmpty) &&
      (lName == null || lName.isEmpty) &&
      (mName == null || mName.isEmpty)) {
    return false;
  }

  return !(_containsVowels(fName) ||
      _containsVowels(lName) ||
      _containsVowels(mName));
}

bool _containsVowels(String str) {
  if (str != null && str.isNotEmpty) {
    if (LocaleUtils.containsVowels(str)) {
      return true;
    }
  }
  return false;
}