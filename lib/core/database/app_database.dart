import 'package:fishing_app/features/boats/data/tables/boat_table.dart';
import 'package:fishing_app/features/owners/data/tables/owner_table.dart';
import 'package:fishing_app/features/workers/data/tables/worker_table.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AppDatabase {
  AppDatabase._();
  static final instance = AppDatabase._();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();

    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'fishing_manager.db');

    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    final batch = db.batch();

    batch.execute(BoatTable.createTable);
    batch.execute(WorkerTable.createTable);
    batch.execute(OwnerTable.createTable);

    await batch.commit();
  }
}
