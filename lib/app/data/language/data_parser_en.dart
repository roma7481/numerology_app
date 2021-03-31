import 'package:numerology/app/business_logic/globals/globals.dart';
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
    categories.add(await _getLifePathNumber(profile));
    categories.add(CategoryModel(imagePath: matrix, text: 'Psychomatrix'));
    categories
        .add(CategoryModel(imagePath: matrixLines, text: 'Psychomatrix Lines'));
    categories.add(await _getSoulNumber(profile));
    categories.add(await _getChallengeNumber(profile));
    categories.add(await _getNameNumber(profile));
    categories.add(await _getDesireNumber(profile));
    categories.add(CategoryModel(imagePath: marriage, text: 'Marriage number'));
    categories.add(await _getExpressionNumber(profile));
    categories.add(CategoryModel(imagePath: work, text: 'Realization number'));
    categories.add(await _getPersonalityNumber(profile));
    categories.add(CategoryModel(imagePath: maturity, text: 'Maturity number'));
    categories.add(await _getBirthdayCode(profile));
    categories.add(await _getBirthdayNumber(profile));
    categories.add(await _getLuckyGemModel(profile));

    return categories;
  }

  Future<CategoryModel> _getDesireNumber(Profile profile) async {
    DescriptionPage descriptionPage = DescriptionPage();
    var categoryName = 'Desire number';

    if (_isNameSet(profile)) {
      var calculation = CategoryCalc.instance.calcDesireNumber(profile);

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation.toString(),
        description: await getDescription('DESIRE_NUMBER_ENG', calculation),
      );
    }

    return CategoryModel(
        imagePath: desire,
        text: categoryName,
        page: DescriptionNameBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  Future<CategoryModel> _getPersonalityNumber(Profile profile) async {
    DescriptionPage descriptionPage = DescriptionPage();
    var categoryName = 'Personality number';

    if (_isNameSet(profile)) {
      var calculation = CategoryCalc.instance.calcPersonalityNumber(profile);

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation.toString(),
        description:
            await getDescription('PERSONALITY_NUMBER_ENG', calculation),
      );
    }

    return CategoryModel(
        imagePath: personality,
        text: categoryName,
        page: DescriptionNameBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  Future<CategoryModel> _getExpressionNumber(Profile profile) async {
    DescriptionPage descriptionPage = DescriptionPage();
    var categoryName = 'Expression number';

    if (_isNameSet(profile)) {
      var calculation = CategoryCalc.instance.calcExpressionNumber(profile);

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation.toString(),
        description: await getDescription('EXPRESSION_NUMBER_ENG', calculation),
      );
    }

    return CategoryModel(
        imagePath: expression,
        text: categoryName,
        page: DescriptionNameBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  Future<CategoryModel> _getNameNumber(Profile profile) async {
    DescriptionPage descriptionPage = DescriptionPage();
    var categoryName = 'Name number';

    if (_isNameSet(profile)) {
      var calculation = CategoryCalc.instance.calcNameNumber(profile);

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation.toString(),
        description: await getDescription('NAME_NUMBER_ENG', calculation),
      );
    }

    return CategoryModel(
        imagePath: name,
        text: categoryName,
        page: DescriptionNameBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    var calculation = CategoryCalc.instance.calcPersonalDay(profile);

    String categoryName = 'Day number';

    var description = await getDescription('PERSONAL_DAY_ENG', calculation);
    return CategoryModel(
        imagePath: day,
        text: categoryName,
        content: description.values.first,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation.toString(),
          description: description,
        ));
  }

  Future<CategoryModel> _getChallengeNumber(Profile profile) async {
    var calculation1 =
        CategoryCalc.instance.calcChallengeNum1(profile).toString();
    var calculation2 =
        CategoryCalc.instance.calcChallengeNum2(profile).toString();
    var calculation3 =
        CategoryCalc.instance.calcChallengeNum3(profile).toString();
    var calculation4 =
        CategoryCalc.instance.calcChallengeNum4(profile).toString();

    var description1 = await getEntity(
        table: 'CHALLENGE_NUMBER_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation1);
    var description2 = await getEntity(
        table: 'CHALLENGE_NUMBER_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation1);
    var description3 = await getEntity(
        table: 'CHALLENGE_NUMBER_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation1);
    var description4 = await getEntity(
        table: 'CHALLENGE_NUMBER_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation1);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"CHALLENGE_NUMBER_ENG\"');

    Map<String, String> cards = {
      'The First Challenge - $calculation1': description1,
      'The Second Challenge - $calculation2': description2,
      'The Third Challenge - $calculation3': description3,
      'The Fourth Challenge - $calculation4': description4,
      Globals.instance.language.info: info
    };

    String categoryName = 'Challenge number';

    return CategoryModel(
        imagePath: challenge,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          description: cards,
        ));
  }

  Map<String, String> _fromMapLifePath(Map<String, dynamic> map) {
    return {
      'Description': map['description'] as String,
      'Profession': map['profession'] as String,
      'Finances': map['finances'] as String,
      'Relationship': map['relationships'] as String,
      'Health': map['health'] as String,
      'Negative': map['negative'] as String,
    };
  }

  Future<CategoryModel> _getLifePathNumber(Profile profile) async {
    var calculation =
        CategoryCalc.instance.calcLifePathNumberMethod1(profile).toString();

    Map<String, String> cards = await getEntityAdvanced(
      table: 'LIFE_PATH_NUMBER_ENG',
      queryColumn: 'number',
      resColumn: 'description',
      value: calculation,
      fromMap: (map) => _fromMapLifePath(map),
    );
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"LIFE_PATH_NUMBER_ENG\"');

    String categoryName = 'Life Path Number';

    var language = Globals.instance.language;
    cards.addAll({language.info: info});

    return CategoryModel(
        imagePath: lifePath,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          description: cards,
        ));
  }

  Future<CategoryModel> _getBirthdayCode(Profile profile) async {
    var calculation = CategoryCalc.instance.calcBirthdayCode(profile);
    String categoryName = 'Birthday code';

    return CategoryModel(
        imagePath: birthdayCode,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation.toString(),
          description: await getDescription('BIRTHDAY_CODE_ENG', calculation),
        ));
  }

  Future<CategoryModel> _getLuckyGemModel(Profile profile) async {
    var calculation = CategoryCalc.instance.calcLuckGem(profile);
    String categoryName = 'Lucky Gem';

    return CategoryModel(
        imagePath: luckyGem,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation.toString(),
          description: await getDescription('LUCKY_GEM_ENG', calculation),
        ));
  }

  Future<CategoryModel> _getBirthdayNumber(Profile profile) async {
    var calculation = DateService.fromTimestamp(profile.dob).day;
    String categoryName = 'Birthday number';

    return CategoryModel(
        imagePath: birthdayNum,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation.toString(),
          description: await getDescription('BIRTHDAY_NUMBER_ENG', calculation),
        ));
  }

  Future<CategoryModel> _getSoulNumber(Profile profile) async {
    DescriptionPage descriptionPage = DescriptionPage();
    var categoryName = 'Soul number';

    if (_isNameSet(profile)) {
      var calculation = CategoryCalc.instance.calcSoulNumber(profile);

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation.toString(),
        description: await getDescription('BIRTHDAY_NUMBER_ENG', calculation),
      );
    }

    return CategoryModel(
        imagePath: soul,
        text: categoryName,
        page: DescriptionNameBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  bool _isNameSet(Profile profile) {
    return profile.firstName.isNotEmpty ||
        profile.lastName.isNotEmpty ||
        profile.middleName.isNotEmpty;
  }
}
