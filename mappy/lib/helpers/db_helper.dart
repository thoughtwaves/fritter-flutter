import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<Database> database() async {
     final dbPath = await sql.getDatabasesPath();
    return await sql.openDatabase(path.join(dbPath, 'places.db'),
        onCreate: (db, version) {
          return db.execute('Create table places(id text primary key, title text, image text, latitude real, longitude real, address text)');
        }, version: 1);
  }

  static Future<void> insert(String table, Map<String, dynamic> data) async {
      final sqlDB = await DBHelper.database();
      sqlDB.insert(table, data);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
          final sqlDB = await DBHelper.database();
          return sqlDB.query(table);

  }
}
