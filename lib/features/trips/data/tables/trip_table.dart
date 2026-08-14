import 'package:fishing_app/features/boats/data/tables/boat_table.dart';
import 'package:fishing_app/features/workers/data/tables/worker_table.dart';

class TripTable {
  TripTable._();

  static const String tableName = 'trips';

  static const String idColumn = 'id';
  static const String boatIdColumn = 'boat_id';
  static const String captainWorkerIdColumn = 'captain_worker_id';
  static const String startDateColumn = 'start_date';
  static const String endDateColumn = 'end_date';
  static const String notesColumn = "notes";

  static const String createTable =
      '''
  CREATE TABLE $tableName (
    $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
    $boatIdColumn INTEGER NOT NULL,
    $captainWorkerIdColumn INTEGER NOT NULL,
    $startDateColumn TEXT NOT NULL,
    $endDateColumn TEXT NOT NULL,
    $notesColumn TEXT,

    FOREIGN KEY ($boatIdColumn) REFERENCES ${BoatTable.tableName}(${BoatTable.idColumn}),
    FOREIGN KEY ($captainWorkerIdColumn) REFERENCES ${WorkerTable.tableName}(${WorkerTable.idColumn})
  );
''';
}
