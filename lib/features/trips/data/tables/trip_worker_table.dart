import 'package:fishing_app/features/trips/data/tables/trip_table.dart';
import 'package:fishing_app/features/workers/data/tables/worker_table.dart';

class TripWorkerTable {
  TripWorkerTable._();

  static const String tableName = "trip_workers";

  static const String idColumn = 'id';
  static const String tripIdColumn = 'trip_id';
  static const String workerIdColumn = 'worker_id';

  static const String createTable =
      '''
  CREATE TABLE $tableName (
    $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
    $tripIdColumn INTEGER NOT NULL,
    $workerIdColumn INTEGER NOT NULL,

    FOREIGN KEY ($tripIdColumn)
      REFERENCES ${TripTable.tableName}(${TripTable.idColumn})
      ON DELETE CASCADE,

    FOREIGN KEY ($workerIdColumn)
      REFERENCES ${WorkerTable.tableName}(${WorkerTable.idColumn})
      ON DELETE RESTRICT,
    UNIQUE(trip_id, worker_id)
  );
''';
}
