import 'package:shared_preferences/shared_preferences.dart';

final String _premiumKey = 'is_premium';
final String _compatKey = 'is_compat';
final String _profilesKey = 'is_profiles';
final String _adsKey = 'is_ads';

class PremiumController {
  PremiumController._();

  static final instance = PremiumController._();

  Future<void> enablePremium() async {
    await _enablePremium(_premiumKey);
  }

  Future<void> enableCompat() async {
    await _enablePremium(_compatKey);
  }

  Future<void> enableProfiles() async {
    await _enablePremium(_profilesKey);
  }

  Future<void> enableRemoveAds() async {
    await _enablePremium(_adsKey);
  }

  Future<void> disablePremium() async {
    await _disablePremium(_premiumKey);
  }

  Future<void> disableCompat() async {
    await _disablePremium(_compatKey);
  }

  Future<void> disableProfiles() async {
    await _disablePremium(_profilesKey);
  }

  Future<void> disableRemoveAds() async {
    await _disablePremium(_adsKey);
  }

  Future<void> _enablePremium(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, true);
  }

  Future<void> _disablePremium(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, false);
  }

  Future<bool> isPremium() async {
    return await _isPremium(_premiumKey);
  }

  Future<bool> isCompat() async {
    var futures = <Future<bool>>[];
    futures.add(isPremium());
    futures.add(_isPremium(_compatKey));

    List<bool> res = await Future.wait(futures);
    return res.contains(true);
  }

  Future<bool> isProfiles() async {
    var futures = <Future<bool>>[];
    futures.add(isPremium());
    futures.add(_isPremium(_profilesKey));

    List<bool> res = await Future.wait(futures);
    return res.contains(true);
  }

  Future<bool> isAdsFree() async {
    var futures = <Future<bool>>[];
    futures.add(isPremium());
    futures.add(_isPremium(_adsKey));

    List<bool> res = await Future.wait(futures);
    return res.contains(true);
  }

  Future<bool> _isPremium(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _isPremium = prefs.getBool(key);
    return _isPremium == null ? false : _isPremium;
  }
}
