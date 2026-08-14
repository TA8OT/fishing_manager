import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/expenses/data/models/expense_model.dart';
import 'package:fishing_app/features/expenses/data/tables/expense_table.dart';

class ExpenseRepository {
  final AppDatabase database;
  ExpenseRepository(this.database);

  Future<void> insertExpense(ExpenseModel expense) async {
    final db = await database.database;

    await db.insert(ExpenseTable.tableName, expense.toMap());
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    final db = await database.database;

    await db.update(
      ExpenseTable.tableName,
      expense.toMap(),
      where: '${ExpenseTable.idColumn} = ?',
      whereArgs: [expense.id],
    );
  }

  Future<void> deleteExpense(int id) async {
    final db = await database.database;

    await db.delete(
      ExpenseTable.tableName,
      where: '${ExpenseTable.idColumn} = ?',
      whereArgs: [id],
    );
  }

  Future<List<ExpenseModel>> getAllExpense() async {
    final db = await database.database;

    final maps = await db.query(ExpenseTable.tableName);

    return maps.map((map) => ExpenseModel.fromMap(map)).toList();
  }

  Future<ExpenseModel?> getExpenseById(int id) async {
    final db = await database.database;

    final maps = await db.query(
      ExpenseTable.tableName,
      where: '${ExpenseTable.idColumn} = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (maps.isEmpty) {
      return null;
    }

    return ExpenseModel.fromMap(maps.first);
  }
}
