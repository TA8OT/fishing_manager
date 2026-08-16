import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/owners/data/models/owner_model.dart';
import 'package:fishing_app/features/owners/data/tables/owner_table.dart';

class OwnerRepository {
  final AppDatabase database;
  OwnerRepository(this.database);

  Future<void> insertOwner(OwnerModel owner) async {
    final db = await database.database;

    await db.insert(OwnerTable.tableName, owner.toMap());
  }

  Future<void> updateOwner(OwnerModel owner) async {
    final db = await database.database;

    await db.update(
      OwnerTable.tableName,
      owner.toMap(),
      where: "${OwnerTable.idColumn} = ?",
      whereArgs: [owner.id],
    );
  }

  Future<void> deleteOwner(int id) async {
    final db = await database.database;

    await db.delete(
      OwnerTable.tableName,
      where: '${OwnerTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<OwnerModel>> getAllOwner() async {
    final db = await database.database;

    final maps = await db.query(OwnerTable.tableName);

    return maps.map((map) => OwnerModel.fromMap(map)).toList();
  }

  Future<OwnerModel?> getOwnerById(int id) async {
    final db = await database.database;

    final maps = await db.query(
      OwnerTable.tableName,
      where: '${OwnerTable.tableName} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return OwnerModel.fromMap(maps.first);
  }
}
