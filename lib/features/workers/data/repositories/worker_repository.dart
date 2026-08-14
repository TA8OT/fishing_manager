import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/workers/data/models/worker_model.dart';
import 'package:fishing_app/features/workers/data/tables/worker_table.dart';

class WorkerRepository {
  final AppDatabase database;
  WorkerRepository(this.database);

  Future<void> insertWorker(WorkerModel worker) async {
    final db = await database.database;

    await db.insert(WorkerTable.tableName, worker.toMap());
  }

  Future<void> updateWorker(WorkerModel worker) async {
    final db = await database.database;

    await db.update(
      WorkerTable.tableName,
      worker.toMap(),
      where: '${WorkerTable.idColumn} = ?',
      whereArgs: [worker.id],
    );
  }

  Future<void> deleteWorker(int id) async {
    final db = await database.database;

    await db.delete(
      WorkerTable.tableName,
      where: '${WorkerTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<WorkerModel>> getAllWorkers() async {
    final db = await database.database;

    final maps = await db.query(WorkerTable.tableName);

    return maps.map((map) => WorkerModel.fromMap(map)).toList();
  }

  Future<WorkerModel?> getWorkerById(int id) async {
    final db = await database.database;

    final maps = await db.query(
      WorkerTable.tableName,
      where: '${WorkerTable.idColumn} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return WorkerModel.fromMap(maps.first);
  }
}
