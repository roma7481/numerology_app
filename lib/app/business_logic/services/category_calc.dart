import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/language/language_ru.dart';

import 'calc_utils.dart';
import 'date_service.dart';

class CategoryCalc {
  CategoryCalc._();

  static final instance = CategoryCalc._();

  int calcWeddingNumber(Profile profile) {
    var weddingDate = DateService.fromTimestamp(profile.weddingDate);
    var year = _charToNumber(weddingDate.year.toString());
    var month = _charToNumber(weddingDate.month.toString());
    var day = _charToNumber(weddingDate.day.toString());
    return _calcToSingleDigit(day + month + year);
  }

  int _charToNumber(String text) {
    int sum = 0;
    text.split('').forEach((ch) {
      sum = sum + int.parse(ch);
    });
    return sum;
  }

  int calcRealizationNumber(Profile profile) {
    var realizationNumber =
        calcLifePathNumberMethod1(profile) + calcExpressionNumber(profile);
    return _calcToSingleDigitWithMagicNums(realizationNumber);
  }

  int calcMaturityNumber(Profile profile) {
    var maturityNumber =
        calcLifePathNumberMethod1(profile) + calcExpressionNumber(profile);
    if (Globals.instance.language is LanguageRu) {
      return _calcToSingleDigit(maturityNumber);
    }
    return _calcToSingleDigitWithMagicNums(maturityNumber);
  }

  int calcDesireNumber(Profile profile) {
    var firstName = profile.firstName.toLowerCase();
    var lastName = profile.lastName.toLowerCase();

    var firstNameNumber =
        _calcToSingleDigitWithMagicNums(_convertConCharsAndSum(firstName));
    var lastNameNumber =
        _calcToSingleDigitWithMagicNums(_convertConCharsAndSum(lastName));

    return _calcToSingleDigitWithMagicNums(firstNameNumber + lastNameNumber);
  }

  int calcPersonalityNumber(Profile profile) {
    var personalityNumber = 0;
    bool isStop = false;

    var firstName = profile.firstName.toLowerCase();
    var lastName = profile.lastName.toLowerCase();
    var middleName = profile.middleName.toLowerCase();

    var firstNameNumber = _calcToSingleDigit(_convertConCharsAndSum(firstName));
    var lastNameNumber = _calcToSingleDigit(_convertConCharsAndSum(lastName));
    var middleNameNumber = middleName.isEmpty
        ? 0
        : _calcToSingleDigit(_convertConCharsAndSum(middleName));

    personalityNumber = firstNameNumber + lastNameNumber + middleNameNumber;
    while (!isStop) {
      if (personalityNumber == 11 ||
          personalityNumber == 22 ||
          personalityNumber < 10) {
        isStop = true;
      } else {
        personalityNumber = _calcNumToDigits(personalityNumber);
      }
    }

    return personalityNumber;
  }

  int calcExpressionNumber(Profile profile) {
    var expressionNumber = 0;

    var firstName = profile.firstName.toLowerCase();
    var lastName = profile.lastName.toLowerCase();
    var middleName = profile.middleName.toLowerCase();

    var firstNameNumber = _calcNumToDigits(_convertCharsAndSum(firstName));
    var lastNameNumber = _calcNumToDigits(_convertCharsAndSum(lastName));
    var middleNameNumber = middleName.isEmpty
        ? 0
        : _calcNumToDigits(_convertCharsAndSum(middleName));

    expressionNumber =
        _calcToSingleDigit(firstNameNumber + lastNameNumber + middleNameNumber);

    if (!(Globals.instance.language is LanguageRu)) {
      expressionNumber = _calcToSingleDigitWithMagicNums(expressionNumber);
    }

    return expressionNumber;
  }

  int calcNameNumber(Profile profile) {
    var nameNumber = 0;
    bool isStop = false;

    var firstName = profile.firstName.toLowerCase();
    var lastName = profile.lastName.toLowerCase();
    var middleName = profile.middleName.toLowerCase();

    if (Globals.instance.language is LanguageRu) {
      var nameNum = _convertCharsAndSum(firstName + lastName + middleName);
      while (!isStop) {
        if (nameNum == 11 || nameNum == 22 || nameNum < 10) {
          nameNumber = nameNum;
          isStop = true;
        } else {
          nameNum = _calcNumToDigits(nameNum);
        }
      }
    } else {
      var nameNum = middleName.isEmpty
          ? _convertCharsAndSum(firstName + lastName)
          : _convertCharsAndSum(firstName + lastName + middleName);
      while (!isStop) {
        if (nameNum < 10) {
          nameNumber = nameNum;
          isStop = true;
        } else {
          nameNum = _calcNumToDigits(nameNum);
        }
      }
    }
    return nameNumber;
  }

  int _convertCharsAndSum(String text) {
    int sum = 0;
    text.split('').forEach((ch) {
      sum = sum + letterToNumber(ch);
    });
    return sum;
  }

  int _convertConCharsAndSum(String text) {
    int sum = 0;
    text.split('').forEach((ch) {
      sum = sum + conLetterToNumber(ch);
    });
    return sum;
  }

  int calcSoulNumber(Profile profile) {
    var firstName = profile.firstName.toLowerCase();
    var lastName = profile.lastName.toLowerCase();
    var middleName = profile.middleName.toLowerCase();
    var firstNameNum = _calcToSingleDigit(_convertVowCharsAndSum(firstName));
    var lastNameNum = _calcToSingleDigit(_convertVowCharsAndSum(lastName));
    var middleNameNum = middleName.isEmpty
        ? 0
        : _calcToSingleDigit(_convertVowCharsAndSum(middleName));

    var soulNumber = firstNameNum + lastNameNum + middleNameNum;

    var isStop = false;
    while (!isStop) {
      if (soulNumber == 11 || soulNumber == 22 || soulNumber < 10) {
        isStop = true;
      } else {
        soulNumber = _calcNumToDigits(soulNumber);
      }
    }

    return soulNumber;
  }

  int _convertVowCharsAndSum(String text) {
    int sum = 0;
    text.split('').forEach((ch) {
      sum = sum + vowLetterToNumber(ch);
    });
    return sum;
  }

  int calcChallengeNum1(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var challengeMonth = _calcToSingleDigit(birthday.month);
    var challengeDay = _calcToSingleDigit(birthday.day);
    return (challengeMonth - challengeDay).abs();
  }

  int calcChallengeNum2(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var challengeYear = _calcToSingleDigit(birthday.year);
    var challengeDay = _calcToSingleDigit(birthday.day);
    return (challengeYear - challengeDay).abs();
  }

  int calcChallengeNum3(Profile profile) {
    return (calcChallengeNum1(profile) - calcChallengeNum2(profile)).abs();
  }

  int calcChallengeNum4(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var challengeYear = _calcToSingleDigit(birthday.year);
    var challengeMonth = _calcToSingleDigit(birthday.month);
    return (challengeYear - challengeMonth).abs();
  }

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
