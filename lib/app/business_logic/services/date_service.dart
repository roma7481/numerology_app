import 'package:intl/intl.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/localization/language/language_en.dart';

class DateService {
  static var standardFormat = DateFormat('dd-MMM-yyyy');
  static var usFormat = DateFormat('MMM-dd-yyyy');
  static var standardShortFormat = DateFormat('dd-MMM');
  static var usShortFormat = DateFormat('MMM-dd');
  static var monthFormat = DateFormat('MMM');

  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  static DateTime getDateTimeMinusNumYear(int numYears) {
    var date = new DateTime.now();
    return DateTime(date.year - numYears, date.month, date.day);
  }

  static String getFormattedDate(DateTime date) {
    return (Globals.instance.getLanguage() is LanguageEn)
        ? usFormat.format(date)
        : standardFormat.format(date);
  }

  static String getShortFormattedDate(DateTime date) {
    return (Globals.instance.getLanguage() is LanguageEn)
        ? usShortFormat.format(date)
        : standardShortFormat.format(date);
  }

  static String getMonthFormattedDate(DateTime date) {
    return monthFormat.format(date);
  }

  static int toTimestamp(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  static DateTime fromTimestamp(int timestamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
