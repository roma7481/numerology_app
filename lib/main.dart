import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:notification_permissions/notification_permissions.dart';
import 'package:numerology/app/business_logic/cubit/bio/bio_cubit.dart';
import 'package:numerology/app/business_logic/cubit/notifications_cubit/notifications_cubit.dart';
import 'package:numerology/app/business_logic/cubit/other_app_cubit/OtherAppCubit.dart';
import 'package:numerology/app/business_logic/cubit/profiles/profiles_cubit.dart';
import 'package:numerology/app/business_logic/cubit/text_size_cubit/text_size_cubit.dart';
import 'package:numerology/app/business_logic/cubit/user_data/user_data_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import 'app/business_logic/cubit/bio_second/bio_second_cubit.dart';
import 'app/business_logic/cubit/forecast/forecast_cubit.dart';
import 'app/business_logic/cubit/forecast/forecast_index_cubit.dart';
import 'app/business_logic/cubit/language/language_cubit.dart';
import 'app/business_logic/cubit/purchases/purchases_cubit.dart';
import 'app/business_logic/cubit/rate_us/rate_us_cubit.dart';
import 'app/business_logic/services/ads/ad_service.dart';
import 'app/business_logic/services/ads/interestitial_controller.dart';
import 'app/constants/colors.dart';
import 'app/constants/strings.dart';
import 'app/presentation/common_widgets/progress_bar.dart';
import 'app/presentation/pages/page_decider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  InAppPurchaseConnection.enablePendingPurchases();

  InterestitialController interController = InterestitialController.instance;
  interController.createInterstitialAd();

  await Firebase.initializeApp();

  await _setupNotifications();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  await AdManager.setup();

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

Future<void> _displayFundingDialog() async {
  WidgetsBinding.instance.addPostFrameCallback((_) async {
    ConsentInformation consentInfo =
        await FlutterFundingChoices.requestConsentInformation();
    if (consentInfo.isConsentFormAvailable &&
        consentInfo.consentStatus == ConsentStatus.REQUIRED_IOS) {
      await FlutterFundingChoices.showConsentForm();
      // You can check the result by calling `FlutterFundingChoices.requestConsentInformation()` again !
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
        BlocProvider<PurchasesCubit>(
          create: (context) => PurchasesCubit(),
          lazy: false,
        ),
        BlocProvider<RateUsCubit>(
          create: (context) => RateUsCubit(),
        ),
        BlocProvider<ForecastIndexCubit>(
          create: (context) => ForecastIndexCubit(),
        ),
        BlocProvider<NotificationsCubit>(
          create: (context) => NotificationsCubit(),
        ),
        BlocProvider<TextSizeCubit>(
          create: (context) => TextSizeCubit(),
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
          create: (context) => profilesCubit,
          lazy: false,
        ),
        BlocProvider<ForecastCubit>(
          create: (context) => ForecastCubit(),
        ),
        BlocProvider<OtherAppCubit>(
          create: (context) => OtherAppCubit(),
        ),
      ],
      child: MaterialApp(
        title: numerology,
        theme: ThemeData(
          unselectedWidgetColor: Colors.white,
          primarySwatch: MaterialColor(appBarColor, appBarColorMap),
        ),
        home: _displayHomePage(),
      ),
    );
  }

  FutureBuilder<PermissionStatus> _displayHomePage() {
    return FutureBuilder(
        future: NotificationPermissions.getNotificationPermissionStatus(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == PermissionStatus.granted ||
                snapshot.data == PermissionStatus.denied ||
                snapshot.data == PermissionStatus.provisional) {
              _displayFundingDialog();
              return PageDecider();
            }
          }
          return progressBar();
        });
  }
}
