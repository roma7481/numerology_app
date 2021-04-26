import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'ad_service.dart';

BannerAd getBanner() {
  return BannerAd(
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
}

Widget showBanner(AdWidget adWidget, BannerAd banner) {
  return Container(
    alignment: Alignment.center,
    child: adWidget,
    width: banner.size.width.toDouble(),
    height: banner.size.height.toDouble(),
  );
}

double calcListHeight(BuildContext context, BannerAd banner) {
  return MediaQuery.of(context).size.height -
      banner.size.height -
      AppBar().preferredSize.height -
      20.0;
}
