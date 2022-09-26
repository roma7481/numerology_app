import 'package:numerology/app/business_logic/services/ads/ad_service.dart';


Future<void> showInterestialAd(Function() navigateTo) async {
  await AdManager.showInterstitial();

  navigateTo();
}
