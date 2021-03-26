import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';

class DataParserRu extends DataParser {
  @override
  List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];
    categories
        .add(CategoryModel(imagePath: compatibility, text: 'Совместимость'));
    categories.add(CategoryModel(
        imagePath: secondaryBio, text: 'Второстепенные Биоритмы'));
    categories.add(CategoryModel(
        imagePath: bioCompatibility, text: 'Совместимость биоритмов'));
    categories.add(CategoryModel(imagePath: matrix, text: 'Квадрат Пифагора'));
    categories
        .add(CategoryModel(imagePath: matrixLines, text: 'Линии Психоматрицы'));
    categories
        .add(CategoryModel(imagePath: lifePath, text: 'Число жизненного Пути'));
    categories.add(CategoryModel(imagePath: soul, text: 'Число Души'));
    categories.add(CategoryModel(imagePath: achievement, text: 'Число Пика'));
    categories
        .add(CategoryModel(imagePath: challenge, text: 'Число Испытания'));
    categories.add(CategoryModel(imagePath: name, text: 'Число имени'));
    categories.add(CategoryModel(imagePath: marriage, text: 'Число Брака'));
    categories.add(CategoryModel(imagePath: love, text: 'Число Любви'));
    categories
        .add(CategoryModel(imagePath: character, text: 'Число Характера'));
    categories
        .add(CategoryModel(imagePath: expression, text: 'Число Экспрессии'));
    categories.add(CategoryModel(imagePath: work, text: 'Число Реализации'));
    categories
        .add(CategoryModel(imagePath: personality, text: 'Число Личности'));
    categories
        .add(CategoryModel(imagePath: intelligence, text: 'Число Разума'));
    categories.add(CategoryModel(imagePath: balance, text: 'Число Равновесия'));
    categories.add(CategoryModel(imagePath: maturity, text: 'Число Зрелости'));
    categories
        .add(CategoryModel(imagePath: birthdayCode, text: 'Код дня рождения'));
    categories
        .add(CategoryModel(imagePath: birthdayNum, text: 'Число Дня Рождения'));
    categories.add(CategoryModel(imagePath: money, text: 'Число Денег'));
    categories.add(CategoryModel(imagePath: luckyGem, text: 'Камень Удачи'));

    return categories;
  }

  @override
  CategoryModel getPersonalDay(Profile profile) {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile);
    return CategoryModel(imagePath: day, text: 'Персональное Число дня', calculation: calculation);
  }
}
