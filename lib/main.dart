import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/cubit/forecast/forecast_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'app/business_logic/cubit/language/language_cubit.dart';
import 'app/constants/strings.dart';
import 'app/presentation/pages/page_decider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<LanguageCubit>(
          create: (context) => LanguageCubit(),
          lazy: false,
        ),
        BlocProvider<BioCubit>(
          create: (context) => BioCubit(),
        ),
        BlocProvider<ForecastCubit>(
          create: (context) => ForecastCubit(),
        ),
        BlocProvider<BioSecondCubit>(
          create: (context) => BioSecondCubit(),
        ),
        BlocProvider<UserDataCubit>(
          create: (context) => UserDataCubit(),
          lazy: false,
        ),
        BlocProvider<ProfilesCubit>(
          create: (context) => ProfilesCubit(),
          lazy: false,
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
