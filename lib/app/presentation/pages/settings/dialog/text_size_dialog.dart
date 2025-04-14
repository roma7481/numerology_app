import 'package:flutter/cupertino.dart';
import 'package:numerology/app/business_logic/cubit/text_size_cubit/text_size_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:provider/provider.dart';

class TextSizeDialog extends StatefulWidget {
  @override
  State createState() => new TextSizeDialogState();
}

class TextSizeDialogState extends State<TextSizeDialog> {
  static const Map<int, String> allButtons = {
    0: small,
    1: medium,
    2: large,
  };

  @override
  Widget build(BuildContext context) {
    /// platform dependent dialog usage example
    // return Platform.isIOS
    //     ? _cupertinoDialog(context)
    //     : _materialDialog(context);
    return _cupertinoDialog(context);
  }

  Widget _cupertinoDialog(BuildContext context) {
    var language = Globals.instance.getLanguage();
    var _selectedButton = context.watch<TextSizeCubit>().state.buttonId;
    return CupertinoActionSheet(
      title: Text(
        language.textSize,
        style: dialogHeaderTextStyle,
      ),
      message: Text(
        language.selectTextSize,
        style: dialogContentTextStyle,
      ),
      actions: List<Widget>.generate(allButtons.length, (int index) {
        var button = allButtons[index];
        return CupertinoActionSheetAction(
          onPressed: () {
            setState(() {
              var textSizeMode = index;
              _selectedButton = textSizeMode;
              context.read<TextSizeCubit>().emitTextSize(textSizeMode);
              Navigator.pop(context);
            });
          },
          isDefaultAction: _selectedButton == index,
          child: _getButtonText(button),
        );
      }),
    );
  }

  Widget _getButtonText(String? buttonText) {
    var language = Globals.instance.getLanguage();
    if (buttonText == small) {
      return Text(language.small);
    } else if (buttonText == large) {
      return Text(language.large);
    }
    return Text(language.medium);
  }
}
