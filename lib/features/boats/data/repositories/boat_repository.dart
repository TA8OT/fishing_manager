import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/boats/data/models/boat_model.dart';
import 'package:fishing_app/features/boats/data/tables/boat_table.dart';

class BoatRepository {
  final AppDatabase database;
  BoatRepository(this.database);

  Future<void> insertBoat(BoatModel boat) async {
    final db = await database.database;

    await db.insert(BoatTable.tableName, boat.toMap());
  }

  Future<void> updateBoat(BoatModel boat) async {
    final db = await database.database;

    await db.update(
      BoatTable.tableName,
      boat.toMap(),
      where: '${BoatTable.idColumn} = ?',
      whereArgs: [boat.id],
    );
  }

  Future<void> deleteBoat(int id) async {
    final db = await database.database;

    await db.delete(
      BoatTable.tableName,
      where: '${BoatTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<BoatModel>> getAllBoats() async {
    final db = await database.database;

    final maps = await db.query(BoatTable.tableName);

    return maps.map((map) => BoatModel.fromMap(map)).toList();
  }

  Future<BoatModel?> getBoatById(int id) async {
    final db = await database.database;

    final maps = await db.query(
      BoatTable.tableName,
      where: '${BoatTable.idColumn} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return BoatModel.fromMap(maps.first);
  }

  // Future<List<BoatModel>> searchBoats(String keyword) {
  // }
}
