import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';

class DataParserRu extends DataParser {
  @override
  Future<List<CategoryModel>> getCategories(Profile profile) async {
    List<CategoryModel> categories = [];
    categories
        .add(CategoryModel(imagePath: compatibility, name: 'Совместимость'));
    categories.add(CategoryModel(
        imagePath: secondaryBio, name: 'Второстепенные Биоритмы'));
    categories.add(CategoryModel(
        imagePath: bioCompatibility, name: 'Совместимость биоритмов'));
    categories.add(CategoryModel(imagePath: matrix, name: 'Квадрат Пифагора'));
    categories
        .add(CategoryModel(imagePath: matrixLines, name: 'Линии Психоматрицы'));
    categories
        .add(CategoryModel(imagePath: lifePath, name: 'Число жизненного Пути'));
    categories.add(CategoryModel(imagePath: soul, name: 'Число Души'));
    categories.add(CategoryModel(imagePath: achievement, name: 'Число Пика'));
    categories
        .add(CategoryModel(imagePath: challenge, name: 'Число Испытания'));
    categories.add(CategoryModel(imagePath: name, name: 'Число имени'));
    categories.add(CategoryModel(imagePath: marriage, name: 'Число Брака'));
    categories.add(CategoryModel(imagePath: love, name: 'Число Любви'));
    categories
        .add(CategoryModel(imagePath: character, name: 'Число Характера'));
    categories
        .add(CategoryModel(imagePath: expression, name: 'Число Экспрессии'));
    categories.add(CategoryModel(imagePath: work, name: 'Число Реализации'));
    categories
        .add(CategoryModel(imagePath: personality, name: 'Число Личности'));
    categories
        .add(CategoryModel(imagePath: intelligence, name: 'Число Разума'));
    categories.add(CategoryModel(imagePath: balance, name: 'Число Равновесия'));
    categories.add(CategoryModel(imagePath: maturity, name: 'Число Зрелости'));
    categories
        .add(CategoryModel(imagePath: birthdayCode, name: 'Код дня рождения'));
    categories
        .add(CategoryModel(imagePath: birthdayNum, name: 'Число Дня Рождения'));
    categories.add(CategoryModel(imagePath: money, name: 'Число Денег'));
    categories.add(CategoryModel(imagePath: luckyGem, name: 'Камень Удачи'));

    return categories;
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    // var calculation = CategoryCalc.instance.calcPersonalDay(profile).toString();
    //
    // var description = await getEntity(
    //     table: 'PERSONAL_DAY_RUS',
    //     queryColumn: 'number',
    //     resColumn: 'description',
    //     value: calculation);
    // var info = await getEntity(
    //     table: 'TABLE_DESCRIPTION',
    //     queryColumn: 'table_name',
    //     resColumn: 'description',
    //     value: '\"PERSONAL_DAY_RUS\"');
    //
    // String categoryName = 'Число дня';
    //
    // var language = Globals.instance.language;
    // Map<String, String> cards = {
    //   language.description: description,
    //   language.info: info
    // };

    // return CategoryModel(
    //     imagePath: day,
    //     text: categoryName,
    //     content: description,
    //     page: DescriptionPage(
    //       header: categoryName,
    //       calculation: calculation,
    //       description: cards,
    //     ));

    return null;
  }

  @override
  List<double> getPersonalBio(Profile profile) {
    return CategoryCalc.instance.calcBio(profile);
  }
}
