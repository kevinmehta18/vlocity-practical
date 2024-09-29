import 'package:path/path.dart';
import 'package:practical/data/database/database_tables/todo_table.dart';
import 'package:practical/shared/constants/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  /// Accessing the instance of database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializing database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), DatabaseConstants.todoDB);
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await TodoTable.onCreate(db);
  }
}
