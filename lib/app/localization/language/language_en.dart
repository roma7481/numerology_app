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
}
