import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/trips/data/models/trip_model.dart';
import 'package:fishing_app/features/trips/data/tables/trip_table.dart';

class TripRepository {
  final AppDatabase database;
  TripRepository(this.database);

  Future<void> insertTrip(TripModel trip) async {
    final db = await database.database;

    await db.insert(TripTable.tableName, trip.toMap());
  }

  Future<void> updateTrip(TripModel trip) async {
    final db = await database.database;

    await db.update(
      TripTable.tableName,
      trip.toMap(),
      where: '${TripTable.idColumn} = ?',
      whereArgs: [trip.id],
    );
  }

  Future<void> deleteTrip(int id) async {
    final db = await database.database;

    await db.delete(
      TripTable.tableName,
      where: '${TripTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<TripModel>> getAllTrip() async {
    final db = await database.database;

    final maps = await db.query(TripTable.tableName);

    return maps.map((map) => TripModel.fromMap(map)).toList();
  }

  Future<TripModel?> getTripById(int id) async {
    final db = await database.database;

    final maps = await db.query(
      TripTable.tableName,
      where: '${TripTable.idColumn} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return TripModel.fromMap(maps.first);
  }
}
