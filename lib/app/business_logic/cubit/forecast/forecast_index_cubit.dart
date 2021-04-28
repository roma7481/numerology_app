import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forecast_index_state.dart';

class ForecastIndexCubit extends Cubit<ForecastIndexState> {
  ForecastIndexCubit() : super(ForecastIndexLoading());

  Future<void> emitDayClicked(int index) async {
    emit(ForecastDayClicked(index));
  }

  Future<void> emitLuckyClicked(int index) async {
    emit(ForecastLuckyClicked(index));
  }

  Future<void> emitMonthClicked(int index) async {
    emit(ForecastMonthClicked(index));
  }

  Future<void> emitYearClicked(int index) async {
    emit(ForecastYearClicked(index));
  }
}
