import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/pages/welcome/welcome_page.dart';

import 'bottom_navigator/main_page.dart';

class PageDecider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      if (state is UserDataReady) {
        var page = state.profile == null ? WelcomePage() : MainPage();
        return page;
      } else if (state is UserDataError) {
        return errorDialog();
      }
      return progressBar();
    });
  }
}
