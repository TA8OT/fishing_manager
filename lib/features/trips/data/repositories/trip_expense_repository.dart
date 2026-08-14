import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/trips/data/models/trip_expense_model.dart';
import 'package:fishing_app/features/trips/data/tables/trip_expenses_table.dart';

class TripExpenseRepository {
  final AppDatabase database;

  TripExpenseRepository(this.database);

  Future<void> insertTripExpense(TripExpenseModel tripExpense) async {
    final db = await database.database;

    await db.insert(TripExpensesTable.tableName, tripExpense.toMap());
  }

  Future<void> deleteTripExpense(int id) async {
    final db = await database.database;

    await db.delete(
      TripExpensesTable.tableName,
      where: '${TripExpensesTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<TripExpenseModel>> getExpensesByTrip(int tripId) async {
    final db = await database.database;

    final maps = await db.query(
      TripExpensesTable.tableName,
      where: '${TripExpensesTable.tripIdColumn} = ?',
      whereArgs: [tripId],
    );

    return maps.map((map) => TripExpenseModel.fromMap(map)).toList();
  }
}
