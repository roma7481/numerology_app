import 'package:bloc/bloc.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/data/models/profile.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  BioCubit() : super(BioState(physical: 0.0, emotional: 0.0, intel: 0.0));

  void emitBioUpdate(List<double> bio) async {
    emit(BioState(physical: bio[0], emotional: bio[1], intel: bio[2]));
  }

  void emitBioUpdateByProfile(Profile profile) async {
    var bio = CategoryCalc.instance.calcBio(profile);
    emit(BioState(physical: bio[0], emotional: bio[1], intel: bio[2]));
  }
}
