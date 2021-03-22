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
      'Some categories require Name and Last Name. You can skip this step by clicking Continue and set it later';

  @override
  String get enterName => 'Please enter your name';
}
