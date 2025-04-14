part of 'forecast_cubit.dart';

@immutable
abstract class ForecastState {}

class ForecastLoading extends ForecastState {}

class ForecastReady extends ForecastState {
  final Forecast? daily;
  final Forecast? lucky;
  final Forecast? monthly;
  final Forecast? annual;

  ForecastReady({
    this.daily,
    this.lucky,
    this.monthly,
    this.annual,
  });
}

class ForecastError extends ForecastState {
  final Exception exception;

  ForecastError(this.exception);
}
