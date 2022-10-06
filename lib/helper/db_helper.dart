import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sql.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbpath =
        await sql.getDatabasesPath(); //...get path where want to store../../../
    return await sql.openDatabase(path.join(dbpath, 'places.db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY,title TEXT,image TEXT)');
    }, version: 1); //create path join
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database(); //get fun result here (database)
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }
}
