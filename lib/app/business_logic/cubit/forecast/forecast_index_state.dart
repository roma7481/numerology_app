part of 'forecast_index_cubit.dart';

@immutable
abstract class ForecastIndexState {}

class ForecastIndexLoading extends ForecastIndexState {}

class ForecastDayClicked extends ForecastIndexState {
  final index;

  ForecastDayClicked(this.index);
}

class ForecastLuckyClicked extends ForecastIndexState {
  final index;

  ForecastLuckyClicked(this.index);
}

class ForecastMonthClicked extends ForecastIndexState {
  final index;

  ForecastMonthClicked(this.index);
}

class ForecastYearClicked extends ForecastIndexState {
  final index;

  ForecastYearClicked(this.index);
}
