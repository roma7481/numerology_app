import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';

enum TabItem {
  home,
  forecast,
  profile,
  settings,
}

class TabItemData {
  TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;
}

class TabItemDataMap {
  var language = Globals.instance.getLanguage();

  Map<TabItem, TabItemData> getAllTabs() {
    return {
      TabItem.home: TabItemData(title: language.homeTabText, icon: Icons.home),
      TabItem.forecast: TabItemData(title: language.forecastTabText, icon: Icons.date_range),
      TabItem.profile: TabItemData(title: language.profileTabText, icon: Icons.person),
      TabItem.settings: TabItemData(title: language.settingsTabText, icon: Icons.more_vert),
    };
  }
}
