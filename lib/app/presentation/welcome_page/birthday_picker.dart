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
  @override
  _BirthdayPickerState createState() => _BirthdayPickerState();
}

class _BirthdayPickerState extends State<BirthdayPicker> {
  var _selectedDate = DateService.getCurrentDate();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LanguageCubit, LanguageState>(
      listener: (context, state) {

      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 16.0),
            child: Text(
              Globals.instance.getLanguage().selectDateOfBirth,
              style: radioButtonTextStyle,
            ),
          ),
          buildCustomButton(
              DateService.getFormattedDate(_selectedDate), dateOfBirthButtonColor,
                  () {
                DatePicker.showDatePicker(
                  context,
                  showTitleActions: true,
                  onConfirm: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  locale: LocaleType.en,
                  currentTime: DateService.getDateTimeMinusNumYear(25),
                );
              }, dateOfBirthButtonTextStyle),
        ],
      )
    );
  }
}
