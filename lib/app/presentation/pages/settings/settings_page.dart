import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/icon_path.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dialog/landuages_dialog.dart';
import 'dialog/notification_dialog.dart';

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
          _buildMoreApps(),
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
                _buildSetting(Icons.notifications_none, language.notifications,
                    context, () => _showNotificationDialog(context)),
                _buildLine(context),
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

  void _showNotificationDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => NotificationDialog(),
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

  _buildMoreApps() {
    var customIcon = ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        height: 30,
        child: Image.asset(tarotIcon),
      ),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: Text(
            Globals.instance.getLanguage().moreApps,
            style: headerTextStyle,
          ),
        ),
        Padding(
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildSettingWithIcon(
                          () => _openLink(tarotAppURL),
                          customIcon,
                          Globals.instance.language.tarotApp,
                        ),
                        _buildAd(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ClipRRect _buildAd() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Container(
        color: datePickerItem,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'Ad',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _openLink(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url, forceSafariVC: false);
      }
    } catch (e) {
      Fluttertoast.showToast(
        msg: Globals.instance.language.errorTryLater,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_SHORT,
      );
    }
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
