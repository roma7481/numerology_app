import 'dart:io';

// String testBannerAppId = 'ca-app-pub-3940256099942544/6300978111';
String realBannerAppId = 'ca-app-pub-1763151471947181/2896133568';

// String testInterestialAppId = 'ca-app-pub-3940256099942544/4411468910';
String realInterestialAppId = 'ca-app-pub-1763151471947181/1583051892';

// String testNativeAppId = 'ca-app-pub-3940256099942544/3986624511';
String realNativeAppId = 'ca-app-pub-1763151471947181/5330725218';

class AdManager {
  static String get appId {
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
}
