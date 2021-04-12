import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/data/models/profile.dart';

import 'calc_utils_en.dart';

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
      Forecast daily = await CalcUtilsEn().getDailyForecast(profile);
      Forecast lucky = await CalcUtilsEn().getLuckyForecast(profile);
      Forecast monthly = await CalcUtilsEn().getMonthForecast(profile);

      emit(ForecastReady(
        daily: daily,
        lucky: lucky,
        monthly: monthly,
        annual: daily,
      ));
    } catch (e) {
      emit(ForecastError(e));
    }

    // final Forecast lucky;
    // final Forecast monthly;
    // final Forecast annual;
  }

  @override
  Future<void> close() {
    userDataStreamSubscription.cancel();
    return super.close();
  }
}
