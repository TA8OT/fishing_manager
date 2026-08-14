import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/trips/data/models/trip_worker_model.dart';
import 'package:fishing_app/features/trips/data/tables/trip_worker_table.dart';

class TripWorkerRepository {
  final AppDatabase database;

  TripWorkerRepository(this.database);

  Future<void> insertTripWorker(TripWorkerModel tripWorker) async {
    final db = await database.database;

    await db.insert(TripWorkerTable.tableName, tripWorker.toMap());
  }

  Future<void> deleteTripWorker(int id) async {
    final db = await database.database;

    await db.delete(
      TripWorkerTable.tableName,
      where: '${TripWorkerTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<TripWorkerModel>> getWorkersByTrip(int tripId) async {
    final db = await database.database;

    final maps = await db.query(
      TripWorkerTable.tableName,
      where: '${TripWorkerTable.tripIdColumn} = ?',
      whereArgs: [tripId],
    );

    return maps.map((map) => TripWorkerModel.fromMap(map)).toList();
  }
}
