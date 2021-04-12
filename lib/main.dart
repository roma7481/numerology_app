import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'app/business_logic/cubit/language/language_cubit.dart';
import 'app/constants/colors.dart';
import 'app/constants/strings.dart';
import 'app/presentation/pages/page_decider.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: backgroundColor,
    statusBarIconBrightness: Brightness.light,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en');
    var userDataCubit = UserDataCubit();
    return MultiProvider(
      providers: [
        BlocProvider<UserDataCubit>(
          create: (context) => userDataCubit,
          lazy: false,
        ),
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
          lazy: false,
        ),
        BlocProvider<BioCubit>(
          create: (context) => BioCubit(),
        ),
        BlocProvider<BioSecondCubit>(
          create: (context) => BioSecondCubit(),
        ),
        BlocProvider<ProfilesCubit>(
          create: (context) => ProfilesCubit(),
          lazy: false,
        ),
        BlocProvider<ForecastCubit>(
          create: (context) => ForecastCubit(userDataCubit),
        ),
      ],
      child: MaterialApp(
        title: numerology,
        theme: ThemeData(
          unselectedWidgetColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: PageDecider(),
      ),
    );
  }
}
