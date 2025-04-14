import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:provider/provider.dart';

class LanguageDialog extends StatefulWidget {
  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class LanguageItem {
  LanguageItem(
    this.locale,
    this.languageName,
  );

  final String locale;
  final String languageName;
}

class _LanguageDialogState extends State<LanguageDialog> {
  static Map<int, LanguageItem> allButtons = {
    0: LanguageItem(en, english),
    1: LanguageItem(ru, russian),
    2: LanguageItem(es, spanish),
    3: LanguageItem(pt, portuguese),
    4: LanguageItem(fr, french),
    5: LanguageItem(de, german),
    6: LanguageItem(it, italian),
  };

  @override
  Widget build(BuildContext context) {
    var language = Globals.instance.getLanguage();
    var _selectedButtonId = context.watch<LanguageCubit>().state.buttonId;
    return CupertinoActionSheet(
      title: Text(
        language.language,
        style: dialogHeaderTextStyle,
      ),
      message: Text(
        language.selectLanguage,
        style: dialogContentTextStyle,
      ),
      actions: List<Widget>.generate(allButtons.length, (int index) {
        var languageItem = allButtons[index]!;
        return CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              _selectedButtonId = index;
              context
                  .read<LanguageCubit>()
                  .emitLocale(languageItem.locale, index);
              Navigator.pop(context);
            });
          },
          isDefaultAction: _selectedButtonId == index,
          child: Text(languageItem.languageName),
        );
      }),
    );
  }
}
