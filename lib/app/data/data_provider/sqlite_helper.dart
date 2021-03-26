import 'package:numerology/app/data/models/profile.dart';
import 'package:numerology/app/data/repository/sqflite_db.dart';
import 'package:synchronized/synchronized.dart';

class DBProvider {
  static final _lock = Lock();

  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();

  Future<void> insertProfile(Profile profile) async {
    return _lock.synchronized(() async {
      var db = DBRepository.instance;
      await db.insertEntity(profile, (profile) => profile.toMap());
      await db.closeDB();
    });
  }

  Future<List<Profile>> getAllProfiles() async {
    return _lock.synchronized(() async {
      var db = DBRepository.instance;
      var profiles = await db.getAllEntities((map) => Profile.fromMap(map));
      await db.closeDB();
      return profiles;
    });
  }

  Future<Profile> getProfile(int profileId) async {
    return _lock.synchronized(() async {
      var db = DBRepository.instance;
      var retrievedProfile =
          await db.getEntity(profileId, (map) => Profile.fromMap(map));
      await db.closeDB();
      return retrievedProfile;
    });
  }

  Future<void> updateProfile(Profile profile) async {
    return _lock.synchronized(() async {
      var db = DBRepository.instance;
      var profiles = await db.updateEntity(
          profile, profile.profileId, (profile) => profile.toMap());
      await db.closeDB();
      return profiles;
    });
  }

  Future<void> deleteProfile(Profile profile) async {
    return _lock.synchronized(() async {
      var db = DBRepository.instance;
      var profiles = await db.deleteEntity(profile.profileId);
      await db.closeDB();
      return profiles;
    });
  }
}
