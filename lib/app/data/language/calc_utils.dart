import 'package:flutter/cupertino.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/data_provider/numerology_helper.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/language/language_ru.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';
import 'package:numerology/app/presentation/pages/description/compat_internal_page.dart';
import 'package:numerology/app/presentation/pages/description/description_compat_page.dart';
import 'package:numerology/app/presentation/pages/description/description_name_page.dart';
import 'package:numerology/app/presentation/pages/description/description_page.dart';
import 'package:numerology/app/presentation/pages/description/description_wedding_page.dart';
import 'package:numerology/app/presentation/pages/description/matrix_data.dart';
import 'package:numerology/app/presentation/pages/description/matrix_line_data.dart';
import 'package:numerology/app/presentation/pages/description/matrix_lines_page.dart';
import 'package:numerology/app/presentation/pages/description/matrix_page.dart';
import 'package:numerology/app/presentation/pages/graphs/bio_graphs_second_page.dart';

enum CategoryType {
  luckyGemCategory,
  birthdayNumCategory,
  birthdayCodeCategory,
  maturityNumCategory,
  personalityNumCategory,
  lifePathNumCategory,
  challengeNumCategory,
  realizationNumCategory,
  expressionNumCategory,
  nameNumCategory,
  desireNumCategory,
  soulNumCategory,
  weddingNumCategory,
  matrixLinesCategory,
  matrixCategory,
  compatCategory,
  bioSecondCategory,
  dayCategory,
}

class CategoryProvider {
  final NumerologyDBProvider db;

  CategoryProvider(this.db);

  CategoryProvider._privateConstructor(this.db);

  static final CategoryProvider instance =
      CategoryProvider._privateConstructor(NumerologyDBProvider.instance);

  void onCategoryPressed(BuildContext context, Profile profile,
      CategoryType categoryType, String header) async {
    switch (categoryType) {
      case CategoryType.luckyGemCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getLuckyGemPage(profile, header));
        break;
      case CategoryType.birthdayNumCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getBirthdayNumPage(profile, header));
        break;
      case CategoryType.birthdayCodeCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getBirthdayCodePage(profile, header));
        break;
      case CategoryType.maturityNumCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getMaturityNumPage(profile, header));
        break;
      case CategoryType.personalityNumCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getPersonalityNumPage(profile, header));
        break;
      case CategoryType.lifePathNumCategory:
        navigateToPage(context,
            await CategoryProvider.instance.lifePathNumPage(profile, header));
        break;
      case CategoryType.challengeNumCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getChallengeNumPage(profile, header));
        break;
      case CategoryType.realizationNumCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getRealizationNumPage(profile, header));
        break;
      case CategoryType.expressionNumCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getExpressionNumPage(profile, header));
        break;
      case CategoryType.nameNumCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getNameNumPage(profile, header));
        break;
      case CategoryType.desireNumCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getDesireNumPage(profile, header));
        break;
      case CategoryType.soulNumCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getSoulNumPage(profile, header));
        break;
      case CategoryType.weddingNumCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getWeddingNumPage(profile, header));
        break;
      case CategoryType.matrixLinesCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getMatrixLinesPage(profile, header));
        break;
      case CategoryType.matrixCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getMatrixPage(profile, header));
        break;
      case CategoryType.compatCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getCompatPage(profile, header));
        break;
      case CategoryType.bioSecondCategory:
        navigateToPage(context,
            await CategoryProvider.instance.getBioSecondPage(profile, header));
        break;
      case CategoryType.dayCategory:
      case CategoryType.bioSecondCategory:
        navigateToPage(
            context,
            await CategoryProvider.instance
                .getPersonalDayPage(profile, header));
        break;
    }
  }

  Future<List<CardData>> getSecondaryBio(List<double> bio) async {
    var bioLevel = CategoryCalc.instance.calcBioSecondLevel(bio);
    var language = Globals.instance.language;

    var table = 'SECONDARY_BIORITHMS_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      table = 'SECONDARY_BIORITHMS_RUS';
    }

    var categories = [
      'spiritual',
      'intuitive',
      'self-awareness',
      'aesthetic',
    ];

    var headers = [
      language.spiritBio,
      language.intuitBio,
      language.awareBio,
      language.aestheticBio,
    ];

    var icons = [
      spirit,
      intuit,
      awareness,
      aesthetic,
    ];

    var descriptions = [];
    List<CardData> data = [];
    for (var i = 0; i < categories.length; i++) {
      var description = await getEntityRawQuery(
          'select description from $table where type = "${categories[i]}" AND level = "${bioLevel[i]}"');
      descriptions.add(description);
    }

    var info = await getEntityRawQuery(
        'select description from "TABLE_DESCRIPTION" where table_name = "$table"');

    for (var i = 0; i < descriptions.length; i++) {
      data.add(CardData(
          description: descriptions[i],
          header: headers[i],
          iconPath: icons[i]));
    }

    data.add(CardData(
        description: info,
        header: Globals.instance.language.info,
        iconPath: infoIcon));

    return data;
  }

  Future<Widget> getPersonalDayPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcPersonalDay(profile);
    var tableName = 'PERSONAL_DAY_ENG';

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<String> getDayContent(Profile profile) async {
    var calc = CategoryCalc.instance.calcPersonalDay(profile);
    var tableName = 'PERSONAL_DAY_ENG';

    var description = await getEntityRawQuery(
        'select description from "$tableName"  where  number = $calc');
    return description;
  }

  Future<Widget> getBioSecondPage(Profile profile, String header) async {
    return BioGraphsSecondPage();
  }

  Future<Widget> getCompatPage(Profile profile, String header) async {
    return DescriptionPartnerDobBasedPage(
      categoryName: header,
      getPage: (profile, header) async => await _getCompatPage(profile, header),
    );
  }

  Future<Widget> _getCompatPage(Profile profile, String header) async {
    var bioCompat = CategoryCalc.instance.calcBioCompat(profile);
    var yourLifePath =
        CategoryCalc.instance.calcLifePathNumberMethod(profile.dob);
    var partnerLifePath =
        CategoryCalc.instance.calcLifePathNumberMethod(profile.partnerDob);
    var yourMatrixLines =
        CategoryCalc.instance.calcMatrixLinesByDob(profile.dob);
    var yourMatrix = CategoryCalc.instance.calcMatrixByDob(profile.dob);
    var partnerMatrixLines =
        CategoryCalc.instance.calcMatrixLinesByDob(profile.partnerDob);
    var partnerMatrix =
        CategoryCalc.instance.calcMatrixByDob(profile.partnerDob);

    List<CardData> bioCompatData = await _getBioCompat(profile, bioCompat);
    List<CardData> lifePathData =
        await _getPathCompat(yourLifePath, partnerLifePath);
    List<CardData> matrixCompData =
        await _getMtxCompat(yourMatrixLines, partnerMatrixLines);

    return CompatInternalPage(
      bioCompat: bioCompat,
      yourMatrix: yourMatrix,
      partnerMatrix: partnerMatrix,
      yourLifePath: yourLifePath,
      partnersLifePath: partnerLifePath,
      matrixData: matrixCompData,
      bioData: bioCompatData,
      lifePathData: lifePathData,
    );
  }

  Future<List<CardData>> _getMtxCompat(
      List<int> yourMatrixLines, List<int> partnerMatrixLines) async {
    var categories = [
      'PURPOSE',
      'FAMILY',
      'STABILITY',
      'ESTEEM',
      'FINANCE',
      'TALENTS',
      'TEMPERAMENT',
      'SPIRITUALITY'
    ];

    var icons = [
      matrix1,
      matrix2,
      matrix3,
      matrix4,
      matrix5,
      matrix6,
      matrix7,
      matrix8,
    ];

    var matrixCompat = CategoryCalc.instance
        .calcMatrixCompat(yourMatrixLines, partnerMatrixLines);

    var table = 'PSYCHOMATRIX_COMPAT_ENG';
    var matrixTable = 'PSYCHOMATRIX_LINES_ENG';

    List<CardData> matrixCompatData = [];

    for (var i = 0; i < categories.length; i++) {
      var description = await getEntityRawQuery(
          'select description from $table where category =  "${categories[i]}" and strength =  "${matrixCompat[0]}"');
      var info = await getEntityRawQuery(
          'select description from TABLE_DESCRIPTION where table_name = "$matrixTable" and category = "${categories[i].toLowerCase()}"');
      matrixCompatData.add(CardData(
          description: description + "\n\n" + info,
          header: _capitalize(categories[i]),
          iconPath: icons[i]));
    }

    var matrInfo = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name = "PSYCHOMATRIX_ENG" and category = "info"');

    matrixCompatData.add(CardData(
        description: matrInfo,
        header: Globals.instance.language.info,
        iconPath: infoIcon));

    return matrixCompatData;
  }

  String _capitalize(String str) {
    return "${str.substring(0, 1).toUpperCase()}${str.substring(1).toLowerCase()}";
  }

  Future<List<CardData>> _getPathCompat(
      int yourLifePath, int partnerLifePath) async {
    var lifePathCompat = '';
    var path1 = yourLifePath < partnerLifePath ? yourLifePath : partnerLifePath;
    var path2 = yourLifePath < partnerLifePath ? partnerLifePath : yourLifePath;
    lifePathCompat = await getEntityRawQuery(
        'select description from "LIFE_PATH_NUMBER_COMPAT_ENG" where number1 = $path1 and number2 = $path2');

    var lifePathInfo = await getEntityRawQuery(
        'select description from "TABLE_DESCRIPTION" where table_name = "LIFE_PATH_NUMBER_COMPAT_ENG"');

    List<CardData> lifePathData = [];
    lifePathData.add(CardData(
        description: lifePathCompat,
        header: Globals.instance.language.lifePathCompat,
        iconPath: directions));
    lifePathData.add(CardData(
        description: lifePathInfo,
        header: Globals.instance.language.info,
        iconPath: infoIcon));

    return lifePathData;
  }

  Future<List<CardData>> _getBioCompat(
      Profile profile, List<double> bioCompat) async {
    var bioLevels = CategoryCalc.instance.calcBioCompatLevel(profile);
    var language = Globals.instance.language;

    List<CardData> bioData = [];
    var bioIcons = [
      physical,
      emotional,
      intel,
    ];
    var categories = [
      'physical',
      'emotional',
      'intellectual',
    ];
    var bioHeaders = [
      language.physicalBio,
      language.emotionalBio,
      language.intellectBio,
    ];

    for (var i = 0; i < bioCompat.length; i++) {
      var description = await getEntityRawQuery(
          'select description from BIORITHM_COMPATIBILITY_ENG  where  type = "${categories[i]}" and level = "${bioLevels[i]}"');
      bioData.add(CardData(
          description: description,
          header: bioHeaders[i],
          iconPath: bioIcons[i]));
    }

    var bioInfo = await getEntityRawQuery(
        'select description from "TABLE_DESCRIPTION" where table_name = "BIORITHM_COMPATIBILITY_ENG"');

    bioData.add(CardData(
        description: bioInfo, header: language.info, iconPath: infoIcon));

    return bioData;
  }

  Future<Widget> getMatrixPage(Profile profile, String header) async {
    var calcs = CategoryCalc.instance.calcMatrix(profile);

    var table = 'PSYCHOMATRIX_ENG';

    List<MatrixData> data = [];
    var descriptions = [];
    var info = [];
    var categories = [
      'personality',
      'energy',
      'interest',
      'health',
      'logic',
      'work',
      'luck',
      'duty',
      'memory'
    ];
    var headers = [
      'Personality',
      'Energy',
      'Interest',
      'Health',
      'Logic',
      'Work',
      'Luck',
      'Duty',
      'Memory'
    ];

    if (Globals.instance.getLanguage() is LanguageRu) {
      table = 'PSYCHOMATRIX_RUS';
      headers = [
        'Характер',
        'Энергия',
        'Интерес',
        'Здоровье',
        'Логика',
        'Труд',
        'Удача',
        'Долг',
        'Память'
      ];
    }

    for (var i = 0; i < categories.length; i++) {
      var description = await getEntityRawQuery(
          'select description from $table where characteristic =  "${categories[i]}" and number = ${_convertMatrixNums(calcs[i])}');
      descriptions.add(description);
    }

    var query =
        'select description from TABLE_DESCRIPTION where table_name = "$table" and category = 1';
    var infoStr = await getEntityRawQuery(query);
    info.add(infoStr);

    for (var i = 1; i <= categories.length; i++) {
      var infoStr = await getEntityRawQuery(
          'select description from TABLE_DESCRIPTION where table_name = "$table" and category = "$i"');
      info.add(infoStr);
    }

    var language = Globals.instance.getLanguage();

    for (var i = 0; i < categories.length; i++) {
      data.add(
        MatrixData(description: {
          headers[i]: language.digitsInCell +
              calcs[i].toString().replaceAll('0', '-') +
              '\n\n' +
              descriptions[i]
        }, info: {
          language.info: info[i]
        }),
      );
    }

    return MatrixPage(
      header: header,
      matrix: calcs,
      guideText: language.clickOnAnyCell,
      data: data,
    );
  }

  String _convertMatrixNums(int num) {
    var str = num.toString();
    if (str.contains('1')) {
      return str.length > 7 ? str.substring(0, 6) : str;
    } else if (str.contains('2')) {
      return str.length > 6 ? str.substring(0, 5) : str;
    }
    return str.length > 5 ? str.substring(0, 4) : str;
  }

  Future<Widget> getMatrixLinesPage(Profile profile, String header) async {
    var calcs = CategoryCalc.instance.calcMatrixLines(profile);
    var matrix = CategoryCalc.instance.calcMatrix(profile);

    List<CardData> data = [];
    var icons = [
      matrix1,
      matrix2,
      matrix3,
      matrix4,
      matrix5,
      matrix6,
      matrix7,
      matrix8,
    ];
    var description = [];
    var info = [];
    var table = 'PSYCHOMATRIX_LINES_ENG';
    var matrixTable = 'PSYCHOMATRIX_ENG';
    var categories = [
      'purpose',
      'family',
      'stability',
      'esteem',
      'finance',
      'talents',
      'temperament',
      'spirituality',
    ];

    var headers = [
      'Purpose',
      'Family',
      'stability',
      'Esteem',
      'Finance',
      'Talents',
      'Temperament',
      'Spirituality',
    ];

    if (Globals.instance.getLanguage() is LanguageRu) {
      table = 'PSYCHOMATRIX_LINES_RUS';
      matrixTable = 'PSYCHOMATRIX_RUS';
      headers = [
        'Целеустремлённость',
        'Семья',
        'Стабильность',
        'Самооценка',
        'Финансы',
        'Талант',
        'Темперамент',
        'Духовность',
      ];
    }

    calcs.forEach((calc) async {
      var descriptionStr = await getEntityRawQuery(
          'select description from $table where category = "purpose" AND number = ${_convertLinesNums(calc)}');
      description.add(descriptionStr);
    });

    categories.forEach((category) async {
      var infoStr = await getEntityRawQuery(
          'select description from TABLE_DESCRIPTION where table_name = "$table" and category = "$category"');
      info.add(infoStr);
    });

    var generalInfo = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "$matrixTable" and category = "info"');

    var language = Globals.instance.getLanguage();
    for (var i = 0; i < categories.length; i++) {
      data.add(CardData(
        iconPath: icons[i],
        calculation: calcs[i],
        header: headers[i],
        description: language.numberOfDigits +
            calcs[i].toString() +
            '\n\n' +
            description[i] +
            '\n\n' +
            info[i],
      ));
    }

    return MatrixLinesPage(
      header: header,
      description: data,
      matrix: matrix,
      info: {Globals.instance.language.info: generalInfo},
    );
  }

  int _convertLinesNums(int number) {
    return number > 6 ? 6 : number;
  }

  Future<Widget> getWeddingNumPage(Profile profile, String header) async {
    return DescriptionWeddingBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getWeddingNumPage(profile, header),
    );
  }

  Future<Widget> _getWeddingNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcWeddingNumber(profile);
    var tableName = 'MARRIAGE_NUMBER_ENG';

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getSoulNumPage(Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getSoulNumPage(profile, header),
    );
  }

  Future<Widget> _getSoulNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcSoulNumber(profile);

    var tableName = 'SOUL_URGE_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'SOUL_URGE_NUMBER_RUS';
      return await _getSoulDescriptionPage(tableName, calc, header);
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getDesireNumPage(Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getDesireNumPage(profile, header),
    );
  }

  Future<Widget> _getDesireNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcDesireNumber(profile);
    var tableName = 'DESIRE_NUMBER_ENG';

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getNameNumPage(Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getNameNumPage(profile, header),
    );
  }

  Future<Widget> _getNameNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcNameNumber(profile);
    var tableName = 'NAME_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'NAME_NUMBER_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getExpressionNumPage(Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getExpressionNumPage(profile, header),
    );
  }

  Future<Widget> _getExpressionNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcExpressionNumber(profile);
    var tableName = 'EXPRESSION_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'EXPRESSION_NUMBER_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getRealizationNumPage(Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getRealizationNumPage(profile, header),
    );
  }

  Future<Widget> _getRealizationNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcRealizationNumber(profile);
    var tableName = 'REALIZATION_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'REALIZATION_NUMBER_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getChallengeNumPage(Profile profile, String header) async {
    var calc1 = CategoryCalc.instance.calcChallengeNum1(profile).toString();
    var calc2 = CategoryCalc.instance.calcChallengeNum2(profile).toString();
    var calc3 = CategoryCalc.instance.calcChallengeNum3(profile).toString();
    var calc4 = CategoryCalc.instance.calcChallengeNum4(profile).toString();

    var calc = [calc1, calc2, calc3, calc4];

    var descriptions = [];

    var headers = [
      'The First Challenge - ',
      'The Second Challenge - ',
      'The Third Challenge - ',
      'The Forth Challenge - ',
    ];

    var tableName = 'CHALLENGE_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'CHALLENGE_NUMBER_RUS';
      headers = [
        'Первое испытание - ',
        'Второе испытание - ',
        'Третье испытание - ',
        'Четвёртое испытание - ',
      ];
    }

    calc.forEach((calc) async {
      var description = await getEntityRawQuery(
          'select description from "$tableName"  where  number = $calc');
      descriptions.add(description);
    });

    var info = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];

    for (var i = 0; i < 4; i++) {
      data.add(
          CardData(header: headers[i] + calc[i], description: descriptions[i]));
    }

    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      header: header,
      data: data,
    );
  }

  Future<Widget> lifePathNumPage(Profile profile, String header) async {
    Map<String, String> _fromMapLifePath(Map<String, dynamic> map) {
      if (Globals.instance.getLanguage() is LanguageRu) {
        return {
          'Описание': map['description'] as String,
          'Любовь': map['love'] as String,
          'Мужчина': map['man'] as String,
          'Женщина': map['women'] as String,
        };
      }

      return {
        'Description': map['description'] as String,
        'Profession': map['profession'] as String,
        'Finances': map['finances'] as String,
        'Relationship': map['relationships'] as String,
        'Health': map['health'] as String,
        'Negative': map['negative'] as String,
      };
    }

    var tableName = 'LIFE_PATH_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'LIFE_PATH_NUMBER_RUS';
    }

    var calc = CategoryCalc.instance.calcLifePathNumberMethod1(profile);

    Map<String, String> descriptions =
        await NumerologyDBProvider.instance.getEntity(
      'select * from "$tableName"  where  number = $calc',
      (map) => _fromMapLifePath(map),
    );

    var info = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];

    descriptions.forEach((key, value) {
      data.add(CardData(header: key, description: value));
    });

    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      header: header,
      calculation: calc.toString(),
      data: data,
    );
  }

  Future<Widget> getPersonalityNumPage(Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getPersonalityNumPage(profile, header),
    );
  }

  Future<Widget> _getPersonalityNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcPersonalityNumber(profile);
    var tableName = 'PERSONALITY_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'PERSONALITY_NUMBER_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getLuckyGemPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcLuckGem(profile);

    var tableName = 'LUCKY_GEM_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'LUCKY_GEM_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getBirthdayNumPage(Profile profile, String header) async {
    var calc = DateService.fromTimestamp(profile.dob).day;
    var tableName = 'BIRTHDAY_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'BIRTHDAY_NUMBER_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getBirthdayCodePage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcBirthdayCode(profile);
    var tableName = 'BIRTHDAY_CODE_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'BIRTHDAY_CODE_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<Widget> getMaturityNumPage(Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcMaturityNumber(profile);
    var tableName = 'MATURITY_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'MATURITY_NUMBER_RUS';
    }

    return await _getDescriptionPage(tableName, calc, header);
  }

  Future<DescriptionPage> _getDescriptionPage(
      String tableName, int calc, String header) async {
    var description = await getEntityRawQuery(
        'select description from "$tableName"  where  number = $calc');
    var info = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];
    data.add(CardData(
        header: Globals.instance.language.description,
        description: description));
    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      header: header,
      calculation: calc.toString(),
      data: data,
    );
  }

  Future<DescriptionPage> _getSoulDescriptionPage(
      String tableName, int calc, String header) async {
    Map<String, String> _fromMapLifePath(Map<String, dynamic> map) {
      return {
        'Описание': map['description'] as String,
        'Ваша Характеристика': map['person_characteristic'] as String,
      };
    }

    Map<String, String> descriptions =
        await NumerologyDBProvider.instance.getEntity(
      'select * from "$tableName"  where  number = $calc',
      (map) => _fromMapLifePath(map),
    );

    var info = await getEntityRawQuery(
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];
    descriptions.forEach((key, value) {
      data.add(CardData(header: key, description: value));
    });
    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      header: header,
      calculation: calc.toString(),
      data: data,
    );
  }
}
