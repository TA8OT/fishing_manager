import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/boats/data/dtos/boat_owner_dto.dart';
import 'package:fishing_app/features/boats/data/models/boat_owner_model.dart';
import 'package:fishing_app/features/boats/data/tables/boat_owner_table.dart';
import 'package:fishing_app/features/owners/data/models/owner_model.dart';
import 'package:fishing_app/features/owners/data/tables/owner_table.dart';

class BoatOwnerRepository {
  final AppDatabase database;

  BoatOwnerRepository(this.database);

  Future<int> insertBoatOwner(BoatOwnerModel boatOwner) async {
    final totalShare = await getTotalShareByBoatId(boatOwner.boatId);

    if (totalShare + boatOwner.share > 100) {
      throw StateError('The total owner shares cannot exceed 100%.');
    }

    final db = await database.database;

    return await db.insert(BoatOwnerTable.tableName, boatOwner.toMap());
  }

  Future<List<BoatOwnerModel>> getOwnersByBoatId(int boatId) async {
    final db = await database.database;

    final result = await db.query(
      BoatOwnerTable.tableName,
      where: '${BoatOwnerTable.boatIdColumn} = ?',
      whereArgs: [boatId],
    );

    return result.map((map) => BoatOwnerModel.fromMap(map)).toList();
  }

  Future<List<BoatOwnerModel>> getBoatsByOwnerId(int ownerId) async {
    final db = await database.database;

    final result = await db.query(
      BoatOwnerTable.tableName,
      where: '${BoatOwnerTable.ownerIdColumn} = ?',
      whereArgs: [ownerId],
    );

    return result.map((map) => BoatOwnerModel.fromMap(map)).toList();
  }

  Future<List<BoatOwnerDto>> getBoatOwnersWithDetails(int boatId) async {
    final db = await database.database;

    final result = await db.rawQuery(
      '''
      SELECT
        bo.${BoatOwnerTable.idColumn} AS boat_owner_id,
        bo.${BoatOwnerTable.boatIdColumn} AS boat_id,
        bo.${BoatOwnerTable.ownerIdColumn} AS relation_owner_id,
        bo.${BoatOwnerTable.shareColumn} AS share,

        o.${OwnerTable.idColumn} AS owner_id,
        o.${OwnerTable.nameColumn} AS owner_name,
        o.${OwnerTable.phoneColumn} AS owner_phone

      FROM ${BoatOwnerTable.tableName} bo

      INNER JOIN ${OwnerTable.tableName} o
        ON bo.${BoatOwnerTable.ownerIdColumn}
        = o.${OwnerTable.idColumn}

      WHERE bo.${BoatOwnerTable.boatIdColumn} = ?
      ''',
      [boatId],
    );

    return result.map((map) {
      final owner = OwnerModel(
        id: map['owner_id'] as int,
        name: map['owner_name'] as String,
        phone: map['owner_phone'] as String?,
      );

      return BoatOwnerDto(
        boatOwnerId: map['boat_owner_id'] as int,
        boatId: map['boat_id'] as int,
        owner: owner,
        share: (map['share'] as num).toDouble(),
      );
    }).toList();
  }

  Future<int> updateBoatOwner(BoatOwnerModel boatOwner) async {
    final currentOwner = await _getBoatOwnerById(boatOwner.id!);

    final totalShare = await getTotalShareByBoatId(boatOwner.boatId);

    final newTotalShare = totalShare - currentOwner.share + boatOwner.share;

    if (newTotalShare > 100) {
      throw StateError('The total owner shares cannot exceed 100%.');
    }

    final db = await database.database;

    return await db.update(
      BoatOwnerTable.tableName,
      boatOwner.toMap(),
      where: '${BoatOwnerTable.idColumn} = ?',
      whereArgs: [boatOwner.id],
    );
  }

  Future<int> deleteBoatOwner(int id) async {
    final db = await database.database;

    return await db.delete(
      BoatOwnerTable.tableName,
      where: '${BoatOwnerTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteByBoatId(int boatId) async {
    final db = await database.database;

    return await db.delete(
      BoatOwnerTable.tableName,
      where: '${BoatOwnerTable.boatIdColumn} = ?',
      whereArgs: [boatId],
    );
  }

  Future<int> deleteByOwnerId(int ownerId) async {
    final db = await database.database;

    return await db.delete(
      BoatOwnerTable.tableName,
      where: '${BoatOwnerTable.ownerIdColumn} = ?',
      whereArgs: [ownerId],
    );
  }

  Future<double> getTotalShareByBoatId(int boatId) async {
    final db = await database.database;

    final result = await db.rawQuery(
      '''
      SELECT SUM(${BoatOwnerTable.shareColumn}) AS total_share
      FROM ${BoatOwnerTable.tableName}
      WHERE ${BoatOwnerTable.boatIdColumn} = ?
      ''',
      [boatId],
    );

    final totalShare = result.first['total_share'];

    if (totalShare == null) {
      return 0;
    }

    return (totalShare as num).toDouble();
  }

  Future<bool> hasCompleteOwnerShares(int boatId) async {
    final totalShare = await getTotalShareByBoatId(boatId);

    return (totalShare - 100).abs() < 0.0001;
  }

  // Future<bool> canAddShare(int boatId, double share) async {
  //   final totalShare = await getTotalShareByBoatId(boatId);

  //   return totalShare + share <= 100;
  // }

  Future<BoatOwnerModel> _getBoatOwnerById(int id) async {
    final db = await database.database;

    final result = await db.query(
      BoatOwnerTable.tableName,
      where: '${BoatOwnerTable.idColumn} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) {
      throw StateError('Boat owner not found.');
    }

    return BoatOwnerModel.fromMap(result.first);
  }
}
