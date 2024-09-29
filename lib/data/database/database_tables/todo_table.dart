import 'package:practical/data/database/database_helper.dart';
import 'package:practical/shared/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class TodoTable {
  /// Query to create a table into database
  static Future<void> onCreate(Database db) async {
    await db.execute(DatabaseConstants.repositoriesQuery);
  }

  /// Inserting data into database
  static Future<void> insertData(List<Map<String, dynamic>> repos) async {
    final db = await DatabaseHelper().database;
    Batch batch = db.batch();
    for (var repo in repos) {
      batch.insert(DatabaseConstants.todos, repo,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit(noResult: true);
  }

  /// Retrieving data from database
  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await DatabaseHelper().database;
    return await db.query(DatabaseConstants.todos);
  }

  static Future<int> delete(int id) async {
    final db = await DatabaseHelper().database;
    return await db
        .delete(DatabaseConstants.todos, where: 'id = ?', whereArgs: [id]);
  }

  static Future<int> update(List<Map<String, dynamic>> values,int id) async {
    final db = await DatabaseHelper().database;
    return await db.update(DatabaseConstants.todos, values.first, where: 'id = ?', whereArgs: [id]);
  }
}
