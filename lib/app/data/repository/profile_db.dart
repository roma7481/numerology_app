import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ProfileDBRepository {
  static Database _database;
  static String _dbName = 'profile_database.db';
  static String _tableName = 'profiles';
  static String _idColumnName = 'profileId';
  static String _createTableQuery = "CREATE TABLE IF NOT EXISTS " +
      _tableName +
      " ("
          "profileId INTEGER PRIMARY KEY, "
          "profileName TEXT, "
          "firstName TEXT, "
          "lastName TEXT,"
          "middleName TEXT,"
          "dob INTEGER,"
          "weddingDate INTEGER,"
          "coupleDate INTEGER,"
          "partnerDob INTEGER,"
          "isSelected INTEGER"
          ")";

  ProfileDBRepository._privateConstructor();

  static final ProfileDBRepository instance =
      ProfileDBRepository._privateConstructor();

  Future<Database> get database async {
    return (_database != null) ? _database : await _initiateDatabase();
  }

  Future<Database> _initiateDatabase() async {
    _database = await _openDatabase();
    return _database;
  }

  Future<Database> _openDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute(
          _createTableQuery,
        );
      },
      version: 1,
    );
  }

  Future<void> insertEntity<T>(
    T entity,
    Map<String, dynamic> Function(T row) toMap,
  ) async {
    final Database db = await database;
    await db.insert(
      _tableName,
      toMap(entity),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<T>> getAllEntities<T>(
      T Function(Map<String, dynamic> row) fromMap) async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate(maps.length, (i) {
      return fromMap(maps[i]);
    });
  }

  Future<T> getEntity<T>(
      int entityId, T Function(Map<String, dynamic> row) fromMap) async {
    final Database db = await database;

    List<Map> maps = await db.query(_tableName,
        where: _idColumnName + " = ?", whereArgs: [entityId]);
    if (maps.length > 0) {
      return fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateEntity<T>(T entity, int entityId,
      Map<String, dynamic> Function(T row) toMap) async {
    final db = await database;

    await db.update(
      _tableName,
      toMap(entity),
      where: _idColumnName + " = ?",
      whereArgs: [entityId],
    );
  }

  Future<void> deleteEntity(int entityId) async {
    final db = await database;

    await db.delete(
      _tableName,
      where: _idColumnName + " = ?",
      whereArgs: [entityId],
    );
  }

  Future<void> closeDB() async {
    Database db = await database;
    await db.close();
    _database = null;
  }
}
