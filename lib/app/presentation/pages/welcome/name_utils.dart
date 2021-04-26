import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/locale_utils.dart';

bool containsVowels(String fName, String lName, String mName) {
  return (_containsVowels(fName) ||
      _containsVowels(lName) ||
      _containsVowels(mName));
}

bool containsNonVowels(Profile profile) {
  return (_containsNonVowels(profile.firstName) ||
      _containsNonVowels(profile.lastName) ||
      _containsNonVowels(profile.middleName));
}

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

bool _containsNonVowels(String str) {
  if (str != null && str.isNotEmpty) {
    if (LocaleUtils.containsNonVowels(str)) {
      return true;
    }
  }
  return false;
}
