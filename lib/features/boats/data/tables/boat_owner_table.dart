import 'package:fishing_app/features/boats/data/tables/boat_table.dart';
import 'package:fishing_app/features/owners/data/tables/owner_table.dart';

class BoatOwnerTable {
  BoatOwnerTable._();

  static const String tableName = 'boat_owners';

  static const String idColumn = 'id';
  static const String boatIdColumn = 'boat_id';
  static const String ownerIdColumn = 'owner_id';

  static const String createTable =
      '''
    CREATE TABLE $tableName (
      $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,

      $boatIdColumn INTEGER NOT NULL,
      $ownerIdColumn INTEGER NOT NULL,

      FOREIGN KEY ($boatIdColumn)
        REFERENCES ${BoatTable.tableName}(${BoatTable.idColumn})
        ON DELETE CASCADE,

      FOREIGN KEY ($ownerIdColumn)
        REFERENCES ${OwnerTable.tableName}(${OwnerTable.idColumn})
        ON DELETE RESTRICT,

      UNIQUE ($boatIdColumn, $ownerIdColumn)
    )
  ''';
}
