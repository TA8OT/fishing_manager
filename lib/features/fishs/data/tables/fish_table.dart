class FishTable {
  FishTable._();

  static const String tableName = 'fishs';

  static const String idColumn = 'id';
  static const String nameColumn = 'name';

  static const String createTable =
      '''
    CREATE TABLE $tableName (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $nameColumn TEXT NOT NULL
    );
  ''';
}
