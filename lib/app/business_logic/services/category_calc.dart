import 'dart:math';

import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/language/language_ru.dart';

import 'calc_utils.dart';
import 'date_service.dart';

class CategoryCalc {
  CategoryCalc._();

  static final instance = CategoryCalc._();

  int calcCharacterNumber(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var day = _calcToSingleDigit(birthday.day);
    return _calcToSingleDigit(day);
  }

  List<String> calcAchievementPeriods(Profile profile) {
    var period1 = 36 - _calcAchievementPeriod1(profile);
    var period2 = period1 + 9;
    var period3 = period2 + 9;

    var text1 =
        'Продолжительность первого пика от рождения до $period1 лет\n\n';
    var text2 = 'Продолжительность второго пика с $period1 до $period2 \n\n';
    var text3 = 'Продолжительность второго пика с $period2 до $period3 \n\n';
    var text4 = 'Продолжительность четвертого пика с $period3 и далее \n\n';

    return [text1, text2, text3, text4];
  }

  int _calcAchievementPeriod1(Profile profile) {
    return _calcToSingleDigit(calcLifePathNumberMethod1(profile));
  }

  List<String> calcAchievementNums(Profile profile) {
    return [
      calcAchievementNum1(profile).toString(),
      calcAchievementNum2(profile).toString(),
      calcAchievementNum3(profile).toString(),
      calcAchievementNum4(profile).toString(),
    ];
  }

  int calcAchievementNum1(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var month = _calcToSingleDigit(birthday.month);
    var day = _calcToSingleDigit(birthday.day);
    return _calcToSingleDigit(day + month);
  }

  int calcAchievementNum2(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var day = _calcToSingleDigit(birthday.day);
    var year = _calcToSingleDigit(birthday.year);
    return _calcToSingleDigit(day + year);
  }

  int calcAchievementNum3(Profile profile) {
    int ach3 = calcAchievementNum1(profile) + calcAchievementNum2(profile);
    return _calcToSingleDigit(ach3);
  }

  int calcAchievementNum4(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var year = _calcToSingleDigit(birthday.year);
    var month = _calcToSingleDigit(birthday.month);
    return _calcToSingleDigit(year + month);
  }

  List<double> calcBio(Profile profile) {
    return calcBioPrimByDate(profile.dob);
  }

  List<String> calcBioPrimLevel(List<double> bio) {
    var bioLevels = ['positive', 'positive', 'positive'];

    for (int i = 0; i < bio.length; i++) {
      bioLevels[i] = bio[i] < 0
          ? 'negative'
          : bio[i] > 0
              ? 'positive'
              : 'critical';
    }

    return bioLevels;
  }

  List<String> calcBioPrimLevelRu(List<double> bio) {
    var bioLevels = ['hight', 'hight', 'hight'];

    for (int i = 0; i < bio.length; i++) {
      if (bio[i] <= 100.0 && bio[i] >= 80.0) {
        bioLevels[i] = 'max';
      } else if (bio[i] > 5.0 && bio[i] < 80.0) {
        bioLevels[i] = 'hight';
      } else if (bio[i] <= 5.0 && bio[i] >= -5.0) {
        bioLevels[i] = 'critical';
      } else if (bio[i] < -5.0 && bio[i] > -80.0) {
        bioLevels[i] = 'low';
      } else {
        bioLevels[i] = 'min';
      }
    }

    return bioLevels;
  }

  List<String> calcBioCompatLevel(Profile profile) {
    var bioCompat = calcBioCompat(profile);
    var bioLevels = ['max', 'max', 'max'];

    for (int i = 0; i < bioCompat.length; i++) {
      var daily = bioCompat[i];
      if (daily <= 100.0 && daily >= 80.0) {
        bioLevels[i] = "max";
      } else if (daily >= 50 && daily < 80.0) {
        bioLevels[i] = "good";
      } else if (daily >= 30 && daily < 50.0) {
        bioLevels[i] = "bad";
      } else {
        bioLevels[i] = "min";
      }
    }

    return bioLevels;
  }

  List<double> calcBioCompat(Profile profile) {
    var rhythms = [0.0, 0.0, 0.0];
    var days = _calcDaysBetweenCouples(profile);

    rhythms[0] = (cos(2.0 * pi * days / 23.0) * 100.0).abs();
    rhythms[1] = (cos(2.0 * pi * days / 28.0) * 100.0).abs();
    rhythms[2] = (cos(2.0 * pi * days / 33.0) * 100.0).abs();

    return rhythms;
  }

  int _calcDaysBetweenCouples(Profile profile) {
    var millisecondsDiff = (profile.dob - profile.partnerDob).abs();
    return Duration(milliseconds: millisecondsDiff).inDays;
  }

  List<String> calcBioSecondLevel(List<double> bio) {
    var bioLevels = ['high', 'high', 'high', 'high'];

    for (int i = 0; i < bio.length; i++) {
      bioLevels[i] = bio[i] < 0 ? 'low' : 'high';
    }

    return bioLevels;
  }

  List<double> calcBioPrimByDate(int dob) {
    var rhythms = [0.0, 0.0, 0.0];

    var days = calcDaysAfterBorn(dob);
    rhythms[0] = sin(2.0 * pi * days / 23.0) * 100.0;
    rhythms[1] = sin(2.0 * pi * days / 28.0) * 100.0;
    rhythms[2] = sin(2.0 * pi * days / 33.0) * 100.0;

    for (int i = 0; i < rhythms.length; i++) {
      if (rhythms[i] < 0 && rhythms[i] > -0.1) {
        rhythms[i] = 0;
      }
    }

    return rhythms;
  }

  List<double> calcBioSecondByDate(int dob) {
    var rhythms = [0.0, 0.0, 0.0, 0.0];

    var days = calcDaysAfterBorn(dob);
    rhythms[0] = sin(2.0 * pi * days / 53.0) * 100.0; //spirit
    rhythms[1] = sin(2.0 * pi * days / 38.0) * 100.0; //intuition
    rhythms[2] = sin(2.0 * pi * days / 48.0) * 100.0; //awareness
    rhythms[3] = sin(2.0 * pi * days / 43.0) * 100.0; //aesthetic

    for (int i = 0; i < rhythms.length; i++) {
      if (rhythms[i] < 0 && rhythms[i] > -0.1) {
        rhythms[i] = 0;
      }
    }

    return rhythms;
  }

  int calcDaysAfterBorn(int dob) {
    var date1 = DateService.fromTimestamp(dob);
    var date2 = DateTime.now();
    return date2.difference(date1).abs().inDays;
  }

  List<String> calcMatrixCompat(
      List<int> yourMatrixLines, List<int> partnerMatrixLines) {
    List<String> categories = ['', '', '', '', '', '', '', ''];
    for (int i = 0; i < yourMatrixLines.length; i++) {
      if (yourMatrixLines[i] < 3 && partnerMatrixLines[i] < 3) {
        categories[i] = "weak";
      } else if (yourMatrixLines[i] == 3 && partnerMatrixLines[i] == 3) {
        categories[i] = "moderate";
      } else if (yourMatrixLines[i] > 3 && partnerMatrixLines[i] > 3) {
        if ((yourMatrixLines[i] - partnerMatrixLines[i]).abs() >= 2) {
          categories[i] = (yourMatrixLines[i] > partnerMatrixLines[i])
              ? "you_stronger"
              : "partner_stronger";
        } else {
          categories[i] = "strong";
        }
      } else {
        categories[i] = (yourMatrixLines[i] > partnerMatrixLines[i])
            ? "you_stronger"
            : "partner_stronger";
      }
    }

    return categories;
  }

  List<int> calcMatrixLines(Profile profile) {
    return calcMatrixLinesByDob(profile.dob);
  }

  List<int> calcMatrixLinesByDob(int dob) {
    var linesArray = [
      0,
      0,
      0,
      0,
      0,
      0,
      0,
      0,
    ];

    var array = calcMatrixByDob(dob);
    linesArray[0] =
        _calcMatrixLine(array: array, index0: 0, index1: 3, index2: 6);
    linesArray[1] =
        _calcMatrixLine(array: array, index0: 1, index1: 4, index2: 7);
    linesArray[2] =
        _calcMatrixLine(array: array, index0: 2, index1: 5, index2: 8);
    linesArray[3] =
        _calcMatrixLine(array: array, index0: 0, index1: 1, index2: 2);
    linesArray[4] =
        _calcMatrixLine(array: array, index0: 3, index1: 4, index2: 5);
    linesArray[5] =
        _calcMatrixLine(array: array, index0: 6, index1: 7, index2: 8);
    linesArray[6] =
        _calcMatrixLine(array: array, index0: 2, index1: 4, index2: 6);
    linesArray[7] =
        _calcMatrixLine(array: array, index0: 0, index1: 4, index2: 8);
    return linesArray;
  }

  int _calcMatrixLine({List<int> array, int index0, int index1, int index2}) {
    return array[index0] + array[index1] + array[index2] == 0
        ? 0
        : ('' +
                array[index0].toString() +
                array[index1].toString() +
                array[index2].toString())
            .replaceAll('0', '')
            .length;
  }

  List<int> calcMatrix(Profile profile) {
    return calcMatrixByDob(profile.dob);
  }

  List<int> calcMatrixByDob(int dob) {
    var birthday = DateService.fromTimestamp(dob);
    var year = birthday.year;
    var month = birthday.month;
    var day = birthday.day;

    var array = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    var helpArray = [0, 0, 0, 0];
    helpArray[0] = _calcNumToDigits(day) +
        _calcNumToDigits(month) +
        _calcNumToDigits(year);
    helpArray[1] = _calcNumToDigits(helpArray[0]);
    if (day > 9) {
      helpArray[2] = (helpArray[0] - ((day ~/ 10) * 2)).abs();
    } else {
      helpArray[2] = (helpArray[0] - (day * 2)).abs();
    }
    helpArray[3] = _calcNumToDigits(helpArray[2]);
    var helpNum = '' +
        day.toString() +
        month.toString() +
        year.toString() +
        helpArray[0].toString() +
        helpArray[1].toString() +
        helpArray[2].toString() +
        helpArray[3].toString();
    helpNum = helpNum.replaceAll('0', '');

    helpNum.split('').forEach((char) {
      var helping = int.parse(char);
      if (array[helping - 1] == 0) {
        array[helping - 1] = helping;
      } else {
        var helpSingle =
            '' + (array[helping - 1]).toString() + helping.toString();
        array[helping - 1] = int.parse(helpSingle);
      }
    });

    return array;
  }

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

  List<String> calcChallengeNums(Profile profile) {
    return [
      calcChallengeNum1(profile).toString(),
      calcChallengeNum2(profile).toString(),
      calcChallengeNum3(profile).toString(),
      calcChallengeNum4(profile).toString(),
    ];
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
    return calcLifePathNumberMethod(profile.dob);
  }

  int calcLifePathNumberMethod(int dob) {
    var birthday = DateService.fromTimestamp(dob);
    var lifeNumberDay = _calcToSingleDigitWithMagicNums(birthday.day);
    var lifeNumberMonth = _calcToSingleDigitWithMagicNums(birthday.month);
    var lifeNumberYear = _calcToSingleDigitWithMagicNums(birthday.year);
    return _calcToSingleDigitWithMagicNums(
        lifeNumberDay + lifeNumberMonth + lifeNumberYear);
  }

  int calcBirthdayCode(Profile profile) {
    var birthday = DateService.fromTimestamp(profile.dob);
    var birthCodeNumber = birthday.day + birthday.month + birthday.year;

    if (Globals.instance.language is LanguageRu) {
      return _calcToSingleDigitWithMagicNums(birthCodeNumber);
    }
    return _calcToSingleDigit(birthCodeNumber);
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

  int calcDailyLuckyNum(Profile profile, DateTime date) {
    var luckyNum = calcPersonalDayByDate(profile, date) +
        calcLifePathNumberMethod1(profile);
    return _calcToSingleDigit(luckyNum);
  }

  int calcMonthNum(Profile profile, DateTime date) {
    var year = calcYearNum(profile, date);
    var currentMonth = date.month;
    return _calcToSingleDigit(currentMonth + year);
  }

  int calcYearNum(Profile profile, DateTime date) {
    var birthday = DateService.fromTimestamp(profile.dob);

    var currentYear = _calcToSingleDigitWithMagicNums(date.year);
    var day = _calcToSingleDigitWithMagicNums(birthday.day);
    var month = _calcToSingleDigitWithMagicNums(birthday.month);
    return _calcToSingleDigit(day + month + currentYear);
  }

  int calcPersonalDayByDate(Profile profile, DateTime date) {
    var personalMonth = calcPersonalMonth(profile);
    var currentDay = date.day;
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
