import 'dart:io';
import 'package:dashui/models/personal.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common/sqlite_api.dart';

class DbHelper {
  static const String DB_NAME = 'managedb.dll';
  static Future<void> initDbLibrary() async {
    if (Platform.isWindows || Platform.isLinux) {
      sqfliteFfiInit();
    }
  }

  static Future<Database> init() async {
    var databaseFactory = databaseFactoryFfi;
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    String path = join(appDocPath, DB_NAME);
    var db = await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(onCreate: _onCreate, version: 1),
    );
    return db;
  }

  static _onCreate(Database db, int version) async {
    try {
      await db.execute('''
  CREATE TABLE Personals (
    id INTEGER PRIMARY KEY,
    nom TEXT,
    age INTEGER
  )
  ''');
      print("db initialized");
    } catch (err) {
      print("error from transaction");
    }
  }

  static Future<int> insertPersonal(Personals data) async {
    var db = await init();
    var lastInsertId = await db.insert('Personals', data.toMap());

    if (lastInsertId != null) {
      return lastInsertId;
    }
    return null;
  }

  static Future<List<Personals>> listPersonals() async {
    var db = await init();
    List<Personals> personals = [];
    var result = await db.query('Personals');

    if (result.isNotEmpty) {
      for (var res in result) {
        var person = Personals.fromMap(res);
        personals.add(person);
      }
      print("with data :${personals.length}");
      return personals;
    } else {
      print("empty data :${personals.length}");
      return [];
    }
  }

  static Future<void> delete(int _id) async {
    try {
      var db = await init();
      var id = await db.rawDelete('DELETE FROM Personals WHERE id = ?', [_id]);
      print(id);
    } catch (err) {
      print(err);
    }
  }
}
