import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/calc_utils.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';

class DataParserEs extends DataParser {
  @override
  Future<List<CategoryModel>> getCategories(Profile profile) async {
    List<CategoryModel> categories = [];

    // categories.add(
    //     CategoryModel(imagePath: compatibility, name: 'Compatibilidad total'));
    // categories.add(
    //     CategoryModel(imagePath: secondaryBio, name: 'Biorritmos secundarios'));
    // categories.add(
    //     CategoryModel(imagePath: lifePath, name: 'Número del camino de vida'));
    // categories.add(CategoryModel(imagePath: soul, name: 'Numero del alma'));
    // categories.add(CategoryModel(
    //     imagePath: achievement, name: 'Números de los Pináculos'));
    // categories
    //     .add(CategoryModel(imagePath: challenge, name: 'Números de desafío'));
    // categories.add(CategoryModel(imagePath: name, name: 'Numero de Nombre'));

    // categories
    //     .add(CategoryModel(imagePath: potential, name: 'Numero Potencial'));
    // categories.add(CategoryModel(imagePath: karma, name: 'Ley Karmica'));

    categories.add(await _getExpressionNumber(profile));
    categories.add(await _getPersonalityNumber(profile));
    categories.add(await _getBirthdayNumber(profile));
    categories.add(await _getMaturityNumber(profile));
    categories.add(await _getBirthdayCode(profile));
    return categories;
  }

  Future<CategoryModel> _getExpressionNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número de Expresión',
      imagePath: expression,
      type: CategoryType.expressionNumCategory,
    );
  }

  Future<CategoryModel> _getPersonalityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero de Personalidad',
      imagePath: personality,
      type: CategoryType.personalityNumCategory,
    );
  }

  Future<CategoryModel> _getBirthdayNumber(Profile profile) async {
    return CategoryModel(
      name: 'Numero del dia de nacimiento',
      imagePath: birthdayNum,
      type: CategoryType.birthdayNumCategory,
    );
  }

  Future<CategoryModel> _getMaturityNumber(Profile profile) async {
    return CategoryModel(
      name: 'Número de la madurez',
      imagePath: maturity,
      type: CategoryType.maturityNumCategory,
    );
  }

  Future<CategoryModel> _getBirthdayCode(Profile profile) async {
    return CategoryModel(
      name: 'Numero de Nacimiento',
      imagePath: birthdayCode,
      type: CategoryType.birthdayCodeCategory,
    );
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    return CategoryModel(
      name: 'Número de día personal',
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
