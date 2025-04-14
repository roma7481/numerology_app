import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/constants.dart';

part 'text_size_state.dart';

class TextSizeCubit extends Cubit<TextSizeState> with HydratedMixin {
  var smallTextModeState = TextSizeState(textSize: smallTextSize, buttonId: 0);
  var mediumTextModeState =
      TextSizeState(textSize: mediumTextSize, buttonId: 1);
  var largeTextModeState = TextSizeState(textSize: largeTextSize, buttonId: 2);

  TextSizeCubit()
      : super(TextSizeState(textSize: mediumTextSize, buttonId: 1)) {
    Globals.instance.setTextSize(textSize: this.state.textSize);
  }

  void emitTextSize(int buttonId) async {
    if (buttonId == smallTextModeState.buttonId) {
      emitTextSizeSmall();
    } else if (buttonId == largeTextModeState.buttonId) {
      emitTextSizeLarge();
    } else {
      emitTextSizeMedium();
    }
  }

  void emitTextSizeSmall() async {
    emit(smallTextModeState);
    Globals.instance.setTextSize(textSize: smallTextSize);
  }

  void emitTextSizeMedium() async {
    emit(mediumTextModeState);
    Globals.instance.setTextSize(textSize: mediumTextSize);
  }

  void emitTextSizeLarge() async {
    emit(largeTextModeState);
    Globals.instance.setTextSize(textSize: largeTextSize);
  }

  @override
  TextSizeState fromJson(Map<String, dynamic> json) {
    TextSizeState _state = TextSizeState.fromJson(json);
    return _state;
  }

  @override
  Map<String, dynamic> toJson(TextSizeState state) {
    return state.toJson();
  }
}
