import 'package:bloc/bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/strings.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> with HydratedMixin {
  LanguageCubit()
      : super(LanguageState(
          locale: en,
          buttonId: 0,
          firsTimeAppVisit: true,
        )) {
    Globals.instance.setLocale(localeCode: this.state.locale);
  }

  void emitLocale(String locale, int buttonId) {
    Globals.instance.setLocale(localeCode: locale);
    emit(LanguageState(
      locale: locale,
      buttonId: buttonId,
      firsTimeAppVisit: false,
    ));
  }

  @override
  LanguageState fromJson(Map<String, dynamic> json) {
    LanguageState _state = LanguageState.fromJson(json);
    return _state;
  }

  @override
  Map<String, dynamic> toJson(LanguageState state) {
    return state.toJson();
  }
}
