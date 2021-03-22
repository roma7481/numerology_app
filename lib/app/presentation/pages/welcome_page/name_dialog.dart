import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/localization/locale_utils.dart';

class NameDialog extends StatefulWidget {
  @override
  _NameDialogState createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _buildNameDialog(context);
  }

  _buildNameDialog(BuildContext context) {
    var lang = Globals.instance.language;
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Column(
        children: [
          _buildHeader(),
          _buildTextInputTile(context, lang.firstName),
          _buildTextInputTile(context, lang.lastName),
          _buildTextInputTile(context, lang.middleName),
        ],
      ),
    );
  }

  Center _buildTextInputTile(BuildContext context, String hintText) {
    var padding = MediaQuery.of(context).size.width * 0.2;

    return Center(
          child: Padding(
            padding: EdgeInsets.only(left: padding, right: padding),
            child: TextField(
              inputFormatters: LocaleUtils.keyboardInputFormatter(),
              style: TextStyle(color: inputTextColor),
              decoration: InputDecoration(
                hintStyle: TextStyle(fontSize: 20.0, color: hintColor),
                hintText: hintText,
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: inputTextUnfocused),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: inputTextFocused),
                ),
              ),
            ),
          ),
        );
  }

  Text _buildHeader() {
    return Text(
          Globals.instance.language.enterName,
          style: radioButtonTextStyle,
        );
  }


}
