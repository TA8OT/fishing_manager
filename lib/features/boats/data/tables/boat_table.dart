class BoatTable {
  static const tableName = 'boats';

  static const idColumn = 'id';
  static const nameColumn = 'name';
  static const registrationNumberColumn = 'registration_number';
  static const captainShareColumn = 'captain_share';

  static const createTable =
      '''
    CREATE TABLE $tableName (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $nameColumn TEXT NOT NULL,
      $registrationNumberColumn TEXT NOT NULL,
      $captainShareColumn REAL NOT NULL
    )
  ''';
}
