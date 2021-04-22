import 'package:bloc/bloc.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/data/language/calc_utils.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';

part 'bio_second_state.dart';

class BioSecondCubit extends Cubit<BioSecondState> {
  BioSecondCubit() : super(BioSecondStateLoading());

  void emitBioUpdate(List<double> bio, {int date}) async {
    if (date == null) {
      date = DateService.toTimestamp(DateTime.now());
    }

    emit(BioSecondStateReady(
      bio: bio,
      date: date,
      description: await CategoryProvider.instance.getSecondaryBio(bio),
    ));
  }

  void emitBioInit(Profile profile) {
    var bio = CategoryCalc.instance.calcBioSecondByDate(profile.dob);
    emitBioUpdate(bio);
  }
}
