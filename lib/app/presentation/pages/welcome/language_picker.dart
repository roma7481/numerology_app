import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/localization/locale_utils.dart';
import 'package:provider/provider.dart';

class LanguagePicker extends StatefulWidget {
  @override
  _LanguagePickerState createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    _selected = context.watch<LanguageCubit>().state.buttonId;
    return new Column(
      children: [
        _buildHeader(),
        _buildRadioButton(0, english),
        _buildRadioButton(1, russian),
        _buildRadioButton(2, spanish),
        _buildRadioButton(3, portuguese),
        _buildRadioButton(4, french),
      ],
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        Globals.instance.getLanguage().selectLanguage,
        style: radioButtonTextStyle,
      ),
    );
  }

  Widget _buildRadioButton(int i, String text) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.24),
      child: RadioListTile(
        value: i,
        title: Text(
          text,
          style: languageTextStyle,
        ),
        groupValue: _selected,
        onChanged: (value) {
          onChanged(value as int);
        },
        activeColor: Colors.white,
      ),
    );
  }

  void onChanged(int index) {
    var languageItem =
        LocaleUtils.allLanguages[index] ??= LanguageItem(en, english);
    setState(() {
      _selected = index;
      context.read<LanguageCubit>().emitLocale(languageItem.locale, index);
    });
  }
}
