import 'package:intl/intl.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/localization/language/language_en.dart';

class DateService {
  static var standardFormat = 'dd-MMM-yyyy';
  static var usFormat = 'MMM-dd-yyyy';
  static var standardShortFormat = 'dd-MMM';
  static var usShortFormat = 'MMM-dd';
  static var monthFormat = 'MMM';

  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  static DateTime getDateTimeMinusNumYear(int numYears) {
    var date = new DateTime.now();
    return DateTime(date.year - numYears, date.month, date.day);
  }

  static String getFormattedDate(DateTime date) {
    var locale = Globals.instance.localeCode;
    return (Globals.instance.getLanguage() is LanguageEn)
        ? new DateFormat(usFormat, locale).format(date)
        : new DateFormat(standardFormat, locale).format(date);
  }

  static String getShortFormattedDate(
    DateTime date,
  ) {
    var locale = Globals.instance.localeCode;
    return (Globals.instance.getLanguage() is LanguageEn)
        ? new DateFormat(usShortFormat, locale).format(date)
        : new DateFormat(standardShortFormat, locale).format(date);
  }

  static String getMonthFormattedDate(DateTime date) {
    var locale = Globals.instance.localeCode;
    return new DateFormat(monthFormat, locale).format(date);
  }

  static int toTimestamp(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  static DateTime fromTimestamp(int timestamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timestamp);
  }

  static String fromTimestampToString(int? timestamp) {
    return timestamp != null
        ? getFormattedDate(DateTime.fromMillisecondsSinceEpoch(timestamp))
        : '';
  }
}
