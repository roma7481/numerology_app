import 'package:numerology/app/data/models/profile.dart';

import 'forecast.dart';

abstract class ForecastCalcUtils {
  const ForecastCalcUtils();

  Future<Forecast> getDailyForecast(Profile profile);

  Future<Forecast> getLuckyForecast(Profile profile);

  Future<Forecast> getMonthForecast(Profile profile);

  Future<Forecast> getAnnualForecast(Profile profile);
}
