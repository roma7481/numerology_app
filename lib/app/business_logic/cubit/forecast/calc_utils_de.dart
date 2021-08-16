import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';

import 'calc_utils.dart';
import 'calc_utils_common.dart';
import 'forecast.dart';

class CalcUtilsDe extends ForecastCalcUtils {



  @override
  Future<Forecast> getDailyForecast(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var language = Globals.instance.language;
    return Forecast(
        title: language.dailyForecast,
        cardTitle: language.personalDayNumber,
        iconPath: day,
        info: await _getDayInfo(),
        calc: calcUtils.getDayCalc(profile),
        btnTitles: calcUtils.getDailyBtnTitles(),
        contents: await _getDailyContent(profile));
  }

  @override
  Future<Forecast> getLuckyForecast(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var language = Globals.instance.language;
    return Forecast(
        title: language.luckyForecast,
        cardTitle: language.dailyLuckyNumber,
        iconPath: lucky,
        info: await _getLuckyInfo(),
        calc: calcUtils.getLuckyCalc(profile),
        btnTitles: _getLuckyBtnTitles(),
        contents: await _getLuckyContent(profile));
  }

  @override
  Future<Forecast> getMonthForecast(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var language = Globals.instance.language;
    return Forecast(
        title: language.monthlyForecast,
        cardTitle: language.monthNumber,
        iconPath: month,
        info: await _getMonthlyInfo(),
        calc: calcUtils.getMonthCalc(profile),
        btnTitles: calcUtils.getMonthBtnTitles(),
        contents: await _getMonthContent(profile));
  }

  @override
  Future<Forecast> getAnnualForecast(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var language = Globals.instance.language;
    return Forecast(
        title: language.annualForecast,
        cardTitle: language.yearNumber,
        iconPath: year,
        info: await _getYearInfo(),
        calc: calcUtils.getYearCalc(profile),
        btnTitles: calcUtils.getYearBtnTitles(),
        contents: await _getYearContent(profile));
  }

  List<String> _getLuckyBtnTitles() {
    var calcUtils = CommonUtils.instance;
    return calcUtils.getDailyBtnTitles();
  }

  Future<String> _getDayInfo() async {
    return _getInfo('PERSONAL_DAY_DE');
  }

  Future<String> _getLuckyInfo() async {
    return _getInfo('DAILY_LUCKY_NUMBER_DE');
  }

  Future<String> _getMonthlyInfo() async {
    return _getInfo('PERSONAL_MONTH_DE');
  }

  Future<String> _getYearInfo() async {
    return _getInfo('PERSONAL_YEAR_DE');
  }

  Future<String> _getInfo(String table) async {
    return await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "$table"');
  }

  Future<List<String>> _getDailyContent(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var calc = calcUtils.getDayCalc(profile);
    return calcUtils.getContent(calc, "PERSONAL_DAY_DE");
  }

  Future<List<String>> _getLuckyContent(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var calc = calcUtils.getLuckyCalc(profile);
    return calcUtils.getContent(calc, "DAILY_LUCKY_NUMBER_DE");
  }

  Future<List<String>> _getMonthContent(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var calc = calcUtils.getMonthCalc(profile);
    return calcUtils.getContent(calc, "PERSONAL_MONTH_DE");
  }

  Future<List<String>> _getYearContent(Profile profile) async {
    var calcUtils = CommonUtils.instance;
    var calc = calcUtils.getYearCalc(profile);
    return calcUtils.getContent(calc, "PERSONAL_YEAR_DE");
  }
}
