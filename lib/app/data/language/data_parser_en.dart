import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/language/data_parser.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/presentation/pages/description/description_name_page.dart';
import 'package:numerology/app/presentation/pages/description/description_page.dart';
import 'package:numerology/app/presentation/pages/description/description_wedding_page.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';
import 'package:numerology/app/presentation/pages/description/matrix_lines_page.dart';

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
    categories.add(await _getMatrixLines(profile));
    categories.add(await _getSoulNumber(profile));
    categories.add(await _getChallengeNumber(profile));
    categories.add(await _getNameNumber(profile));
    categories.add(await _getDesireNumber(profile));
    categories.add(await _getWeddingNumber(profile));
    categories.add(await _getExpressionNumber(profile));
    categories.add(await _getRealizationNumber(profile));
    categories.add(await _getPersonalityNumber(profile));
    categories.add(await _getMaturityNumber(profile));
    categories.add(await _getBirthdayCode(profile));
    categories.add(await _getBirthdayNumber(profile));
    categories.add(await _getLuckyGemModel(profile));

    return categories;
  }

  Future<CategoryModel> _getMatrixLines(Profile profile) async {
    var language = Globals.instance.getLanguage();
    var calc = CategoryCalc.instance.calcMatrixLines(profile);
    var matrix = CategoryCalc.instance.calcMatrix(profile);

    var table = 'PSYCHOMATRIX_LINES_ENG';
    var description1 = await getEntityRawQuery(
        'select description from $table where category = "purpose" AND number = ${_convertLinesNums(calc[0])}');
    var description2 = await getEntityRawQuery(
        'select description from $table where category = "family" AND number = ${_convertLinesNums(calc[1])}');
    var description3 = await getEntityRawQuery(
        'select description from $table where category = "stability" AND number = ${_convertLinesNums(calc[2])}');
    var description4 = await getEntityRawQuery(
        'select description from $table where category = "esteem" AND number = ${_convertLinesNums(calc[3])}');
    var description5 = await getEntityRawQuery(
        'select description from $table where category = "finance" AND number = ${_convertLinesNums(calc[4])}');
    var description6 = await getEntityRawQuery(
        'select description from $table where category = "talents" AND number = ${_convertLinesNums(calc[5])}');
    var description7 = await getEntityRawQuery(
        'select description from $table where category = "temperament" AND number = ${_convertLinesNums(calc[6])}');
    var description8 = await getEntityRawQuery(
        'select description from $table where category = "spirituality" AND number = ${_convertLinesNums(calc[7])}');

    var data1 = MatrixLineData(
        lineSum: calc[0],
        description: language.numberOfDigits +
            calc[0].toString() +
            "\n\n" +
            description1,
        header: 'Purpose',
        iconPath: matrix1);
    var data2 = MatrixLineData(
        lineSum: calc[1],
        description: language.numberOfDigits +
            calc[1].toString() +
            "\n\n" +
            description2,
        header: 'Family',
        iconPath: matrix2);
    var data3 = MatrixLineData(
        lineSum: calc[2],
        description: language.numberOfDigits +
            calc[2].toString() +
            "\n\n" +
            description3,
        header: 'Stability',
        iconPath: matrix3);
    var data4 = MatrixLineData(
        lineSum: calc[3],
        description: language.numberOfDigits +
            calc[3].toString() +
            "\n\n" +
            description4,
        header: 'Esteem',
        iconPath: matrix4);
    var data5 = MatrixLineData(
        lineSum: calc[4],
        description: language.numberOfDigits +
            calc[4].toString() +
            "\n\n" +
            description5,
        header: 'Finance',
        iconPath: matrix5);
    var data6 = MatrixLineData(
        lineSum: calc[5],
        description: language.numberOfDigits +
            calc[5].toString() +
            "\n\n" +
            description6,
        header: 'Talents',
        iconPath: matrix6);
    var data7 = MatrixLineData(
        lineSum: calc[6],
        description: language.numberOfDigits +
            calc[6].toString() +
            "\n\n" +
            description7,
        header: 'Temperament',
        iconPath: matrix7);
    var data8 = MatrixLineData(
        lineSum: calc[7],
        description: language.numberOfDigits +
            calc[7].toString() +
            "\n\n" +
            description8,
        header: 'Spirituality',
        iconPath: matrix8);

    return CategoryModel(
        imagePath: matrixLines,
        text: 'Matrix lines',
        page: MatrixLinesPage(
          header: 'Matrix lines',
          description: [
            data1,
            data2,
            data3,
            data4,
            data5,
            data6,
            data7,
            data8,
          ],
          matrix: matrix,
        ));
  }

  int _convertLinesNums(int number) {
    return number > 6 ? 6 : number;
  }

  Future<CategoryModel> _getWeddingNumber(Profile profile) async {
    return await _buildWeddingBasedCategory(
      profile: profile,
      imagePath: marriage,
      categoryName: 'Marriage number',
      table: 'MARRIAGE_NUMBER_ENG',
      calcFunction: (profile) =>
          CategoryCalc.instance.calcWeddingNumber(profile),
    );
  }

  Future<CategoryModel> _getRealizationNumber(Profile profile) async {
    return await _buildNameBasedCategory(
      profile: profile,
      imagePath: work,
      categoryName: 'Realization number',
      table: 'REALIZATION_NUMBER_ENG',
      calcFunction: (profile) =>
          CategoryCalc.instance.calcRealizationNumber(profile),
    );
  }

  Future<CategoryModel> _getMaturityNumber(Profile profile) async {
    return await _buildNameBasedCategory(
      profile: profile,
      imagePath: maturity,
      categoryName: 'Maturity number',
      table: 'MATURITY_NUMBER_ENG',
      calcFunction: (profile) =>
          CategoryCalc.instance.calcMaturityNumber(profile),
    );
  }

  Future<CategoryModel> _getDesireNumber(Profile profile) async {
    return await _buildNameBasedCategory(
      profile: profile,
      imagePath: desire,
      categoryName: 'Desire number',
      table: 'DESIRE_NUMBER_ENG',
      calcFunction: (profile) =>
          CategoryCalc.instance.calcDesireNumber(profile),
    );
  }

  Future<CategoryModel> _getPersonalityNumber(Profile profile) async {
    return await _buildNameBasedCategory(
      profile: profile,
      imagePath: personality,
      categoryName: 'Personality number',
      table: 'PERSONALITY_NUMBER_ENG',
      calcFunction: (profile) =>
          CategoryCalc.instance.calcPersonalityNumber(profile),
    );
  }

  Future<CategoryModel> _getExpressionNumber(Profile profile) async {
    return await _buildNameBasedCategory(
      profile: profile,
      imagePath: expression,
      categoryName: 'Expression number',
      table: 'EXPRESSION_NUMBER_ENG',
      calcFunction: (profile) =>
          CategoryCalc.instance.calcExpressionNumber(profile),
    );
  }

  Future<CategoryModel> _getNameNumber(Profile profile) async {
    return await _buildNameBasedCategory(
      profile: profile,
      imagePath: name,
      categoryName: 'Name number',
      table: 'NAME_NUMBER_ENG',
      calcFunction: (profile) => CategoryCalc.instance.calcNameNumber(profile),
    );
  }

  @override
  Future<CategoryModel> getPersonalDay(Profile profile) async {
    return await _buildBasicCategory(
      profile: profile,
      categoryName: 'Day number',
      imagePath: day,
      table: 'PERSONAL_DAY_ENG',
      calcFunction: (profile) => CategoryCalc.instance.calcPersonalDay(profile),
      setPreview: true,
    );
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
    return await _buildBasicCategory(
      profile: profile,
      categoryName: 'Birthday code',
      imagePath: birthdayCode,
      table: 'BIRTHDAY_CODE_ENG',
      calcFunction: (profile) =>
          CategoryCalc.instance.calcBirthdayCode(profile),
    );
  }

  Future<CategoryModel> _getLuckyGemModel(Profile profile) async {
    return await _buildBasicCategory(
      profile: profile,
      categoryName: 'Lucky Gem',
      imagePath: luckyGem,
      table: 'LUCKY_GEM_ENG',
      calcFunction: (profile) => CategoryCalc.instance.calcLuckGem(profile),
    );
  }

  Future<CategoryModel> _getBirthdayNumber(Profile profile) async {
    return await _buildBasicCategory(
      profile: profile,
      categoryName: 'Birthday number',
      imagePath: birthdayNum,
      table: 'BIRTHDAY_NUMBER_ENG',
      calcFunction: (profile) => DateService.fromTimestamp(profile.dob).day,
    );
  }

  Future<CategoryModel> _getSoulNumber(Profile profile) async {
    return await _buildNameBasedCategory(
      profile: profile,
      imagePath: soul,
      categoryName: 'Soul number',
      table: 'BIRTHDAY_NUMBER_ENG',
      calcFunction: (profile) => CategoryCalc.instance.calcSoulNumber(profile),
    );
  }

  bool _isNameSet(Profile profile) {
    return profile.firstName.isNotEmpty ||
        profile.lastName.isNotEmpty ||
        profile.middleName.isNotEmpty;
  }

  bool _isWeddingDateSet(Profile profile) {
    return profile.weddingDate != null;
  }

  Future<CategoryModel> _buildNameBasedCategory({
    @required Profile profile,
    @required String categoryName,
    @required String imagePath,
    @required String table,
    @required Function calcFunction,
  }) async {
    DescriptionPage descriptionPage = DescriptionPage();
    if (_isNameSet(profile)) {
      var calculation = calcFunction(profile);

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation.toString(),
        description: await getDescription(table, calculation),
      );
    }

    return CategoryModel(
        imagePath: imagePath,
        text: categoryName,
        page: DescriptionNameBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  Future<CategoryModel> _buildWeddingBasedCategory({
    @required Profile profile,
    @required String categoryName,
    @required String imagePath,
    @required String table,
    @required Function calcFunction,
  }) async {
    DescriptionPage descriptionPage = DescriptionPage();
    if (_isWeddingDateSet(profile)) {
      var calculation = calcFunction(profile);

      descriptionPage = DescriptionPage(
        header: categoryName,
        calculation: calculation.toString(),
        description: await getDescription(table, calculation),
      );
    }

    return CategoryModel(
        imagePath: imagePath,
        text: categoryName,
        page: DescriptionWeddingBasedPage(
          categoryName: categoryName,
          page: descriptionPage,
        ));
  }

  Future<CategoryModel> _buildBasicCategory(
      {@required Profile profile,
      @required String categoryName,
      @required String imagePath,
      @required String table,
      @required Function calcFunction,
      bool setPreview = false}) async {
    var calculation = calcFunction(profile);
    var description = await getDescription(table, calculation);
    return CategoryModel(
        imagePath: imagePath,
        text: categoryName,
        content: setPreview ? description.values.first : '',
        page: DescriptionPage(
          header: categoryName,
          calculation: calculation.toString(),
          description: description,
        ));
  }
}
