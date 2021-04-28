import 'package:flutter/cupertino.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/ads/native_admob_controller.dart';
import 'package:numerology/app/business_logic/services/category_calc.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/data/data_provider/numerology_helper.dart';
import 'package:numerology/app/data/language/parser_utils.dart';
import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/localization/language/language_en.dart';
import 'package:numerology/app/localization/language/language_es.dart';
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
import 'package:numerology/app/presentation/pages/pay_wall/pay_wall.dart';
import 'package:provider/provider.dart';

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
  moneyCategory,

  /// RU ///
  achievementCategory,
  characterCategory,
  intelligenceCategory,
  balanceCategory,
  marriageCategory,
  loveCategory,

  /// ES ///
  potentialCategory,
  karmaCategory,
}

class CategoryProvider {
  final NumerologyDBProvider db;

  CategoryProvider(this.db);

  CategoryProvider._privateConstructor(this.db);

  final NativeAdmobController adController = NativeAdmobController();

  static final CategoryProvider instance =
      CategoryProvider._privateConstructor(NumerologyDBProvider.instance);

  void onCategoryPressed(BuildContext context, Profile profile,
      CategoryType categoryType, String header) async {
    switch (categoryType) {
      case CategoryType.luckyGemCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getLuckyGemPage(context, profile, header));
        break;
      case CategoryType.birthdayNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getBirthdayNumPage(context, profile, header));
        break;
      case CategoryType.birthdayCodeCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getBirthdayCodePage(context, profile, header));
        break;
      case CategoryType.maturityNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getMaturityNumPage(context, profile, header));
        break;
      case CategoryType.personalityNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getPersonalityNumPage(context, profile, header));
        break;
      case CategoryType.lifePathNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .lifePathNumPage(context, profile, header));
        break;
      case CategoryType.challengeNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getChallengeNumPage(context, profile, header));
        break;
      case CategoryType.realizationNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getRealizationNumPage(context, profile, header));
        break;
      case CategoryType.expressionNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getExpressionNumPage(context, profile, header));
        break;
      case CategoryType.nameNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getNameNumPage(context, profile, header));
        break;
      case CategoryType.desireNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getDesireNumPage(context, profile, header));
        break;
      case CategoryType.soulNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getSoulNumPage(context, profile, header));
        break;
      case CategoryType.weddingNumCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getWeddingNumPage(context, profile, header));
        break;
      case CategoryType.matrixLinesCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getMatrixLinesPage(context, profile, header));
        break;
      case CategoryType.matrixCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getMatrixPage(context, profile, header));
        break;
      case CategoryType.compatCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getCompatPage(context, profile, header));
        break;
      case CategoryType.bioSecondCategory:
        await navigateToPage(context,
            await CategoryProvider.instance.getBioSecondPage(profile, header));
        break;
      case CategoryType.dayCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getPersonalDayPage(context, profile, header));
        break;
      case CategoryType.achievementCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getAchievementNumPage(context, profile, header));
        break;
      case CategoryType.characterCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getCharacterPage(context, profile, header));
        break;
      case CategoryType.intelligenceCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getIntelligenceNumPage(context, profile, header));
        break;
      case CategoryType.moneyCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getMoneyNumPage(context, profile, header));
        break;
      case CategoryType.balanceCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getBalanceNumPage(context, profile, header));
        break;
      case CategoryType.marriageCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getMarriageNumPage(context, profile, header));
        break;
      case CategoryType.loveCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getLoveNumPage(context, profile, header));
        break;
      case CategoryType.potentialCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getPotentialNumPage(context, profile, header));
        break;
      case CategoryType.karmaCategory:
        await navigateToPage(
            context,
            await CategoryProvider.instance
                .getKarmaNumPage(context, profile, header));
        break;
    }
  }

  Future<Widget> getKarmaNumPage(
      BuildContext context, Profile profile, String header) async {
    var isPremium = await PremiumController.instance.isPremium();
    if (isPremium) {
      return DescriptionNameBasedPage(
        categoryName: header,
        getPage: (profile, header) async =>
            await _getKarmaNumPage(context, profile, header),
      );
    }
    return PayWall();
  }

  Future<Widget> _getKarmaNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcKarmicNum(profile);
    var tableName = 'KARMIC_LESSON_ESP';

    return await _getKarmaDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getPotentialNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getPotentialNumPage(context, profile, header),
    );
  }

  Future<Widget> _getPotentialNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcPotentialNum(profile);
    var tableName = 'POTENTIAL_NUMBER_ESP';

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getLoveNumPage(
      BuildContext context, Profile profile, String header) async {
    var isPremium = await PremiumController.instance.isPremium();
    if (isPremium) {
      return DescriptionPartnerDobBasedPage(
        categoryName: header,
        getPage: (profile, header) async =>
            await _getLoveNumPage(context, profile, header),
      );
    }
    return PayWall();
  }

  Future<Widget> _getLoveNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcLoveNumberRu(profile);
    var calcLove = CategoryCalc.instance.calcLoveCompatNumberRu(profile);
    var tableName = 'LOVE_NUMBER_RUS';
    var tableLove = 'LOVE_COMPATIBILITY_RUS';

    var partnerDob = DateService.getFormattedDate(
        DateService.fromTimestamp(profile.partnerDob));

    return await _getLoveDescriptionPage(
        context, tableName, tableLove, calc, calcLove, header, partnerDob);
  }

  Future<Widget> getMarriageNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getMarriageNumPage(context, profile, header),
    );
  }

  Future<Widget> _getMarriageNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcMarriageNumberRu(profile);
    var tableName = 'MARRIAGE_NUMBER_RUS';

    return await _getMarriageDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getBalanceNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getBalanceNumPage(context, profile, header),
    );
  }

  Future<Widget> _getBalanceNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcBalanceNumber(profile);
    var tableName = 'BALANCE_NUMBER_RUS';

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getMoneyNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcMoneyNumber(profile);
    var tableName = 'MONEY_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'MONEY_NUMBER_RUS';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getIntelligenceNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getIntelligenceNumPage(context, profile, header),
    );
  }

  Future<Widget> _getIntelligenceNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcIntelligenceNumber(profile);
    var tableName = 'INTELLIGENCE_NUMBER_RUS';

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getCharacterPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcCharacterNumber(profile);
    var tableName = 'CHARACTER_NUMBER_RUS';

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<List<CardData>> getPrimBio(List<double> bio) async {
    var bioLevel = CategoryCalc.instance.calcBioPrimLevel(bio);
    var language = Globals.instance.language;

    var table = 'BIORITHMS_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      table = 'BIORITHMS_RUS';
      bioLevel = CategoryCalc.instance.calcBioPrimLevelRu(bio);
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      table = 'BIORITHMS_ESP';
    }

    var categories = [
      'physical',
      'emotional',
      'intellectual',
    ];

    var icons = [
      physical,
      emotional,
      intel,
    ];

    var headers = [
      language.physicalBio,
      language.emotionalBio,
      language.intellectBio,
    ];

    var descriptions = [];
    List<CardData> data = [];
    for (var i = 0; i < categories.length; i++) {
      var description = await getEntityRawQuery(
          'select description from $table where type = "${categories[i]}" AND level = "${bioLevel[i]}"');
      descriptions.add(description);
    }

    for (var i = 0; i < descriptions.length; i++) {
      data.add(CardData(
          description: descriptions[i],
          header: headers[i],
          iconPath: icons[i]));
    }
    var info = await getEntityRawQuery(
        'select description from "TABLE_DESCRIPTION" where table_name = "$table" ');

    data.add(
        CardData(description: info, header: language.info, iconPath: infoIcon));

    return data;
  }

  Future<List<CardData>> getSecondaryBio(List<double> bio) async {
    var bioLevel = CategoryCalc.instance.calcBioSecondLevel(bio);
    var language = Globals.instance.language;

    var table = 'SECONDARY_BIORITHMS_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      table = 'SECONDARY_BIORITHMS_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      table = 'SECONDARY_BIORITHMS_ESP';
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

    data.add(
        CardData(description: info, header: language.info, iconPath: infoIcon));

    return data;
  }

  Future<Widget> getPersonalDayPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcPersonalDay(profile);
    var tableName = 'PERSONAL_DAY_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'PERSONAL_DAY_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'PERSONAL_DAY_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<String> getDayContent(Profile profile) async {
    var calc = CategoryCalc.instance.calcPersonalDay(profile);
    var tableName = 'PERSONAL_DAY_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'PERSONAL_DAY_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'PERSONAL_DAY_ESP';
    }

    var description = await getEntityRawQuery(
        'select description from "$tableName"  where  number = $calc');
    return description;
  }

  Future<Widget> getBioSecondPage(Profile profile, String header) async {
    return BioGraphsSecondPage(adController);
  }

  Future<Widget> getCompatPage(
      BuildContext context, Profile profile, String header) async {
    var isPremium = await PremiumController.instance.isPremium();
    if (isPremium) {
      return DescriptionPartnerDobBasedPage(
        categoryName: header,
        getPage: (profile, header) async =>
            await _getCompatPage(context, profile, header),
      );
    }
    return PayWall();
  }

  Future<Widget> _getCompatPage(
      BuildContext context, Profile profile, String header) async {
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
    var coupleNumSpanish;

    List<CardData> bioCompatData =
        await _getBioCompat(context, profile, bioCompat);
    List<CardData> lifePathData =
        await _getPathCompat(context, yourLifePath, partnerLifePath);

    List<CardData> matrixCompData;
    List<CardData> coupleCompData;
    if (Globals.instance.language is LanguageEs) {
      coupleNumSpanish = CategoryCalc.instance.calcCoupleNum(profile);
      coupleCompData = await _getCoupleCompat(context, coupleNumSpanish);
    } else {
      matrixCompData =
          await _getMtxCompat(context, yourMatrixLines, partnerMatrixLines);
    }

    return CompatInternalPage(
      bioCompat: bioCompat,
      yourMatrix: yourMatrix,
      partnerMatrix: partnerMatrix,
      yourLifePath: yourLifePath,
      partnersLifePath: partnerLifePath,
      matrixData: matrixCompData,
      bioData: bioCompatData,
      lifePathData: lifePathData,
      coupleNumSpanish: coupleNumSpanish,
      coupleNumData: coupleCompData,
    );
  }

  Future<List<CardData>> _getCoupleCompat(BuildContext context, calc) async {
    var tableName = 'COUPLE_NUMBER_ESP';
    var description = await runQuery(
        context, 'select description from "$tableName"  where  number = $calc');
    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];
    data.add(CardData(
        header: Globals.instance.language.description,
        description: description));
    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return data;
  }

  Future<List<CardData>> _getMtxCompat(BuildContext context,
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
    var mtxTable = 'PSYCHOMATRIX_ENG';
    var matrixTable = 'PSYCHOMATRIX_LINES_ENG';

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
      table = 'PSYCHOMATRIX_COMPAT_RUS';
      mtxTable = 'PSYCHOMATRIX_RUS';
      matrixTable = 'PSYCHOMATRIX_LINES_RUS';
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

    List<CardData> matrixCompatData = [];

    for (var i = 0; i < categories.length; i++) {
      var description = await runQuery(context,
          'select description from $table where category =  "${categories[i]}" and strength =  "${matrixCompat[0]}"');
      var info = await runQuery(context,
          'select description from TABLE_DESCRIPTION where table_name = "$matrixTable" and category = "${categories[i].toLowerCase()}"');
      matrixCompatData.add(CardData(
          description: description + "\n\n" + info,
          header: headers[i],
          iconPath: icons[i]));
    }

    var matrInfo = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name = "$mtxTable" and category = "info"');

    matrixCompatData.add(CardData(
        description: matrInfo,
        header: Globals.instance.language.info,
        iconPath: infoIcon));

    return matrixCompatData;
  }

  Future<List<CardData>> _getPathCompat(
      BuildContext context, int yourLifePath, int partnerLifePath) async {
    var lifePathCompat = '';
    var path1 = yourLifePath < partnerLifePath ? yourLifePath : partnerLifePath;
    var path2 = yourLifePath < partnerLifePath ? partnerLifePath : yourLifePath;

    var table = 'LIFE_PATH_NUMBER_COMPAT_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      table = 'LIFE_PATH_NUMBER_COMPAT_RUS';
    }

    lifePathCompat = await runQuery(context,
        'select description from "$table" where number1 = "$path1" and number2 = "$path2"');

    var lifePathInfo = await runQuery(context,
        'select description from "TABLE_DESCRIPTION" where table_name = "$table"');

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
      BuildContext context, Profile profile, List<double> bioCompat) async {
    var bioLevels = CategoryCalc.instance.calcBioCompatLevel(profile);
    var language = Globals.instance.language;

    var table = 'BIORITHM_COMPATIBILITY_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      table = 'BIORITHM_COMPATIBILITY_RUS';
    }

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
      var description = await runQuery(context,
          'select description from $table  where  type = "${categories[i]}" and level = "${bioLevels[i]}"');
      bioData.add(CardData(
          description: description,
          header: bioHeaders[i],
          iconPath: bioIcons[i]));
    }

    var bioInfo = await runQuery(context,
        'select description from "TABLE_DESCRIPTION" where table_name = "$table"');

    bioData.add(CardData(
      description: bioInfo,
      header: language.info,
      iconPath: infoIcon,
    ));

    return bioData;
  }

  Future<Widget> getMatrixPage(
      BuildContext context, Profile profile, String header) async {
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
      var description = await runQuery(context,
          'select description from $table where characteristic =  "${categories[i]}" and number = ${_convertMatrixNums(calcs[i])}');
      descriptions.add(description);
    }

    for (var i = 1; i <= categories.length; i++) {
      var infoStr = await runQuery(context,
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

    var isPremium = await PremiumController.instance.isPremium();

    return MatrixPage(
      isPremium,
      adController,
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

  Future<Widget> getMatrixLinesPage(
      BuildContext context, Profile profile, String header) async {
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
      'Stability',
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

    for (var i = 0; i < categories.length; i++) {
      var descriptionStr = await runQuery(context,
          'select description from $table where category = "${categories[i]}" AND number = ${_convertLinesNums(calcs[i])}');
      description.add(descriptionStr);
    }

    categories.forEach((category) async {
      var infoStr = await runQuery(context,
          'select description from TABLE_DESCRIPTION where table_name = "$table" and category = "$category"');
      info.add(infoStr);
    });

    var generalInfo = await runQuery(context,
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
      adController,
      header: header,
      data: data,
      matrix: matrix,
      info: {Globals.instance.language.info: generalInfo},
    );
  }

  int _convertLinesNums(int number) {
    return number > 6 ? 6 : number;
  }

  Future<Widget> getWeddingNumPage(
      BuildContext context, Profile profile, String header) async {
    var isPremium = await PremiumController.instance.isPremium();
    if (isPremium || !(Globals.instance.language is LanguageEn)) {
      return DescriptionWeddingBasedPage(
        categoryName: header,
        getPage: (profile, header) async =>
            await _getWeddingNumPage(context, profile, header),
      );
    }
    return PayWall();
  }

  Future<Widget> _getWeddingNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcWeddingNumber(profile);
    var tableName = 'MARRIAGE_NUMBER_ENG';

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getSoulNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getSoulNumPage(context, profile, header),
    );
  }

  Future<Widget> _getSoulNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcSoulNumber(profile);

    var tableName = 'SOUL_URGE_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'SOUL_URGE_NUMBER_RUS';
      return await _getSoulDescriptionPage(context, tableName, calc, header);
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'SOUL_URGE_NUMBER_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getDesireNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getDesireNumPage(context, profile, header),
    );
  }

  Future<Widget> _getDesireNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcDesireNumber(profile);
    var tableName = 'DESIRE_NUMBER_ENG';

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getNameNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getNameNumPage(context, profile, header),
    );
  }

  Future<Widget> _getNameNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcNameNumber(profile);
    var tableName = 'NAME_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'NAME_NUMBER_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'NAME_NUMBER_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getExpressionNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getExpressionNumPage(context, profile, header),
    );
  }

  Future<Widget> _getExpressionNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcExpressionNumber(profile);
    var tableName = 'EXPRESSION_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'EXPRESSION_NUMBER_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'EXPRESSION_NUMBER_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getRealizationNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getRealizationNumPage(context, profile, header),
    );
  }

  Future<Widget> _getRealizationNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcRealizationNumber(profile);
    var tableName = 'REALIZATION_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'REALIZATION_NUMBER_RUS';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getAchievementNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcAchievementNums(profile);
    var period = CategoryCalc.instance.calcAchievementPeriods(profile);

    var tableName = 'ACHIEVEMENT_NUMBER_RUS';
    var headers = [
      'Первый Пик - ${calc[0]}',
      'Второй Пик - ${calc[1]}',
      'Третий Пик - ${calc[2]}',
      'Четвёртый Пик - ${calc[3]}',
    ];

    if (Globals.instance.language is LanguageEs) {
      tableName = 'ACHIEVEMENT_NUMBER_ESP';
      headers = [
        'Primer período - ${calc[0]}',
        'Segundo período - ${calc[1]}',
        'Tercer período - ${calc[2]}',
        'Cuarto período - ${calc[3]}',
      ];
    }

    var descriptions = [];

    for (var i = 0; i < calc.length; i++) {
      var description = await runQuery(context,
          'select description from "$tableName"  where  number = ${calc[i]}');
      descriptions.add(period[i] + description);
    }

    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];

    for (var i = 0; i < 4; i++) {
      data.add(CardData(header: headers[i], description: descriptions[i]));
    }

    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      data: data,
    );
  }

  Future<Widget> getChallengeNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcChallengeNums(profile);

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
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'CHALLENGE_NUMBER_ESP';
      headers = [
        'El primer desafío - ',
        'El segundo desafío - ',
        'El tercer desafío - ',
        'El cuarto desafío - ',
      ];
    }

    calc.forEach((calc) async {
      var description = await runQuery(context,
          'select description from "$tableName"  where  number = $calc');
      descriptions.add(description);
    });

    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];

    for (var i = 0; i < 4; i++) {
      data.add(
          CardData(header: headers[i] + calc[i], description: descriptions[i]));
    }

    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      data: data,
    );
  }

  Future<Widget> lifePathNumPage(
      BuildContext context, Profile profile, String header) async {
    Map<String, String> _fromMapLifePath(Map<String, dynamic> map) {
      if (Globals.instance.getLanguage() is LanguageRu) {
        return {
          'Описание': map['description'] as String,
          'Любовь': map['love'] as String,
          'Мужчина': map['man'] as String,
          'Женщина': map['women'] as String,
        };
      }
      if (Globals.instance.getLanguage() is LanguageEs) {
        return {
          'Descripción': map['description'] as String,
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
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'LIFE_PATH_NUMBER_ESP';
    }

    var calc = CategoryCalc.instance.calcLifePathNumberMethod1(profile);

    Map<String, String> descriptions =
        await NumerologyDBProvider.instance.getEntity(
      'select * from "$tableName"  where  number = $calc',
      (map) => _fromMapLifePath(map),
    );

    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];

    descriptions.forEach((key, value) {
      data.add(CardData(header: key, description: value));
    });

    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      calculation: calc.toString(),
      data: data,
    );
  }

  Future<Widget> getPersonalityNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getPersonalityNumPage(context, profile, header),
    );
  }

  Future<Widget> _getPersonalityNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcPersonalityNumber(profile);
    var tableName = 'PERSONALITY_NUMBER_ENG';

    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'PERSONALITY_NUMBER_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'PERSONALITY_NUMBER_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getLuckyGemPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcLuckGem(profile);

    var tableName = 'LUCKY_GEM_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'LUCKY_GEM_RUS';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getBirthdayNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = DateService.fromTimestamp(profile.dob).day;
    var tableName = 'BIRTHDAY_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'BIRTHDAY_NUMBER_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'BIRTHDAY_NUMBER_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getBirthdayCodePage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcBirthdayCode(profile);
    var tableName = 'BIRTHDAY_CODE_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'BIRTHDAY_CODE_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'BIRTHDAY_CODE_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<Widget> getMaturityNumPage(
      BuildContext context, Profile profile, String header) async {
    return DescriptionNameBasedPage(
      categoryName: header,
      getPage: (profile, header) async =>
          await _getMaturityNumPage(context, profile, header),
    );
  }

  Future<Widget> _getMaturityNumPage(
      BuildContext context, Profile profile, String header) async {
    var calc = CategoryCalc.instance.calcMaturityNumber(profile);
    var tableName = 'MATURITY_NUMBER_ENG';
    if (Globals.instance.getLanguage() is LanguageRu) {
      tableName = 'MATURITY_NUMBER_RUS';
    } else if (Globals.instance.getLanguage() is LanguageEs) {
      tableName = 'MATURITY_NUMBER_ESP';
    }

    return await _getDescriptionPage(context, tableName, calc, header);
  }

  Future<DescriptionPage> _getDescriptionPage(
      BuildContext context, String tableName, int calc, String header) async {
    var description = await runQuery(
        context, 'select description from "$tableName"  where  number = $calc');
    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];
    data.add(CardData(
        header: Globals.instance.language.description,
        description: description));
    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      calculation: calc.toString(),
      data: data,
    );
  }

  Future<dynamic> runQuery(BuildContext context, String query) async {
    try {
      return await getEntityRawQuery(query);
    } catch (e) {
      context.read<UserDataCubit>().emitPrimaryUserError(e);
    }
  }

  Future<DescriptionPage> _getSoulDescriptionPage(
      BuildContext context, String tableName, int calc, String header) async {
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

    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];
    descriptions.forEach((key, value) {
      data.add(CardData(header: key, description: value));
    });
    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      calculation: calc.toString(),
      data: data,
    );
  }

  Future<DescriptionPage> _getMarriageDescriptionPage(
      BuildContext context, String tableName, int calc, String header) async {
    Map<String, String> _fromMapLifePath(Map<String, dynamic> map) {
      return {
        'Женщина': map['woman'] as String,
        'Мужчина': map['man'] as String,
      };
    }

    Map<String, String> descriptions =
        await NumerologyDBProvider.instance.getEntity(
      'select * from "$tableName"  where  number = $calc',
      (map) => _fromMapLifePath(map),
    );

    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$tableName"');

    List<CardData> data = [];
    descriptions.forEach((key, value) {
      data.add(CardData(header: key, description: value));
    });
    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      calculation: calc.toString(),
      data: data,
    );
  }

  Future<DescriptionPage> _getLoveDescriptionPage(
    BuildContext context,
    String table,
    String tableLove,
    int calc,
    int calcLove,
    String header,
    String partnerDob,
  ) async {
    Map<String, String> _fromMapLifePath(Map<String, dynamic> map) {
      return {
        'Описание': map['description'] as String,
        'Подробное описание': map['detailedDescription'] as String,
        'Мужчина': map['man'] as String,
        'Женщина': map['woman'] as String,
      };
    }

    Map<String, String> descriptions =
        await NumerologyDBProvider.instance.getEntity(
      'select * from "$table"  where  number = $calc',
      (map) => _fromMapLifePath(map),
    );

    var description = await runQuery(
        context, 'select description from $tableLove where number = $calcLove');

    var dob =
        'День рождения партнёра $partnerDob (Вы можете изменить это в настройках)';

    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name =  "$table"');

    List<CardData> data = [];
    data.add(CardData(
        header: 'Совместимость', description: description + '\n\n' + dob));
    descriptions.forEach((key, value) {
      data.add(CardData(header: key, description: value));
    });
    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      data: data,
    );
  }

  Future<DescriptionPage> _getKarmaDescriptionPage(BuildContext context,
      String tableName, List<int> calc, String header) async {
    List<String> descriptions = [];
    var headers = [];

    for (int i = 1; i < calc.length; i++) {
      if (calc[i] > 0) {
        var frequency = calc[i] > 3 ? 'lot' : 'few';
        headers.add(frequency == 'lot' ? 'Muchos $i' : 'Pocos $i');
        var description = await runQuery(context,
            'select description from $tableName where frequency = "$frequency" AND number = "$i"');
        descriptions.add(description);
      }
    }

    var info = await runQuery(context,
        'select description from TABLE_DESCRIPTION where table_name = "$tableName"');

    List<CardData> data = [];
    for (int i = 0; i < descriptions.length; i++) {
      data.add(CardData(header: headers[i], description: descriptions[i]));
    }

    data.add(
        CardData(header: Globals.instance.language.info, description: info));

    return DescriptionPage(
      adController,
      header: header,
      data: data,
    );
  }
}
