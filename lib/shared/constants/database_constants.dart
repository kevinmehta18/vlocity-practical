class DatabaseConstants {
  /// Database Name
  static String todoDB = "todolist.db";

  /// Tables Names
  static String todos = "todos";

  /// Tables queries
  static String repositoriesQuery = '''
      CREATE TABLE todos (
        id INTEGER PRIMARY KEY,
        todoName TEXT
      )
    ''';
}
