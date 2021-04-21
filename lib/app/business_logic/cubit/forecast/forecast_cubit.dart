import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/data/models/profile.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastLoading());

  Future<void> updateForecast(Profile profile) async {
    var forecastUtils = Globals.instance.getForecastUtils();

    try {
      Forecast daily = await forecastUtils.getDailyForecast(profile);
      Forecast lucky = await forecastUtils.getLuckyForecast(profile);
      Forecast monthly = await forecastUtils.getMonthForecast(profile);
      Forecast annual = await forecastUtils.getAnnualForecast(profile);

      emit(ForecastReady(
        daily: daily,
        lucky: lucky,
        monthly: monthly,
        annual: annual,
      ));
    } catch (e) {
      emit(ForecastError(e));
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
