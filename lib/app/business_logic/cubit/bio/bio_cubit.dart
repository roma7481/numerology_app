import 'package:bloc/bloc.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/data/language/calc_utils.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  BioCubit()
      : super(BioState(
          date: DateService.toTimestamp(DateTime.now()),
          description: [],
        ));

  void emitBioUpdate(List<double> bio, {int? date}) async {
    if (date == null) {
      date = DateService.toTimestamp(DateTime.now());
    }

    emit(BioState(
      bio: bio,
      date: date,
      description: await CategoryProvider.instance.getPrimBio(bio),
    ));
  }

  void emitBioInit(Profile profile) {
    var bio = CategoryCalc.instance.calcBioPrimByDate(profile.dob!);
    emitBioUpdate(bio);
  }
}
