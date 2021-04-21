import 'package:bloc/bloc.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
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
      description: await _getDescription(bio),
    ));
  }

  void emitBioInit(Profile profile) {
    var bio = CategoryCalc.instance.calcBioSecondByDate(profile.dob);
    emitBioUpdate(bio);
  }

  Future<List<CardData>> _getDescription(List<double> bio) async {
    var bioLevel = CategoryCalc.instance.calcBioSecondLevel(bio);

    var table = 'SECONDARY_BIORITHMS_ENG';
    var description1 = await getEntityRawQuery(
        'select description from $table where type = "spiritual" AND level = "${bioLevel[0]}"');
    var description2 = await getEntityRawQuery(
        'select description from $table where type = "intuitive" AND level = "${bioLevel[1]}"');
    var description3 = await getEntityRawQuery(
        'select description from $table where type = "self-awareness" AND level = "${bioLevel[2]}"');
    var description4 = await getEntityRawQuery(
        'select description from $table where type = "aesthetic" AND level = "${bioLevel[2]}"');
    var info = await getEntityRawQuery(
        'select description from "TABLE_DESCRIPTION" where table_name = "SECONDARY_BIORYTHMS_ENG"');

    return [
      CardData(
          description: description1,
          header: Globals.instance.language.spiritBio,
          iconPath: spirit),
      CardData(
          description: description2,
          header: Globals.instance.language.intuitBio,
          iconPath: intuit),
      CardData(
          description: description3,
          header: Globals.instance.language.awareBio,
          iconPath: awareness),
      CardData(
          description: description4,
          header: Globals.instance.language.aestheticBio,
          iconPath: aesthetic),
      CardData(
          description: info,
          header: Globals.instance.language.info,
          iconPath: infoIcon),
    ];
  }
}
