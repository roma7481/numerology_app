import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';
import 'calc_utils.dart';

class DataParserIt extends DataParser {
  const DataParserIt();

  @override
  Future<List<CategoryModel>> getCategories(Profile profile) async {
    List<CategoryModel> categories = [];

    categories.add(await _getCompat(profile));
    categories.add(await _getSecondBio(profile));
    categories.add(await _getLifePathNumber(profile));
    categories.add(await _getSoulNumber(profile));
    categories.add(await _getChallengeNumber(profile));
    categories.add(await _getNameNumber(profile));
    categories.add(await _getDesireNumber(profile));
    categories.add(await _getWeddingNumber(profile));
    categories.add(await _getExpressionNumber(profile));
    categories.add(await _getRealizationNumber(profile));
    categories.add(await _getPersonalityNumber(profile));
    categories.add(await _getMaturityNumber(profile));
    categories.add(await _getBirthdayCode(profile));
    categories.add(await _getMoneyNumber(profile));
    categories.add(await _getBirthdayNumber(profile));
    categories.add(await _getLuckyGemModel(profile));

    return categories;
  }

  @override
  List<double> getPersonalBio(Profile profile) {
    return CategoryCalc.instance.calcBio(profile);
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    return CategoryModel(
      name: 'Numero del giorno',
      imagePath: day,
      type: CategoryType.dayCategory,
      dayContent: await CategoryProvider.instance.getDayContent(profile),
    );
  }

  Future<CategoryModel> _getMoneyNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero del denaro',
      imagePath: money,
      type: CategoryType.moneyCategory,
    );
  }

  Future<CategoryModel> _getSecondBio(Profile profile) async {
    return CategoryModel(
      name: 'Bioritmi secondari',
      imagePath: secondaryBio,
      type: CategoryType.bioSecondCategory,
    );
  }

  Future<CategoryModel> _getCompat(Profile profile) async {
    return CategoryModel(
      name: 'Compatibilità',
      imagePath: compatibility,
      type: CategoryType.compatCategory,
    );
  }

  Future<CategoryModel> _getWeddingNumber(Profile profile) async {
    return CategoryModel(
      name: 'Psicomatrice',
      imagePath: marriage,
      type: CategoryType.weddingNumCategory,
    );
  }

  Future<CategoryModel> _getSoulNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero dell\'Anima',
      imagePath: soul,
      type: CategoryType.soulNumCategory,
    );
  }

  Future<CategoryModel> _getDesireNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero del desiderio',
      imagePath: desire,
      type: CategoryType.desireNumCategory,
    );
  }

  Future<CategoryModel> _getNameNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero del nome',
      imagePath: name,
      type: CategoryType.nameNumCategory,
    );
  }

  Future<CategoryModel> _getExpressionNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero di espressione',
      imagePath: expression,
      type: CategoryType.expressionNumCategory,
    );
  }

  Future<CategoryModel> _getRealizationNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero Realizzazione',
      imagePath: work,
      type: CategoryType.realizationNumCategory,
    );
  }

  Future<CategoryModel> _getChallengeNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero di sfida',
      imagePath: challenge,
      type: CategoryType.challengeNumCategory,
    );
  }

  Future<CategoryModel> _getLifePathNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero del percorso di vita',
      imagePath: lifePath,
      type: CategoryType.lifePathNumCategory,
    );
  }

  Future<CategoryModel> _getPersonalityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero della personalità',
      imagePath: personality,
      type: CategoryType.personalityNumCategory,
    );
  }

  Future<CategoryModel> _getBirthdayCode(Profile profile) async {
    return CategoryModel(
      name: 'Codice di compleanno',
      imagePath: birthdayCode,
      type: CategoryType.birthdayCodeCategory,
    );
  }

  Future<CategoryModel> _getLuckyGemModel(Profile profile) async {
    return CategoryModel(
      name: 'Gemma fortunata',
      imagePath: luckyGem,
      type: CategoryType.luckyGemCategory,
    );
  }

  Future<CategoryModel> _getBirthdayNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero di compleanno',
      imagePath: birthdayNum,
      type: CategoryType.birthdayNumCategory,
    );
  }

  Future<CategoryModel> _getMaturityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero Maturità',
      imagePath: maturity,
      type: CategoryType.maturityNumCategory,
    );
  }
}
