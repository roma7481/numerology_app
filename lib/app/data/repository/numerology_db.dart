import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NumerologyDBRepository {
  static final _dbName = 'numerology_3.db';
  static final _assets = 'assets';
  static final _subPackage = 'database';

  //defining DB as singleton
  NumerologyDBRepository._privateConstructor();

  static final NumerologyDBRepository instance =
      NumerologyDBRepository._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    return (_database != null) ? _database : await _initiateDatabase();
  }

  _initiateDatabase() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      debugPrint("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data =
          await rootBundle.load(join(_assets + '/' + _subPackage, _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      debugPrint("Opening existing database");
    }

    // open the database
    return await openDatabase(path, readOnly: true);
  }

  Future<T> getEntity<T>(String query, Function fromMap) async {
    Database db =
        await instance.database; // this command calls get database async method

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    return fromMap(maps.first);
  }

  Future closeDB() async {
    Database db = await instance.database;
    debugPrint("Closing database");
    await db.close();
  }
}
