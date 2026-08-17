import 'package:fishing_app/features/fishs/data/tables/fish_table.dart';
import 'package:fishing_app/features/trips/data/tables/trip_table.dart';

class TripFishsTable {
  TripFishsTable._();

  static const String tableName = 'trip_fishs';

  static const String idColumn = 'id';
  static const String tripIdColumn = 'trip_id';
  static const String fishIdColumn = 'fish_id';
  static const String weightColumn = 'weight';
  static const String pricePerKgColumn = 'price_per_kg';

  static const String createTable =
      '''
  CREATE TABLE $tableName (
    $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
    $tripIdColumn INTEGER NOT NULL,
    $fishIdColumn INTEGER NOT NULL,
    $weightColumn REAL NOT NULL,
    $pricePerKgColumn REAL NOT NULL,

    FOREIGN KEY ($tripIdColumn)
      REFERENCES ${TripTable.tableName}(${TripTable.idColumn})
      ON DELETE CASCADE,

    FOREIGN KEY ($fishIdColumn)
      REFERENCES ${FishTable.tableName}(${FishTable.idColumn})
      ON DELETE RESTRICT
  );
''';
}
