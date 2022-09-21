import 'dart:collection';
import 'dart:io';

import 'package:google_mobile_ads/google_mobile_ads.dart';

// String testBannerAppId = 'ca-app-pub-3940256099942544/6300978111';
String realBannerAppId = 'ca-app-pub-1763151471947181/2896133568';

// String testInterestialAppId = 'ca-app-pub-3940256099942544/4411468910';
String realInterestialAppId = 'ca-app-pub-1763151471947181/1583051892';

// String testNativeAppId = 'ca-app-pub-3940256099942544/3986624511';
String realNativeAppId = 'ca-app-pub-1763151471947181/5330725218';

class AdManager {
  static int _loadNativeAdAttempts = 0;
  static final Queue<NativeAd> _admobAdQueue = Queue<NativeAd>();
  static NativeAd _admobNativeIntermediateAd;

  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return realNativeAppId;
    } else if (Platform.isIOS) {
      return realNativeAppId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return realBannerAppId;
    } else if (Platform.isIOS) {
      return realBannerAppId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return realInterestialAppId;
    } else if (Platform.isIOS) {
      return realInterestialAppId;
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "<YOUR_ANDROID_REWARDED_AD_UNIT_ID>";
    } else if (Platform.isIOS) {
      return "<YOUR_IOS_REWARDED_AD_UNIT_ID>";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static setup() async {
    await MobileAds.instance.initialize();
    MobileAds.instance.setAppVolume(0);
    MobileAds.instance.setAppMuted(true);
    await _loadNativeAd();
  }

  static NativeAd getNativeAd() {
    if (_admobAdQueue.isNotEmpty) {
      _loadNativeAd();
      final ad = _admobAdQueue.first;
      _admobAdQueue.removeFirst();
      return ad;
    }
    return null;
  }

  static _loadNativeAd() async {
    if (_admobNativeIntermediateAd != null) return;
    _admobNativeIntermediateAd = NativeAd(
      adUnitId: nativeAdUnitId,
      factoryId: 'healingAdFactory',
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          _admobAdQueue.add(_admobNativeIntermediateAd);
          _admobNativeIntermediateAd = null;
          if (_admobAdQueue.length < 5) {
            _loadNativeAd();
          }
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
          _loadNativeAdAttempts++;
          if (_loadNativeAdAttempts < 3) {
            _admobNativeIntermediateAd?.load();
          }
        },
        onAdOpened: (Ad ad) {} ,
        onAdClosed: (Ad ad) {},
        onAdImpression: (Ad ad) {},
      ),
    );
    await _admobNativeIntermediateAd?.load();
  }

}
