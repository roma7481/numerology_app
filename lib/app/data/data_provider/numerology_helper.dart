import 'package:numerology/app/data/repository/numerology_db.dart';
import 'package:synchronized/synchronized.dart';

class NumerologyDBProvider {
  static final _lock = Lock();

  NumerologyDBProvider._privateConstructor();

  static final NumerologyDBProvider instance =
      NumerologyDBProvider._privateConstructor();

  Future<dynamic> getEntity(String query, Function fromMap) async {
    return _lock.synchronized(() async {
      var db = NumerologyDBRepository.instance;
      var entities = await db.getEntity(query, fromMap);
      await db.closeDB();
      return entities;
    });
  }
}
