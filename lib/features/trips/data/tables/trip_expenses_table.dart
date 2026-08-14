import 'package:fishing_app/features/expenses/data/tables/expense_table.dart';
import 'package:fishing_app/features/trips/data/tables/trip_table.dart';

class TripExpensesTable {
  TripExpensesTable._();

  static const String tableName = 'trip_expenses';

  static const String idColumn = 'id';
  static const String tripIdColumn = 'trip_id';
  static const String expenseIdColumn = 'expense_id';
  static const String amountColumn = 'amount';

  static const String createTable =
      '''
  CREATE TABLE $tableName (
    $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
    $tripIdColumn INTEGER NOT NULL,
    $expenseIdColumn INTEGER NOT NULL,
    $amountColumn REAL NOT NULL,

    FOREIGN KEY ($tripIdColumn)
      REFERENCES ${TripTable.tableName}(${TripTable.idColumn})
      ON DELETE CASCADE,

    FOREIGN KEY ($expenseIdColumn)
      REFERENCES ${ExpenseTable.tableName}(${ExpenseTable.idColumn})
      ON DELETE RESTRICT
  );
''';
}
