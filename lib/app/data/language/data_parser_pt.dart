import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';
import 'calc_utils.dart';

class DataParserPt extends DataParser {
  const DataParserPt();

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
      name: 'Número de día',
      imagePath: day,
      type: CategoryType.dayCategory,
      dayContent: await CategoryProvider.instance.getDayContent(profile),
    );
  }

  Future<CategoryModel> _getMoneyNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número do Dinheiro',
      imagePath: money,
      type: CategoryType.moneyCategory,
    );
  }

  Future<CategoryModel> _getSecondBio(Profile profile) async {
    return CategoryModel(
      name: 'Biorritmos Secundários',
      imagePath: secondaryBio,
      type: CategoryType.bioSecondCategory,
    );
  }

  Future<CategoryModel> _getCompat(Profile profile) async {
    return CategoryModel(
      name: 'Compatibilidade',
      imagePath: compatibility,
      type: CategoryType.compatCategory,
    );
  }

  Future<CategoryModel> _getWeddingNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número de Casamento',
      imagePath: marriage,
      type: CategoryType.weddingNumCategory,
    );
  }

  Future<CategoryModel> _getSoulNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número da Alma',
      imagePath: soul,
      type: CategoryType.soulNumCategory,
    );
  }

  Future<CategoryModel> _getDesireNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número do Desejo',
      imagePath: desire,
      type: CategoryType.desireNumCategory,
    );
  }

  Future<CategoryModel> _getNameNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número do Nome',
      imagePath: name,
      type: CategoryType.nameNumCategory,
    );
  }

  Future<CategoryModel> _getExpressionNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número da Expressão',
      imagePath: expression,
      type: CategoryType.expressionNumCategory,
    );
  }

  Future<CategoryModel> _getRealizationNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número de Realização',
      imagePath: work,
      type: CategoryType.realizationNumCategory,
    );
  }

  Future<CategoryModel> _getChallengeNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número do Desafio',
      imagePath: challenge,
      type: CategoryType.challengeNumCategory,
    );
  }

  Future<CategoryModel> _getLifePathNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número do Caminho de Vida',
      imagePath: lifePath,
      type: CategoryType.lifePathNumCategory,
    );
  }

  Future<CategoryModel> _getPersonalityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número de Personalidade',
      imagePath: personality,
      type: CategoryType.personalityNumCategory,
    );
  }

  Future<CategoryModel> _getBirthdayCode(Profile profile) async {
    return CategoryModel(
      name: 'Código de Data de Nascimento',
      imagePath: birthdayCode,
      type: CategoryType.birthdayCodeCategory,
    );
  }

  Future<CategoryModel> _getLuckyGemModel(Profile profile) async {
    return CategoryModel(
      name: 'Joia da Sorte',
      imagePath: luckyGem,
      type: CategoryType.luckyGemCategory,
    );
  }

  Future<CategoryModel> _getBirthdayNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número de Data de Nascimento',
      imagePath: birthdayNum,
      type: CategoryType.birthdayNumCategory,
    );
  }

  Future<CategoryModel> _getMaturityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número de Maturidade',
      imagePath: maturity,
      type: CategoryType.maturityNumCategory,
    );
  }
}
