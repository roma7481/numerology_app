import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';

class DataParserEs extends DataParser {
  @override
  Future<List<CategoryModel>> getCategories(Profile profile) async {
    List<CategoryModel> categories = [];

    categories.add(
        CategoryModel(imagePath: compatibility, name: 'Compatibilidad total'));
    categories.add(
        CategoryModel(imagePath: secondaryBio, name: 'Biorritmos secundarios'));
    categories.add(
        CategoryModel(imagePath: lifePath, name: 'Número del camino de vida'));
    categories.add(CategoryModel(imagePath: soul, name: 'Numero del alma'));
    categories.add(CategoryModel(
        imagePath: achievement, name: 'Números de los Pináculos'));
    categories
        .add(CategoryModel(imagePath: challenge, name: 'Números de desafío'));
    categories.add(CategoryModel(imagePath: name, name: 'Numero de Nombre'));
    categories
        .add(CategoryModel(imagePath: expression, name: 'Número de Expresión'));
    categories.add(
        CategoryModel(imagePath: personality, name: 'Numero de Personalidad'));
    categories
        .add(CategoryModel(imagePath: maturity, name: 'Número de la madurez'));
    categories.add(
        CategoryModel(imagePath: birthdayCode, name: 'Numero de Nacimiento'));
    categories.add(CategoryModel(
        imagePath: birthdayNum, name: 'Numero del dia de nacimiento'));
    categories
        .add(CategoryModel(imagePath: potential, name: 'Numero Potencial'));
    categories.add(CategoryModel(imagePath: karma, name: 'Ley Karmica'));

    return categories;
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile).toString();

// /*    var description = await getEntity(
//         table: 'PERSONAL_DAY_ESP',
//         queryColumn: 'number',
//         resColumn: 'description',
//         value: calculation);
//     var info = await getEntity(
//         table: 'TABLE_DESCRIPTION',
//         queryColumn: 'table_name',
//         resColumn: 'description',
//         value: '\"PERSONAL_DAY_ESP\"');*/
//
//     String categoryName = 'Número de día personal';
//
//     var language = Globals.instance.language;
//     Map<String, String> cards = {
//       language.description: description,
//       language.info: info
//     };

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
