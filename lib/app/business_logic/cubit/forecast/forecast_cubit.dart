import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  StreamSubscription userDataStreamSubscription;
  final UserDataCubit userData;

  ForecastCubit(this.userData) : super(ForecastLoading()) {
    userDataStreamSubscription = userData.stream.listen((userDataResult) async {
      if (userDataResult is UserDataReady) {
        await initForecast(userDataResult.profile);
      }
    });
  }

  Future<void> initForecast(Profile profile) async {
    try {
      Forecast daily = Forecast(
          title: 'daily',
          cardTitle: 'daily title',
          iconPath: day,
          info: await _getDayInfo(),
          calc: _getDayCalc(profile),
          btnTitles: _getDailyBtnTitles(),
          contents: await _getDailyContent(profile));

      emit(ForecastReady(
        daily: daily,
        lucky: daily,
        monthly: daily,
        annual: daily,
      ));
    } catch (e) {
      emit(ForecastError(e));
    }

    // final Forecast lucky;
    // final Forecast monthly;
    // final Forecast annual;
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

  Future<Map<String, String>> _getDayInfo() async {
    var language = Globals.instance.language;

    var info = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "PERSONAL_DAY_ENG"');
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

  Future<List<String>> _getDailyContent(Profile profile) async {
    var calc = _getDayCalc(profile);

    var description1 = await getEntityRawQuery(
        'select description from PERSONAL_DAY_ENG  where  number = "${calc[0]}"');
    var description2 = await getEntityRawQuery(
        'select description from PERSONAL_DAY_ENG  where  number = "${calc[1]}"');
    var description3 = await getEntityRawQuery(
        'select description from PERSONAL_DAY_ENG  where  number = "${calc[2]}"');

    return [
      description1,
      description2,
      description3,
    ];
  }

  @override
  Future<void> close() {
    userDataStreamSubscription.cancel();
    return super.close();
  }
}
