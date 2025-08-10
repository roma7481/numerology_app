import 'package:firebase_remote_config/firebase_remote_config.dart';

class AppLinksService {
  static final AppLinksService instance = AppLinksService._();
  AppLinksService._();

  String healingSoundsUrl = '';
  String runesUrl = '';
  String tarotUrl = '';
  String numerologyUrl = '';

  Future<void> init() async {
    final remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setDefaults({
      'healing_sounds_app_url': 'https://healingsounds.app.link/sleep-now',
      'runes_app_url': 'https://apps.apple.com/us/app/runes-daily-reading/id1558378053',
      'tarot_app_url': 'https://apps.apple.com/us/app/tarot-card-of-the-day/id1556452544',
      'numerology_app_url': 'https://apps.apple.com/us/app/numerology-biorhythm/id1564315932',
    });

    await remoteConfig.fetchAndActivate();

    healingSoundsUrl = remoteConfig.getString('healing_sounds_app_url');
    runesUrl = remoteConfig.getString('runes_app_url');
    tarotUrl = remoteConfig.getString('tarot_app_url');
    numerologyUrl = remoteConfig.getString('numerology_app_url');
  }
}