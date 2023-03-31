import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_funding_choices/flutter_funding_choices.dart';
import 'package:numerology/app/business_logic/cubit/other_app_cubit/OtherAppCubit.dart';
import 'package:numerology/app/business_logic/cubit/purchases/purchases_cubit.dart';
import 'package:numerology/app/business_logic/globals/globals.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/constants/strings.dart';
import 'package:numerology/app/constants/text_styles.dart';
import 'package:numerology/app/localization/language/language_ru.dart';
import 'package:numerology/app/localization/language/languages.dart';
import 'package:numerology/app/presentation/common_widgets/ad_widget_tag.dart';
import 'package:numerology/app/presentation/common_widgets/custom_card.dart';
import 'package:numerology/app/presentation/common_widgets/error_dialog.dart';
import 'package:numerology/app/presentation/common_widgets/progress_bar.dart';
import 'package:numerology/app/presentation/common_widgets/toast.dart';
import 'package:numerology/app/presentation/navigators/navigator.dart';
import 'package:numerology/app/presentation/pages/settings/open_link.dart';
import 'package:numerology/app/presentation/pages/settings/settings_with_icon.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'attribution/attribution_page.dart';
import 'dialog/languages_dialog.dart';
import 'dialog/notification_dialog.dart';
import 'dialog/rate_us_dialog.dart';
import 'dialog/text_size_dialog.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<PurchasesCubit, PurchasesState>(
        listener: (context, state) {
          if (state is PurchasesRestored) {
            showToast(Globals.instance.getLanguage().purchaseRestored);
          }
        },
        child: _buildContent(context));
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
          _buildMoreApps(context),
          _buildFirstSetting2(language, context),
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
                left: 12.0, right: 12.0, top: 4.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSetting(Icons.language, language.language, context,
                    () => _showLanguageDialog(context)),
                _buildLine(context),
                _buildSetting(Icons.notifications_none, language.notifications,
                    context, () => _showNotificationDialog(context)),
                _buildLine(context),
                _buildSetting(Icons.format_size, language.textSize, context,
                    () => _showTextSizeDialog(context)),
                _buildLine(context),
                _buildSetting(Icons.restore, language.restorePurchase, context,
                    () => _restorePurchase(context)),
                _buildPremium(language, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _restorePurchase(BuildContext context) async {
    await context.read<PurchasesCubit>().restorePurchases();
  }

  Widget _buildPremium(Languages language, BuildContext context) {
    return FutureBuilder<bool>(
        future: PremiumController.instance.isPremium(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return progressBar();
            default:
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                var isPremium = snapshot.data;
                if (isPremium) {
                  return Container();
                } else {
                  return Column(
                    children: [
                      _buildLine(context),
                      _buildSetting(
                        Icons.stars,
                        language.goPremium,
                        context,
                        () => navigateToPremium(context),
                      ),
                    ],
                  );
                }
              }
          }
        });
  }

  void _showTextSizeDialog(BuildContext context) {
    showCupertinoModalPopup(
        context: context, builder: (context) => TextSizeDialog());
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

  Widget _buildMoreApps(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            Globals.instance.getLanguage().moreApps,
            style: headerTextStyle,
          ),
        ),
        _getMoreApps(context)
      ],
    );
  }

  Widget _getMoreApps(BuildContext context) {
    OtherAppCubit otherAppCubit = OtherAppCubit();
    otherAppCubit.loadOtherApps(context);


    return CustomCard(
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: BlocBuilder<OtherAppCubit, OtherAppsState>(
              bloc: otherAppCubit,
              builder: (context, state) {
                if (state is OtherAppsLoading) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.white));
                } else if (state is OtherAppsLoaded) {
                  return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: state.otherApps
                          .map((e) => GestureDetector(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(children: [
                                    Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          child: CachedNetworkImage(
                                              fadeInDuration: Duration.zero,
                                              fadeOutDuration: Duration.zero,
                                              height: 66,
                                              width: 66,
                                              imageUrl: e.imageLink,
                                              fit: BoxFit.cover),
                                        ),
                                        adWidgetTag()
                                      ],
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 14),
                                        child: SizedBox(
                                            width: 90,
                                            child: Text(e.name, style: moreAppsTextStyle, textAlign: TextAlign.center,)))
                                  ]),
                                ),
                                onTap: () {
                                  launchUrl(Uri.parse(e.link),
                                      mode: LaunchMode.externalApplication);
                                },
                              ))
                          .toList());
                } else {
                  return errorDialog();
                }
              })),
    );
  }


  Widget _buildSetting(
      IconData icon, String text, BuildContext context, Function onClick) {
    var customIcon = Icon(
      icon,
      color: settingsIconColor,
    );
    return buildSettingWithIcon(onClick, customIcon, text);
  }

  Padding _buildFirstSetting2(Languages language, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Align(
        //To make container wrap parent you can wrap it in align
        alignment: Alignment.topCenter,
        child: CustomCard(
          child: Padding(
            padding: const EdgeInsets.only(
                left: 12.0, right: 12.0, top: 4.0, bottom: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildSetting(
                  Icons.star,
                  language.rateUs,
                  context,
                  () => RateApp.openRateUsPage(context),
                ),
                _buildLine(context),
                _buildTelegramLink(context),
                _buildWebsiteLink(context),
                _buildSetting(
                  Icons.share,
                  language.shareApp,
                  context,
                  () => _shareApp(context),
                ),
                _buildLine(context),
                _buildSetting(
                  Icons.list_alt,
                  language.privacyPolicy,
                  context,
                  () => openLink(privacyPolicyURL),
                ),
                _buildLine(context),
                _buildSetting(Icons.info_outline, language.info, context,
                    () => _goToAttribution(context)),
                _buildConsent(context, language),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConsent(BuildContext context, Languages language) {
    return FutureBuilder<bool>(
        future: _shouldShowConsent(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return progressBar();
            default:
              if (snapshot.hasError) {
                return errorDialog();
              } else {
                var shodShowConsent = snapshot.data;
                if (!shodShowConsent) {
                  return Container();
                }
                return Column(
                  children: [
                    _buildLine(context),
                    _buildSetting(
                      Icons.article,
                      language.consent,
                      context,
                      () => _showConsent(),
                    ),
                  ],
                );
              }
          }
        });
  }

  Future<void> _showConsent() async {
    await FlutterFundingChoices.showConsentForm();
  }

  void _goToAttribution(BuildContext context) {
    Navigator.of(context, rootNavigator: true)
        .push(MaterialPageRoute(builder: (_) {
      return AttributionPage();
    }));
  }

  Future<bool> _shouldShowConsent() async {
    ConsentInformation consentInfo =
        await FlutterFundingChoices.requestConsentInformation();
    if (consentInfo.isConsentFormAvailable &&
        consentInfo.consentStatus == ConsentStatus.OBTAINED) {
      return true;
    }
    return false;
  }

  void _shareApp(BuildContext context) {
    final String url = linkToApp;
    final RenderBox box = context.findRenderObject();
    Share.share(url,
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Widget _buildTelegramLink(BuildContext context) {
    if (Globals.instance.getLanguage() is LanguageRu) {
      return Column(
        children: [
          _buildSetting(
            Icons.send,
            telegram,
            context,
            () => openLink(telegramURL),
          ),
          _buildLine(context),
        ],
      );
    }
    return Container();
  }

  Widget _buildWebsiteLink(BuildContext context) {
    if (Globals.instance.getLanguage() is LanguageRu) {
      return Column(
        children: [
          _buildSetting(
            Icons.web,
            ourWebsite,
            context,
            () => openLink(websiteURL),
          ),
          _buildLine(context),
        ],
      );
    }
    return Container();
  }
}
