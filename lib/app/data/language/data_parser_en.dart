import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/description_name_page.dart';
import 'package:numerology/app/presentation/pages/description/description_page.dart';

import '../models/category_model.dart';
import 'parser_utils.dart';

class DataParserEn extends DataParser {
  const DataParserEn();

  @override
  Future<List<CategoryModel>> getCategories(Profile profile) async {
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
    categories.add(_getSoulNumber(profile));
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
    categories.add(await _getBirthdayCode(profile));
    categories.add(await _getBirthdayNumber(profile));
    categories.add(await _getLuckyGemModel(profile));

    return categories;
  }

  Future<CategoryModel> _getBirthdayCode(Profile profile) async {
    var calculation =
        CategoryCalc.instance.calcBirthdayCode(profile).toString();

    var description = await getEntity(
        table: 'BIRTHDAY_CODE_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"BIRTHDAY_CODE_ENG\"');

    String categoryName = 'Birthday code';

    return CategoryModel(
        imagePath: birthdayCode,
        text: categoryName,
        content: description,
        calculation: calculation,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          description: description,
          info: info,
        ));
  }

  Future<CategoryModel> _getLuckyGemModel(Profile profile) async {
    var calculation = CategoryCalc.instance.calcLuckGem(profile).toString();

    var description = await getEntity(
        table: 'LUCKY_GEM_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"LUCKY_GEM_ENG\"');

    String categoryName = 'Lucky gem';

    return CategoryModel(
        imagePath: luckyGem,
        text: categoryName,
        content: description,
        calculation: calculation,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          description: description,
          info: info,
        ));
  }

  Future<CategoryModel> _getBirthdayNumber(Profile profile) async {
    var calculation = DateService.fromTimestamp(profile.dob).day.toString();

    var description = await getEntity(
        table: 'BIRTHDAY_NUMBER_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"BIRTHDAY_NUMBER_ENG\"');

    String categoryName = 'Birthday number';

    return CategoryModel(
        imagePath: birthdayNum,
        text: categoryName,
        content: description,
        calculation: calculation,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          description: description,
          info: info,
        ));
  }

  CategoryModel _getSoulNumber(Profile profile) {
    DescriptionPage descriptionPage = DescriptionPage();

    if (profile.firstName.isNotEmpty ||
        profile.lastName.isNotEmpty ||
        profile.middleName.isNotEmpty) {
      descriptionPage = DescriptionPage(
        header: 'categoryName',
        calculation: '23',
        description: 'description',
        info: 'info',
      );
    }

    var categoryName = 'Soul number';
    return CategoryModel(
        imagePath: soul,
        text: categoryName,
        page: DescriptionNameBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile).toString();

    var description = await getEntity(
        table: 'PERSONAL_DAY_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"PERSONAL_DAY_ENG\"');

    String categoryName = 'Day number';

    return CategoryModel(
        imagePath: day,
        text: categoryName,
        content: description,
        calculation: calculation,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          description: description,
          info: info,
        ));
  }
}
