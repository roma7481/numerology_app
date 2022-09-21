import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:numerology/app/business_logic/services/premium/premium_controller.dart';

import 'ad_counter.dart';
import 'ad_service.dart';

class InterestitialController {
  InterestitialController._();
  static final instance = InterestitialController._();
  static final premiumController = PremiumController.instance;

  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  InterstitialAd _interstitialAd;
  Function() _callback;

  static final AdRequest request = AdRequest(
    keywords: <String>[         //TODO
      'Online shopping',
      'clothes online',
      'Entertainment',
      'free streaming',
      'cooking',
      'recipes',
      'astrology',
      'tarot',
      'psychic reading',
      'pharmacy',
      'cosmetics',
      'baby',],
    nonPersonalizedAds: true, //TODO
  );

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdManager.interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void setCallback(Function() callback) {
    this._callback = callback;
  }

  void _loadPage(void Function() callback) {
    callback();
  }

  Future<void> showInterstitialAd() async{
    _loadPage(_callback);

    bool isPremium = await premiumController.isPremium();
    if (!isPremium) {
      var adCounter = await AdsCounter.instance.getAdsCounter();
      if (adCounter >= AdsCounter.maxNumClicks) {
        _showRegularAdd();
        AdsCounter.instance.resetAdCounter();
      } else {
        await AdsCounter.instance.increaseAdCounter();
      }
    }
  }

  void _showRegularAdd() {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          debugPrint('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        debugPrint('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }
}
