import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';

import 'forecast.dart';

class CalcUtilsEn {
  Future<Forecast> getDailyForecast(Profile profile) async {
    var language = Globals.instance.language;
    return Forecast(
        title: language.dailyForecast,
        cardTitle: language.personalDayNumber,
        iconPath: day,
        info: await _getDayInfo(),
        calc: _getDayCalc(profile),
        btnTitles: _getDailyBtnTitles(),
        contents: await _getDailyContent(profile));
  }

  Future<Forecast> getLuckyForecast(Profile profile) async {
    var language = Globals.instance.language;
    return Forecast(
        title: language.luckyForecast,
        cardTitle: language.dailyLuckyNumber,
        iconPath: lucky,
        info: await _getLuckyInfo(),
        calc: _getLuckyCalc(profile),
        btnTitles: _getLuckyBtnTitles(),
        contents: await _getLuckyContent(profile));
  }

  Future<Forecast> getMonthForecast(Profile profile) async {
    var language = Globals.instance.language;
    return Forecast(
        title: language.monthlyForecast,
        cardTitle: language.monthNumber,
        iconPath: month,
        info: await _getMonthlyInfo(),
        calc: _getMonthCalc(profile),
        btnTitles: _getMonthBtnTitles(),
        contents: await _getMonthContent(profile));
  }

  Future<Forecast> getAnnualForecast(Profile profile) async {
    var language = Globals.instance.language;
    return Forecast(
        title: language.annualForecast,
        cardTitle: language.yearNumber,
        iconPath: year,
        info: await _getYearInfo(),
        calc: _getYearCalc(profile),
        btnTitles: _getYearBtnTitles(),
        contents: await _getYearContent(profile));
  }

  List<String> _getDailyBtnTitles() {
    var date1 = DateTime.now();
    var date2 = DateTime.now().add(const Duration(days: 1));
    var date3 = DateTime.now().add(const Duration(days: 2));
    var btn1 = DateService.getShortFormattedDate(date1);
    var btn2 = DateService.getShortFormattedDate(date2);
    var btn3 = DateService.getShortFormattedDate(date3);
    return [btn1, btn2, btn3];
  }

  List<String> _getLuckyBtnTitles() {
    return _getDailyBtnTitles();
  }

  Future<Map<String, String>> _getDayInfo() async {
    return _getInfo('PERSONAL_DAY_ENG');
  }

  List<String> _getMonthBtnTitles() {
    var date1 = DateTime.now();
    var date2 = DateTime(date1.year, date1.month + 1, date1.day);
    var date3 = DateTime(date1.year, date1.month + 2, date1.day);
    var btn1 = DateService.getMonthFormattedDate(date1);
    var btn2 = DateService.getMonthFormattedDate(date2);
    var btn3 = DateService.getMonthFormattedDate(date3);
    return [btn1, btn2, btn3];
  }

  List<String> _getYearBtnTitles() {
    var date1 = DateTime.now();
    var date2 = DateTime(date1.year + 1, date1.month, date1.day);
    var date3 = DateTime(date1.year + 2, date1.month, date1.day);
    var btn1 = date1.year.toString();
    var btn2 = date2.year.toString();
    var btn3 = date3.year.toString();
    return [btn1, btn2, btn3];
  }

  Future<Map<String, String>> _getLuckyInfo() async {
    return _getInfo('DAILY_LUCKY_NUMBER_ENG');
  }

  Future<Map<String, String>> _getMonthlyInfo() async {
    return _getInfo('PERSONAL_MONTH_ENG');
  }

  Future<Map<String, String>> _getYearInfo() async {
    return _getInfo('PERSONAL_YEAR_ENG');
  }

  Future<Map<String, String>> _getInfo(String table) async {
    var language = Globals.instance.language;

    var info = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "$table"');
    return {language.info: info};
  }

  List<int> _getDayCalc(Profile profile) {
    var calc1 =
        CategoryCalc.instance.calcPersonalDayByDate(profile, DateTime.now());
    var calc2 = CategoryCalc.instance.calcPersonalDayByDate(
        profile, DateTime.now().add(const Duration(days: 1)));
    var calc3 = CategoryCalc.instance.calcPersonalDayByDate(
        profile, DateTime.now().add(const Duration(days: 2)));

    return [calc1, calc2, calc3];
  }

  List<int> _getLuckyCalc(Profile profile) {
    var calc1 =
        CategoryCalc.instance.calcDailyLuckyNum(profile, DateTime.now());
    var calc2 = CategoryCalc.instance.calcDailyLuckyNum(
        profile, DateTime.now().add(const Duration(days: 1)));
    var calc3 = CategoryCalc.instance.calcDailyLuckyNum(
        profile, DateTime.now().add(const Duration(days: 2)));

    return [calc1, calc2, calc3];
  }

  List<int> _getMonthCalc(Profile profile) {
    var date = DateTime.now();
    var calc1 = CategoryCalc.instance.calcMonthNum(profile, date);
    var calc2 = CategoryCalc.instance
        .calcMonthNum(profile, DateTime(date.year, date.month + 1, date.day));
    var calc3 = CategoryCalc.instance
        .calcMonthNum(profile, DateTime(date.year, date.month + 2, date.day));

    return [calc1, calc2, calc3];
  }

  List<int> _getYearCalc(Profile profile) {
    var date = DateTime.now();
    var calc1 = CategoryCalc.instance.calcYearNum(profile, date);
    var calc2 = CategoryCalc.instance
        .calcYearNum(profile, DateTime(date.year + 1, date.month, date.day));
    var calc3 = CategoryCalc.instance
        .calcYearNum(profile, DateTime(date.year + 2, date.month, date.day));

    return [calc1, calc2, calc3];
  }

  Future<List<String>> _getDailyContent(Profile profile) async {
    var calc = _getDayCalc(profile);
    return _getContent(calc, "PERSONAL_DAY_ENG");
  }

  Future<List<String>> _getLuckyContent(Profile profile) async {
    var calc = _getLuckyCalc(profile);
    return _getContent(calc, "DAILY_LUCKY_NUMBER_ENG");
  }

  Future<List<String>> _getMonthContent(Profile profile) async {
    var calc = _getMonthCalc(profile);
    return _getContent(calc, "PERSONAL_MONTH_ENG");
  }

  Future<List<String>> _getYearContent(Profile profile) async {
    var calc = _getYearCalc(profile);
    return _getContent(calc, "PERSONAL_YEAR_ENG");
  }

  Future<List<String>> _getContent(List<int> calc, String table) async {
    List<String> description = [];
    for (var i = 0; i < calc.length; i++) {
      var descr = await getEntityRawQuery(
          'select description from $table where  number = "${calc[i]}"');
      description.add(descr);
    }
    return description;
  }
}
