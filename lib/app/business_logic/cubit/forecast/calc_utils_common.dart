import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';

class CommonUtils {
  CommonUtils._();

  static final instance = CommonUtils._();

  List<String> getDailyBtnTitles() {
    var date1 = DateTime.now();
    var date2 = DateTime.now().add(const Duration(days: 1));
    var date3 = DateTime.now().add(const Duration(days: 2));
    var btn1 = DateService.getShortFormattedDate(date1);
    var btn2 = DateService.getShortFormattedDate(date2);
    var btn3 = DateService.getShortFormattedDate(date3);
    return [btn1, btn2, btn3];
  }

  List<String> getMonthBtnTitles() {
    var date1 = DateTime.now();
    var date2 = DateTime(date1.year, date1.month + 1, date1.day);
    var date3 = DateTime(date1.year, date1.month + 2, date1.day);
    var btn1 = DateService.getMonthFormattedDate(date1);
    var btn2 = DateService.getMonthFormattedDate(date2);
    var btn3 = DateService.getMonthFormattedDate(date3);
    return [btn1, btn2, btn3];
  }

  List<String> getYearBtnTitles() {
    var date1 = DateTime.now();
    var date2 = DateTime(date1.year + 1, date1.month, date1.day);
    var date3 = DateTime(date1.year + 2, date1.month, date1.day);
    var btn1 = date1.year.toString();
    var btn2 = date2.year.toString();
    var btn3 = date3.year.toString();
    return [btn1, btn2, btn3];
  }

  Future<List<String>> getContent(List<int> calc, String table) async {
    List<String> description = [];
    for (var i = 0; i < calc.length; i++) {
      var descr = await getEntityRawQuery(
          'select description from $table where  number = "${calc[i]}"');
      description.add(descr);
    }
    return description;
  }

  List<int> getDayCalc(Profile profile) {
    var calc1 =
        CategoryCalc.instance.calcPersonalDayByDate(profile, DateTime.now());
    var calc2 = CategoryCalc.instance.calcPersonalDayByDate(
        profile, DateTime.now().add(const Duration(days: 1)));
    var calc3 = CategoryCalc.instance.calcPersonalDayByDate(
        profile, DateTime.now().add(const Duration(days: 2)));

    return [calc1, calc2, calc3];
  }

  List<int> getLuckyCalc(Profile profile) {
    var calc1 =
        CategoryCalc.instance.calcDailyLuckyNum(profile, DateTime.now());
    var calc2 = CategoryCalc.instance.calcDailyLuckyNum(
        profile, DateTime.now().add(const Duration(days: 1)));
    var calc3 = CategoryCalc.instance.calcDailyLuckyNum(
        profile, DateTime.now().add(const Duration(days: 2)));

    return [calc1, calc2, calc3];
  }

  List<int> getMonthCalc(Profile profile) {
    var date = DateTime.now();
    var calc1 = CategoryCalc.instance.calcMonthNum(profile, date);
    var calc2 = CategoryCalc.instance
        .calcMonthNum(profile, DateTime(date.year, date.month + 1, date.day));
    var calc3 = CategoryCalc.instance
        .calcMonthNum(profile, DateTime(date.year, date.month + 2, date.day));

    return [calc1, calc2, calc3];
  }

  List<int> getYearCalc(Profile profile) {
    var date = DateTime.now();
    var calc1 = CategoryCalc.instance.calcYearNum(profile, date);
    var calc2 = CategoryCalc.instance
        .calcYearNum(profile, DateTime(date.year + 1, date.month, date.day));
    var calc3 = CategoryCalc.instance
        .calcYearNum(profile, DateTime(date.year + 2, date.month, date.day));

    return [calc1, calc2, calc3];
  }
}
