import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/fishs/data/models/fish_model.dart';
import 'package:fishing_app/features/fishs/data/tables/fish_table.dart';

class FishRepository {
  final AppDatabase database;
  FishRepository(this.database);

  Future<void> insertFish(FishModel fish) async {
    final db = await database.database;

    await db.insert(FishTable.tableName, fish.toMap());
  }

  Future<void> updateFish(FishModel fish) async {
    final db = await database.database;

    await db.update(
      FishTable.tableName,
      fish.toMap(),
      where: '${FishTable.idColumn} = ?',
      whereArgs: [fish.id],
    );
  }

  Future<void> deleteFish(int id) async {
    final db = await database.database;

    await db.delete(
      FishTable.tableName,
      where: '${FishTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<FishModel>> getAllFishs() async {
    final db = await database.database;

    final maps = await db.query(FishTable.tableName);

    return maps.map((map) => FishModel.fromMap(map)).toList();
  }

  Future<FishModel?> getFishById(int id) async {
    final db = await database.database;

    final maps = await db.query(
      FishTable.tableName,
      where: '${FishTable.idColumn} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return FishModel.fromMap(maps.first);
  }
}
