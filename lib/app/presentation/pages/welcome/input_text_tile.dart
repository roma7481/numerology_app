import 'package:flutter/material.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/localization/locale_utils.dart';

Center buildTextInputTile(BuildContext context, String hintText,
    TextEditingController textController) {
  var padding = MediaQuery.of(context).size.width * 0.2;

  return Center(
    child: Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: TextField(
        cursorColor: cursorColor,
        controller: textController,
        inputFormatters: LocaleUtils.keyboardInputFormatter(),
        style: TextStyle(color: inputTextColor),
        decoration: InputDecoration(
          hintStyle: TextStyle(fontSize: 17.0, color: hintColor),
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
