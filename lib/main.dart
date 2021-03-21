import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:numerology/app/presentation/welcome_page/welcome_page.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app/business_logic/cubit/language/language_cubit.dart';
import 'app/constants/strings.dart';

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
      ],
      child: MaterialApp(
        title: numerology,
        theme: ThemeData(
          unselectedWidgetColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        home: WelcomePage(),
      ),
    );
  }
}
