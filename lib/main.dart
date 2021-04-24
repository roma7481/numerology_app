import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/cubit/notifications_cubit/notifications_cubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'app/business_logic/cubit/forecast/forecast_cubit.dart';
import 'app/business_logic/cubit/language/language_cubit.dart';
import 'app/constants/colors.dart';
import 'app/constants/strings.dart';
import 'app/presentation/pages/page_decider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _setupNotifications();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: backgroundColor,
    statusBarIconBrightness: Brightness.light,
  ));

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

Future<void> _setupNotifications() async {
  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  var initializationSettingsAndroid =
      AndroidInitializationSettings(androidAppIcon);
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification:
          (int id, String title, String body, String payload) async {});
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('en');
    var profilesCubit = ProfilesCubit();
    return MultiProvider(
      providers: [
        BlocProvider<UserDataCubit>(
          create: (context) => UserDataCubit(),
          lazy: false,
        ),
        BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(),
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
          create: (context) => profilesCubit,
          lazy: false,
        ),
        BlocProvider<ForecastCubit>(
          create: (context) => ForecastCubit(),
        ),
      ],
      child: MaterialApp(
        title: numerology,
        theme: ThemeData(
          unselectedWidgetColor: Colors.white,
          primarySwatch: MaterialColor(appBarColor, appBarColorMap),
        ),
        home: PageDecider(),
      ),
    );
  }
}
