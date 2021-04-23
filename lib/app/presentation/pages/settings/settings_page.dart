import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';

import 'dialog/landuages_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildContent(context);
  }

  Scaffold _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        title: Text(Globals.instance.language.settings),
      ),
      body: _buildPageBody(context),
    );
  }

  Widget _buildPageBody(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: CustomScrollView(
        slivers: [buildRecord(context)],
      ),
    );
  }

  Widget buildRecord(BuildContext context) {
    var language = Globals.instance.getLanguage();
    return SliverToBoxAdapter(
        child: SafeArea(
      child: Column(
        children: [
          _buildFirstSetting1(language, context),
          // _buildMoreApps(language, context),
          // _buildFirstSetting2(language, context),
        ],
      ),
    ));
  }

  Padding _buildFirstSetting1(Languages language, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Align(
        //To make container wrap parent you can wrap it in align
        alignment: Alignment.topCenter,
        child: CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 16.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSetting(Icons.language, language.language, context,
                    () => _showLanguageDialog(context)),
                _buildLine(context),
                // _buildSetting(Icons.notifications_none, language.notifications,
                //     context, () => _showNotificationDialog(context)),
                // _buildLine(context),
                // _buildSetting(Icons.format_size, language.textSize, context,
                //         () => _showTextSizeDialog(context)),
                // _buildLine(context),
                // _buildSetting(Icons.restore, language.restorePurchase, context,
                //         () => _restorePurchase(context)),
                // _buildPremium(language, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showCupertinoModalPopup(
        context: context, builder: (context) => LanguageDialog());
  }

  Padding _buildLine(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 0.0),
      child: Container(
        height: 1.0,
        width: MediaQuery.of(context).size.width * 0.68,
        color: cardLineColor,
      ),
    );
  }

  Widget _buildSetting(
      IconData icon, String text, BuildContext context, Function onClick) {
    var customIcon = Icon(
      icon,
      color: settingsIconColor,
    );
    return _buildSettingWithIcon(onClick, customIcon, text);
  }

  Widget _buildSettingWithIcon(Function onClick, Widget icon, String text) {
    return TextButton(
      onPressed: () {
        onClick();
      },
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: icon,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: Text(
              text,
              style: headerTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
