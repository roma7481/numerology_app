import 'package:intl/intl.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/localization/language/language_en.dart';

class DateService {
  static var locale = Globals.instance.localeCode;

  static var standardFormat = new DateFormat('dd-MMM-yyyy', locale);
  static var usFormat = DateFormat('MMM-dd-yyyy', locale);
  static var standardShortFormat = DateFormat('dd-MMM', locale);
  static var usShortFormat = DateFormat('MMM-dd', locale);
  static var monthFormat = DateFormat('MMM', locale);

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

  static String getShortFormattedDate(
    DateTime date,
  ) {
    var currentLocale = Globals.instance.localeCode;
    standardShortFormat = DateFormat('dd-MMM', currentLocale);
    usShortFormat = DateFormat('MMM-dd', currentLocale);
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

  static String fromTimestampToString(int timestamp) {
    return timestamp != null
        ? getFormattedDate(DateTime.fromMillisecondsSinceEpoch(timestamp))
        : '';
  }
}
