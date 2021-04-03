import 'languages.dart';

class LanguageEn extends Languages {
  const LanguageEn();

  @override
  String get selectLanguage => 'Please select language';

  @override
  String get welcomeToNumerology => 'Welcome to Numerology';

  @override
  String get continueText => 'Continue';

  @override
  String get selectDateOfBirth => 'Please enter date of birth';

  @override
  String get welcomeText =>
      'Let\'s start by setting your language and date of birth. Date of birth is required for Numerological calculations.';

  @override
  String get dateOfBirth => 'Date of birth';

  @override
  String get enterBirthdayWarning => 'Please enter date of birth';

  @override
  String get nameSettings => 'Name Settings';

  @override
  String get nameSettingsText =>
      'Some categories require Name and Last Name. You can skip this step by clicking Continue and set it later.';

  @override
  String get enterName => 'Please enter your name';

  @override
  String get firstName => 'First name';

  @override
  String get lastName => 'Last name';

  @override
  String get middleName => 'Middle name';

  @override
  String get nameSettingsNotice =>
      'If you have more then one Middle name, please enter all '
      'of them inside the Middle name field with space between them.';

  @override
  String get forecastTabText => 'Forecast';

  @override
  String get homeTabText => 'Home';

  @override
  String get profileTabText => 'Profile';

  @override
  String get settingsTabText => 'Settings';

  @override
  String get errorMessageContent => 'Nothing here';

  @override
  String get errorMessageHeader =>
      'Something went wrong please try again later';

  @override
  String get description => 'Description';

  @override
  String get info => 'Info';

  @override
  String get readMore => 'Read more ...';

  @override
  String get categoryRequiresName => 'This category requires a name';

  @override
  String get enterMissingData => 'Please enter the missing data';

  @override
  String get enterWeddingDate => 'Please enter Wedding date';

  @override
  String get weddingDate => 'Wedding Date';

  @override
  String get numberOfDigits => 'Number of digits: ';

  @override
  String get clickOnAnyCell => 'Click on any cell';
}
