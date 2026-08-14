class ExpenseTable {
  ExpenseTable._();

  static const String tableName = 'expenses';

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
