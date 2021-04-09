import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast.dart';
import 'package:numerology/app/constants/icon_path.dart';

part 'forecast_state.dart';

class ForecastCubit extends Cubit<ForecastState> {
  ForecastCubit() : super(ForecastLoading()) {
    initForecast();
  }

  void initForecast() {
    try {
      Forecast daily = Forecast(
          title: 'daily',
          cardTitle: 'daily title',
          iconPath: day,
          btnTitles: ['b1', 'b2', 'b3'],
          contents: ['c1', 'c2', 'c3']);

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
}
