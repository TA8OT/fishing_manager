class WorkerTable {
  WorkerTable._();

  static const String tableName = 'workers';

  static const String idColumn = 'id';
  static const String nameColumn = 'name';
  static const String phoneColumn = 'phone';

  static const String createTable =
      '''
    CREATE TABLE $tableName (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $nameColumn TEXT NOT NULL,
      $phoneColumn TEXT
    );
  ''';
}
