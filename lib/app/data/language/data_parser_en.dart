import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/data_provider/numerology_helper.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/description_page.dart';

import '../models/category_model.dart';

class DataParserEn extends DataParser {
  const DataParserEn();

  @override
  List<CategoryModel> getCategories() {
    List<CategoryModel> categories = [];

    categories
        .add(CategoryModel(imagePath: compatibility, text: 'Compatibility'));
    categories.add(
        CategoryModel(imagePath: secondaryBio, text: 'Secondary Biorhythms'));
    categories
        .add(CategoryModel(imagePath: lifePath, text: 'Life Path Number'));
    categories.add(CategoryModel(imagePath: matrix, text: 'Psychomatrix'));
    categories
        .add(CategoryModel(imagePath: matrixLines, text: 'Psychomatrix Lines'));
    categories.add(CategoryModel(imagePath: soul, text: 'Soul number'));
    categories
        .add(CategoryModel(imagePath: challenge, text: 'Challenge number'));
    categories.add(CategoryModel(imagePath: name, text: 'Name number'));
    categories.add(CategoryModel(imagePath: desire, text: 'Desire number'));
    categories.add(CategoryModel(imagePath: marriage, text: 'Marriage number'));
    categories
        .add(CategoryModel(imagePath: expression, text: 'Expression number'));
    categories.add(CategoryModel(imagePath: work, text: 'Realization number'));
    categories
        .add(CategoryModel(imagePath: personality, text: 'Personality number'));
    categories.add(CategoryModel(imagePath: maturity, text: 'Maturity number'));
    categories
        .add(CategoryModel(imagePath: birthdayCode, text: 'Birthday code'));
    categories
        .add(CategoryModel(imagePath: birthdayNum, text: 'Birthday number'));
    categories.add(CategoryModel(imagePath: luckyGem, text: 'Lucky gem'));

    return categories;
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile);
    var query = 'select description from PERSONAL_DAY_ENG where number = ' +
        calculation.toString();
    var fromMap = (map) => map['description'] as String;

    var description = await NumerologyDBProvider.instance.getEntity(
      query,
      fromMap,
    );

    var infoQuery =
        'select description from TABLE_DESCRIPTION where table_name = "PERSONAL_DAY_ENG"';
    var infoFromMap = (map) => map['description'] as String;

    var info = await NumerologyDBProvider.instance.getEntity(
      infoQuery,
      infoFromMap,
    );

    String categoryName = 'Day number';

    return CategoryModel(
        imagePath: day,
        text: categoryName,
        calculation: calculation,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          description: description,
          info: info,
        ));
  }
}
