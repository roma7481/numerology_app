import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerology/app/business_logic/cubit/rate_us/rate_us_cubit.dart';
import 'package:numerology/app/presentation/pages/bottom_navigator/tab_item.dart';
import 'package:numerology/app/presentation/pages/forecast/forecast_page.dart';
import 'package:numerology/app/presentation/pages/home/home_page.dart';
import 'package:numerology/app/presentation/pages/profiles/profiles_page.dart';
import 'package:numerology/app/presentation/pages/settings/dialog/rate_us_dialog.dart';
import 'package:numerology/app/presentation/pages/settings/settings_page.dart';

import 'cuppertino_home_scaffold.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TabItem _currentTab = TabItem.home;

  @override
  void initState() {
    super.initState();
  }

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.home: GlobalKey<NavigatorState>(),
    TabItem.forecast: GlobalKey<NavigatorState>(),
    TabItem.profile: GlobalKey<NavigatorState>(),
    TabItem.settings: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.home: (_) => HomePage(),
      TabItem.forecast: (_) => ForecastPage(),
      TabItem.profile: (_) => ProfilesPage(),
      TabItem.settings: (_) => SettingsPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RateUsCubit, RateUsState>(
      listener: (context, state) {
        if (state.shouldShowDialog!) {
          RateApp.showYesNoDialog(context);
          context.read<RateUsCubit>().emitStopShowing();
        }
      },
      child: WillPopScope(
        onWillPop: () async =>
            !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
        child: CupertinoHomeScaffold(
          currentTab: _currentTab,
          onSelectTab: _select,
          widgetBuilders: widgetBuilders,
          navigatorKeys: navigatorKeys,
        ),
      ),
    );
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }
    setState(() => _currentTab = tabItem);
  }
}
