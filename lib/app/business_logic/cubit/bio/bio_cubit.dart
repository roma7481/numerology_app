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
          date: DateService.toTimestamp(DateTime.now()),
        ));

  void emitBioUpdatePrim(List<double> bioPrim, {int date}) async {
    if (date == null) {
      date = DateService.toTimestamp(DateTime.now());
    }

    emit(state.copyWith(
      bioPrim: bioPrim,
      date: date,
      descriptionPrim: await _getDescriptionPrim(bioPrim),
    ));
  }

  void emitBioUpdateSecond(List<double> bioSecond, {int date}) async {
    if (date == null) {
      date = DateService.toTimestamp(DateTime.now());
    }

    emit(state.copyWith(
      bioSecond: bioSecond,
      date: date,
      descriptionSecond: await _getDescriptionSecond(bioSecond),
    ));
  }

  void emitBioInit(Profile profile) {
    var bioPrim = CategoryCalc.instance.calcBioPrimByDate(profile.dob);
    var bioSecond = CategoryCalc.instance.calcBioSecondByDate(profile.dob);
    emitBioUpdatePrim(bioPrim);
    emitBioUpdateSecond(bioSecond);
  }

  Future<List<CardData>> _getDescriptionPrim(List<double> bioPrim) async {
    var bioLevel = CategoryCalc.instance.calcBioLevelPrim(bioPrim);

    var table = 'BIORITHMS_ENG';
    var description1 = await getEntityRawQuery(
        'select description from $table where type = "physical" AND level = "${bioLevel[0]}"');
    var description2 = await getEntityRawQuery(
        'select description from $table where type = "emotional" AND level = "${bioLevel[1]}"');
    var description3 = await getEntityRawQuery(
        'select description from $table where type = "intellectual" AND level = "${bioLevel[2]}"');
    var info = await getEntityRawQuery(
        'select description from "TABLE_DESCRIPTION" where table_name = "$table"');

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

  Future<List<CardData>> _getDescriptionSecond(List<double> bioSecond) async {
    var bioLevel = CategoryCalc.instance.calcBioLevelSecond(bioSecond);

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
          description: description4,
          header: Globals.instance.language.intellectBio,
          iconPath: intel),
      CardData(
          description: info,
          header: Globals.instance.language.info,
          iconPath: infoIcon),
    ];
  }
}
