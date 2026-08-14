import 'package:fishing_app/features/workers/data/tables/worker_table.dart';

class BoatTable {
  static const tableName = 'boats';

  static const idColumn = 'id';
  static const nameColumn = 'name';
  static const registrationNumberColumn = 'registration_number';
  static const captainShareColumn = 'captain_share';
  static const captainWorkerId = 'captain_worker_id';

  static const createTable =
      '''
    CREATE TABLE $tableName (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
      $nameColumn TEXT NOT NULL,
      $registrationNumberColumn TEXT,
      $captainShareColumn REAL NOT NULL,

      $captainWorkerId INTEGER,

      FOREIGN KEY($captainWorkerId) REFERENCES ${WorkerTable.tableName}(${WorkerTable.idColumn})
    )
  ''';
}
