import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:numerology/app/business_logic/cubit/language/language_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/date_service.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/presentation/common_widgets/custom_button.dart';

class BirthdayPicker extends StatefulWidget {
  const BirthdayPicker({Key key, this.onClick}) : super(key: key);
  final Function onClick;

  @override
  _BirthdayPickerState createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  var _selectedDate;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
        listener: (context, state) {},
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: Text(
                Globals.instance.getLanguage().selectDateOfBirth,
                style: radioButtonTextStyle,
              ),
            ),
            buildCustomButton(_getButtonText(), dateOfBirthButtonColor, () {
              DatePicker.showDatePicker(
                context,
                showTitleActions: true,
                onConfirm: (date) {
                  setState(() {
                    _selectedDate = date;
                    widget.onClick();
                  });
                },
                locale: Globals.instance.getLocaleType(),
                currentTime: DateService.getDateTimeMinusNumYear(25),
              );
            }, dateOfBirthButtonTextStyle),
          ],
        ));
  }

  String _getButtonText() {
    if (_selectedDate == null) {
      return Globals.instance.language.dateOfBirth;
    }
    return DateService.getFormattedDate(_selectedDate);
  }
}
