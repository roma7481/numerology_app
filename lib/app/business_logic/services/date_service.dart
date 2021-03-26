import 'package:date_format/date_format.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/localization/language/language_en.dart';

class DateService {
  static var standardFormat = [dd, '-', mm, '-', yyyy];
  static var usFormat = [M, '-', dd, '-', yyyy];

  static DateTime getCurrentDate() {
    return DateTime.now();
  }

  static DateTime getDateTimeMinusNumYear(int numYears) {
    var date = new DateTime.now();
    return DateTime(date.year - numYears, date.month, date.day);
  }

  static String getFormattedDate(DateTime date) {
    return (Globals.instance.getLanguage() is LanguageEn)
        ? formatDate(date, usFormat)
        : formatDate(date, standardFormat);
  }

  static int toTimestamp(DateTime date) {
    return date.millisecondsSinceEpoch;
  }

  static DateTime fromTimestamp(int timestamp) {
    return new DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
}
