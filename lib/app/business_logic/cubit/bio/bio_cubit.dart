import 'package:bloc/bloc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  BioCubit()
      : super(BioState(
          physical: 0.0,
          emotional: 0.0,
          intel: 0.0,
          date: DateService.toTimestamp(DateTime.now()),
        ));

  void emitBioUpdate(List<double> bio, int date) async {
    emit(BioState(physical: bio[0], emotional: bio[1], intel: bio[2], date: DateService.toTimestamp(DateTime.now())));
  }

  void emitBioUpdateByProfile(List<double> bio) async {
    emit(BioState(
      physical: bio[0],
      emotional: bio[1],
      intel: bio[2],
      date: DateService.toTimestamp(DateTime.now()),
    ));
  }
}
