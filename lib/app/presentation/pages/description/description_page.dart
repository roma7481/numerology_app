import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/app/business_logic/services/ads/ad_service.dart';
import 'package:numerology/app/business_logic/services/ads/native_admob_controller.dart';
import 'package:numerology/app/business_logic/services/ads/show_native_ad.dart';
import 'package:numerology/app/constants/colors.dart';
import 'package:numerology/app/presentation/common_widgets/foldable_card_widget.dart';

import 'circle_widget.dart';
import 'matrix_line_data.dart';

class DescriptionPage extends StatelessWidget {
  final String header;
  final String calculation;
  final List<CardData> data;
  final NativeAdmobController adController;

  AdWidget adWidget;

  final BannerAd myBanner = BannerAd(
    adUnitId: realBannerAppId,
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (Ad ad) => print('Ad loaded.'),
      // Called when an ad request failed.
      onAdFailedToLoad: (Ad ad, LoadAdError error) {
        ad.dispose();
        print('Ad failed to load: $error');
      },
      // Called when an ad opens an overlay that covers the screen.
      onAdOpened: (Ad ad) => print('Ad opened.'),
      // Called when an ad removes an overlay that covers the screen.
      onAdClosed: (Ad ad) => print('Ad closed.'),
      // Called when an ad is in the process of leaving the application.
      onApplicationExit: (Ad ad) => print('Left application.'),
    ),
  );

  DescriptionPage(
    this.adController, {
    this.calculation = '',
    this.header = '',
    this.data = const [],
  });

  @override
  Widget build(BuildContext context) {
    myBanner.load();
    adWidget = AdWidget(ad: myBanner);
    return _buildPageContent(context);
  }

  Widget _buildPageContent(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true, title: Text(header), brightness: Brightness.dark),
      body: _buildContext(context),
    );
  }

  Widget _buildContext(BuildContext context) {
    var listHeight = MediaQuery.of(context).size.height - myBanner.size.height - AppBar().preferredSize.height - 20.0;

    return Container(
        color: backgroundColor,
        child: Column(
          children: [
            SizedBox(
              height: listHeight,
              child: CustomScrollView(
                slivers: [
                  _buildNumberIcon(context, calculation),
                  _buildList(data),
                ],
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: adWidget,
              width: myBanner.size.width.toDouble(),
              height: myBanner.size.height.toDouble(),
            ),
          ],
        ));
  }

  Widget _buildNumberIcon(BuildContext context, String calculation) {
    if (calculation.isEmpty) {
      return SliverToBoxAdapter(child: Container());
    }
    return SliverToBoxAdapter(
      child: Container(
        width: 400,
        height: 200,
        child: CustomPaint(
          painter: OpenPainter(context, calculation),
        ),
      ),
    );
  }

  Widget _buildList(List<CardData> data) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) {
        var item = data[index];
        return Column(children: [
          showAdInList(adController, data, index),
          buildExpandCard(item.header, item.description, item.iconPath),
        ]);
      },
      childCount: data.length,
    ));
  }
}
