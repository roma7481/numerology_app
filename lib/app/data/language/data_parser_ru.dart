import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';
import 'calc_utils.dart';

class DataParserRu extends DataParser {
  @override
  Future<List<CategoryModel>> getCategories(Profile profile) async {
    List<CategoryModel> categories = [];

    categories.add(await _getCompat(profile));
    categories.add(await _getSecondBio(profile));
    categories.add(await _getMatrix(profile));
    categories.add(await _getMatrixLines(profile));
    categories.add(await _getBalanceNumber(profile));
    categories.add(await _getMoneyNumber(profile));
    categories.add(await _getIntelligence(profile));
    categories.add(await _getMarriageNumber(profile));
    categories.add(await _getCharacter(profile));
    categories.add(await _getAchievement(profile));
    categories.add(await _getChallengeNumber(profile));
    categories.add(await _getLifePathNumber(profile));
    categories.add(await _getLoveNumber(profile));
    categories.add(await _getSoulNumber(profile));
    categories.add(await _getNameNumber(profile));
    categories.add(await _getExpressionNumber(profile));
    categories.add(await _getPersonalityNumber(profile));
    categories.add(await _getLuckyGemModel(profile));
    categories.add(await _getBirthdayNumber(profile));
    categories.add(await _getBirthdayCode(profile));
    categories.add(await _getRealizationNumber(profile));
    categories.add(await _getMaturityNumber(profile));

    return categories;
  }

  Future<CategoryModel> _getLoveNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Любви',
      imagePath: love,
      type: CategoryType.loveCategory,
    );
  }

  Future<CategoryModel> _getMarriageNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Брака',
      imagePath: marriage,
      type: CategoryType.marriageCategory,
    );
  }

  Future<CategoryModel> _getBalanceNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Равновесия',
      imagePath: balance,
      type: CategoryType.balanceCategory,
    );
  }

  Future<CategoryModel> _getMoneyNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Денег',
      imagePath: money,
      type: CategoryType.moneyCategory,
    );
  }

  Future<CategoryModel> _getIntelligence(Profile profile) async {
    return CategoryModel(
      name: 'Число Разума',
      imagePath: intelligence,
      type: CategoryType.intelligenceCategory,
    );
  }

  Future<CategoryModel> _getCharacter(Profile profile) async {
    return CategoryModel(
      name: 'Число Характера',
      imagePath: character,
      type: CategoryType.characterCategory,
    );
  }

  Future<CategoryModel> _getAchievement(Profile profile) async {
    return CategoryModel(
      name: 'Число Пика',
      imagePath: achievement,
      type: CategoryType.achievementCategory,
    );
  }

  Future<CategoryModel> _getCompat(Profile profile) async {
    return CategoryModel(
      name: 'Совместимость',
      imagePath: compatibility,
      type: CategoryType.compatCategory,
    );
  }

  Future<CategoryModel> _getSecondBio(Profile profile) async {
    return CategoryModel(
      name: 'Второстепенные Биоритмы',
      imagePath: secondaryBio,
      type: CategoryType.bioSecondCategory,
    );
  }

  Future<CategoryModel> _getMatrix(Profile profile) async {
    return CategoryModel(
      name: 'Квадрат Пифагора',
      imagePath: matrix,
      type: CategoryType.matrixCategory,
    );
  }

  Future<CategoryModel> _getMatrixLines(Profile profile) async {
    return CategoryModel(
      name: 'Линии Психоматрицы',
      imagePath: matrixLines,
      type: CategoryType.matrixLinesCategory,
    );
  }

  Future<CategoryModel> _getChallengeNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Испытания',
      imagePath: challenge,
      type: CategoryType.challengeNumCategory,
    );
  }

  Future<CategoryModel> _getLifePathNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число жизненного Пути',
      imagePath: lifePath,
      type: CategoryType.lifePathNumCategory,
    );
  }

  Future<CategoryModel> _getSoulNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Души',
      imagePath: soul,
      type: CategoryType.soulNumCategory,
    );
  }

  Future<CategoryModel> _getNameNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число имени',
      imagePath: name,
      type: CategoryType.nameNumCategory,
    );
  }

  Future<CategoryModel> _getExpressionNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Экспрессии',
      imagePath: expression,
      type: CategoryType.expressionNumCategory,
    );
  }

  Future<CategoryModel> _getPersonalityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Личности',
      imagePath: personality,
      type: CategoryType.personalityNumCategory,
    );
  }

  Future<CategoryModel> _getMaturityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Зрелости',
      imagePath: maturity,
      type: CategoryType.maturityNumCategory,
    );
  }

  Future<CategoryModel> _getRealizationNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Реализации',
      imagePath: work,
      type: CategoryType.realizationNumCategory,
    );
  }

  Future<CategoryModel> _getBirthdayCode(Profile profile) async {
    return CategoryModel(
      name: 'Код дня рождения',
      imagePath: birthdayCode,
      type: CategoryType.birthdayCodeCategory,
    );
  }

  Future<CategoryModel> _getBirthdayNumber(Profile profile) async {
    return CategoryModel(
      name: 'Число Дня Рождения',
      imagePath: birthdayNum,
      type: CategoryType.birthdayNumCategory,
    );
  }

  Future<CategoryModel> _getLuckyGemModel(Profile profile) async {
    return CategoryModel(
      name: 'Камень Удачи',
      imagePath: luckyGem,
      type: CategoryType.luckyGemCategory,
    );
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    return CategoryModel(
      name: 'Число дня',
      imagePath: day,
      type: CategoryType.dayCategory,
      dayContent: await CategoryProvider.instance.getDayContent(profile),
    );
  }

  @override
  List<double> getPersonalBio(Profile profile) {
    return CategoryCalc.instance.calcBio(profile);
  }
}
