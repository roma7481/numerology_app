import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/description_page.dart';

import '../models/category_model.dart';

class DataParserEs extends DataParser {
  @override
  Future<List<CategoryModel>> getCategories(Profile profile) async {
    List<CategoryModel> categories = [];

    categories.add(
        CategoryModel(imagePath: compatibility, text: 'Compatibilidad total'));
    categories.add(
        CategoryModel(imagePath: secondaryBio, text: 'Biorritmos secundarios'));
    categories.add(
        CategoryModel(imagePath: lifePath, text: 'Número del camino de vida'));
    categories.add(CategoryModel(imagePath: soul, text: 'Numero del alma'));
    categories.add(CategoryModel(
        imagePath: achievement, text: 'Números de los Pináculos'));
    categories
        .add(CategoryModel(imagePath: challenge, text: 'Números de desafío'));
    categories.add(CategoryModel(imagePath: name, text: 'Numero de Nombre'));
    categories
        .add(CategoryModel(imagePath: expression, text: 'Número de Expresión'));
    categories.add(
        CategoryModel(imagePath: personality, text: 'Numero de Personalidad'));
    categories
        .add(CategoryModel(imagePath: maturity, text: 'Número de la madurez'));
    categories.add(
        CategoryModel(imagePath: birthdayCode, text: 'Numero de Nacimiento'));
    categories.add(CategoryModel(
        imagePath: birthdayNum, text: 'Numero del dia de nacimiento'));
    categories
        .add(CategoryModel(imagePath: potential, text: 'Numero Potencial'));
    categories.add(CategoryModel(imagePath: karma, text: 'Ley Karmica'));

    return categories;
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile).toString();

    var description = await getEntity(
        table: 'PERSONAL_DAY_ESP',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"PERSONAL_DAY_ESP\"');

    String categoryName = 'Número de día personal';

    return CategoryModel(
        imagePath: day,
        text: categoryName,
        content: description,
        calculation: calculation,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          cards: {},
        ));
  }
}
