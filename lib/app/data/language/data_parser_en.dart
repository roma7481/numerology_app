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

  Future<CategoryModel> _getNameNumber(Profile profile) async {
    var calculation = CategoryCalc.instance.calcNameNumber(profile).toString();

    var description = await getEntity(
        table: 'NAME_NUMBER_ENG',
        queryColumn: 'number',
        resColumn: 'description',
        value: calculation);
    var info = await getEntity(
        table: 'TABLE_DESCRIPTION',
        queryColumn: 'table_name',
        resColumn: 'description',
        value: '\"NAME_NUMBER_ENG\"');

    String categoryName = 'Name number';

    var language = Globals.instance.language;
    Map<String, String> cards = {
      language.description: description,
      language.info: info
    };

    return CategoryModel(
        imagePath: name,
        text: categoryName,
        content: description,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          cards: cards,
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

    var language = Globals.instance.language;
    Map<String, String> cards = {
      language.description: description,
      language.info: info
    };

    return CategoryModel(
        imagePath: day,
        text: categoryName,
        content: description,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          cards: cards,
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
          cards: cards,
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
          cards: cards,
        ));
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

    var language = Globals.instance.language;
    Map<String, String> cards = {
      language.description: description,
      language.info: info
    };

    return CategoryModel(
        imagePath: birthdayCode,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          cards: cards,
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

    String categoryName = 'Lucky Gem';

    var language = Globals.instance.language;
    Map<String, String> cards = {
      language.description: description,
      language.info: info
    };

    return CategoryModel(
        imagePath: luckyGem,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          cards: cards,
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

    var language = Globals.instance.language;
    Map<String, String> cards = {
      language.description: description,
      language.info: info
    };

    return CategoryModel(
        imagePath: birthdayNum,
        text: categoryName,
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation,
          cards: cards,
        ));
  }

  Future<CategoryModel> _getSoulNumber(Profile profile) async {
    DescriptionPage descriptionPage = DescriptionPage();
    var categoryName = 'Soul number';

    if (profile.firstName.isNotEmpty ||
        profile.lastName.isNotEmpty ||
        profile.middleName.isNotEmpty) {
      var calculation =
          CategoryCalc.instance.calcSoulNumber(profile).toString();

      var description = await getEntity(
          table: 'SOUL_URGE_NUMBER_ENG',
          queryColumn: 'number',
          resColumn: 'description',
          value: calculation);
      var info = await getEntity(
          table: 'TABLE_DESCRIPTION',
          queryColumn: 'table_name',
          resColumn: 'description',
          value: '\"SOUL_URGE_NUMBER_ENG\"');

      var language = Globals.instance.language;
      Map<String, String> cards = {
        language.description: description,
        language.info: info
      };

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation,
        cards: cards,
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
}
