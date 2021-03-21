import 'package:flutter/material.dart';
import 'package:numerology/app/constants/text_styles.dart';

class LanguagePicker extends StatefulWidget {
  @override
  _LanguagePickerState createState() => _LanguagePickerState();
}

class _LanguagePickerState extends State<LanguagePicker> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: [
        _buildHeader(),
        _buildRadioButton(1, 'English'),
        _buildRadioButton(2, 'Russian'),
        _buildRadioButton(3, 'Spanish'),
      ],
    );
  }

  Padding _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 36.0, bottom: 8.0),
      child: Text(
        'Please chose language',
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

  void onChanged(int value) {
    setState(() {
      _selected = value;
    });

    print('Value = $value');
  }
}
