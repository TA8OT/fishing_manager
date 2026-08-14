import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/trips/data/models/trip_fish_model.dart';
import 'package:fishing_app/features/trips/data/tables/trip_fishs_table.dart';

class TripFishRepository {
  final AppDatabase database;

  TripFishRepository(this.database);

  Future<void> insertTripFish(TripFishModel tripFish) async {
    final db = await database.database;

    await db.insert(TripFishsTable.tableName, tripFish.toMap());
  }

  Future<void> deleteTripFish(int id) async {
    final db = await database.database;

    await db.delete(
      TripFishsTable.tableName,
      where: '${TripFishsTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<TripFishModel>> getFishsByTrip(int tripId) async {
    final db = await database.database;

    final maps = await db.query(
      TripFishsTable.tableName,
      where: '${TripFishsTable.tripIdColumn} = ?',
      whereArgs: [tripId],
    );

    return maps.map((map) => TripFishModel.fromMap(map)).toList();
  }
}
