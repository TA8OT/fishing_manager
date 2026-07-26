class OwnerTable {
  OwnerTable._();

  static const tableName = "owners";

  static const idColumn = 'id';
  static const nameColumn = "name";
  static const phoneColumn = "phone";

  static const createTable =
      '''
    CREATE TABLE $tableName (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $nameColumn TEXT NOT NULL,
      $phoneColumn TEXT
    );
''';
}
