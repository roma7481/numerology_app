import 'ad_counter.dart';
import 'interestitial_controller.dart';

Future<void> showInterestialAd(Function() navigateTo) async {
  await AdsCounter.instance.increaseAdCounter();
  var adController = InterestitialController.instance;

  adController.setCallback(() => navigateTo());

  await adController.showInterstitialAd();
}
