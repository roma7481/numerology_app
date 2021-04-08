import 'package:bloc/bloc.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  BioCubit()
      : super(BioState(
          physical: 0.0,
          emotional: 0.0,
          intel: 0.0,
          date: DateService.toTimestamp(DateTime.now()),
          description: [],
        ));

  void emitBioUpdate(List<double> bio, {int date}) async {
    if (date == null) {
      date = DateService.toTimestamp(DateTime.now());
    }

    emit(BioState(
      physical: bio[0],
      emotional: bio[1],
      intel: bio[2],
      date: date,
      description: await _getDescription(bio),
    ));
  }

  void emitBioInit(Profile profile) {
    var bio = CategoryCalc.instance.calcBioByDate(profile.dob);
    emitBioUpdate(bio);
  }

  Future<List<CardData>> _getDescription(List<double> bio) async {
    var bioLevel = CategoryCalc.instance.calcBioLevel(bio);

    var table = 'BIORITHMS_ENG';
    var description1 = await getEntityRawQuery(
        'select description from $table where type = "physical" AND level = "${bioLevel[0]}"');
    var description2 = await getEntityRawQuery(
        'select description from $table where type = "emotional" AND level = "${bioLevel[1]}"');
    var description3 = await getEntityRawQuery(
        'select description from $table where type = "intellectual" AND level = "${bioLevel[2]}"');
    var info = await getEntityRawQuery(
        'select description from "TABLE_DESCRIPTION" where table_name = "$table" ');

    return [
      CardData(
          description: description1,
          header: Globals.instance.language.physicalBio,
          iconPath: physical),
      CardData(
          description: description2,
          header: Globals.instance.language.emotionalBio,
          iconPath: emotional),
      CardData(
          description: description3,
          header: Globals.instance.language.intellectBio,
          iconPath: intel),
      CardData(
          description: info,
          header: Globals.instance.language.info,
          iconPath: infoIcon),
    ];
  }
}
