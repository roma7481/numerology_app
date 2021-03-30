import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/description_page.dart';

import '../models/category_model.dart';
import 'parser_utils.dart';

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
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile).toString();

    var description = await getEntity(
        table: 'PERSONAL_DAY_RUS',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"PERSONAL_DAY_RUS\"');

    String categoryName = 'Число дня';

    return CategoryModel(
        imagePath: day,
        text: categoryName,
        calculation: calculation,
        content: description,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          description: description,
          info: info,
        ));
  }
}
