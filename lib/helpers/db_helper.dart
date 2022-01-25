import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Future dataBase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, "user_places.db"),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, loc_lat REAL, loc_lng REAL)",
        );
      },
      version: 1,
    );
  }

  static Future insertData(table, data) async {
    final db = await DBHelper.dataBase();
    db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future fetchData(table) async {
    final db = await DBHelper.dataBase();
    return db.query(table);
  }
}
