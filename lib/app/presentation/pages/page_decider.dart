import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:numerology/app/presentation/pages/welcome_page/welcome_page.dart';

import 'main/main_page.dart';

class PageDecider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(builder: (context, state) {
      var page = state.primaryProfileId == null ? WelcomePage() : MainPage();
      return page;
    });
  }
}
