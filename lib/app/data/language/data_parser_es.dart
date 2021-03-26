import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';

import '../models/category_model.dart';

class DataParserEs extends DataParser {
  @override
  List<CategoryModel> getCategories() {
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
  CategoryModel getPersonalDay(Profile profile) {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile);
    return CategoryModel(imagePath: day, text: 'Número de día personal', calculation: calculation);
  }
}
