import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/language/language_ru.dart';

import 'date_service.dart';

class CategoryCalc {
  CategoryCalc._();

  static final instance = CategoryCalc._();

  int calcLifePathNumberMethod1(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var lifeNumberDay = _calcToSingleDigitWithMagicNums(birthday.day);
    var lifeNumberMonth = _calcToSingleDigitWithMagicNums(birthday.month);
    var lifeNumberYear = _calcToSingleDigitWithMagicNums(birthday.year);
    return _calcToSingleDigitWithMagicNums(
        lifeNumberDay + lifeNumberMonth + lifeNumberYear);
  }

  int calcBirthdayCode(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var brthCodeNumber = birthday.day + birthday.month + birthday.year;

    if (Globals.instance.language is LanguageRu) {
      return _calcToSingleDigitWithMagicNums(brthCodeNumber);
    }
    return _calcToSingleDigit(brthCodeNumber);
  }

  int calcLuckGem(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    return _calcToSingleDigit(birthday.day);
  }

  int calcPersonalDay(Profile profile) {
    var personalMonth = calcPersonalMonth(profile);
    var currentDay = DateService.getCurrentDate().day;
    return _calcToSingleDigit(personalMonth + currentDay);
  }

  int calcPersonalMonth(Profile profile) {
    var personalYear = calcPersonalYear(profile);
    var currentMonth = DateService.getCurrentDate().month;
    return _calcToSingleDigit(personalYear + currentMonth);
  }

  int calcPersonalYear(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var currentYear = DateService.getCurrentDate().year;

    var year = _calcToSingleDigitWithMagicNums(currentYear);
    var day = _calcToSingleDigitWithMagicNums(birthday.day);
    var month = _calcToSingleDigitWithMagicNums(birthday.month);
    return _calcToSingleDigit(day + month + year);
  }

  int _calcToSingleDigit(int number) {
    var isStop = false;
    int result = 0;
    result = number;
    while (!isStop) {
      if (result < 10) {
        isStop = true;
      } else {
        result = _calcNumToDigits(result);
      }
    }
    return result;
  }

  int _calcToSingleDigitWithMagicNums(int number) {
    var isStop = false;
    int result = 0;
    result = number;
    while (!isStop) {
      if (result == 11 || result == 22 || result < 10) {
        isStop = true;
      } else {
        result = _calcNumToDigits(result);
      }
    }
    return result;
  }

  int _calcNumToDigits(int number) {
    int sum = 0;
    while (number > 0) {
      sum = sum + number % 10;
      number = number ~/ 10;
    }
    return sum;
  }
}
