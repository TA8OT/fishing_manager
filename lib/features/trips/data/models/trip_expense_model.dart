import 'package:fishing_app/features/trips/data/tables/trip_expenses_table.dart';

class TripExpenseModel {
  final int? id;
  final int tripId;
  final int expenseId;
  final double amount;

  const TripExpenseModel({
    this.id,
    required this.tripId,
    required this.expenseId,
    required this.amount,
  });

  Map<String, dynamic> toMap() {
    return {
      TripExpensesTable.idColumn: id,
      TripExpensesTable.tripIdColumn: tripId,
      TripExpensesTable.expenseIdColumn: expenseId,
      TripExpensesTable.amountColumn: amount,
    };
  }

  factory TripExpenseModel.fromMap(Map<String, dynamic> map) {
    return TripExpenseModel(
      id: map[TripExpensesTable.idColumn] as int?,
      tripId: map[TripExpensesTable.tripIdColumn] as int,
      expenseId: map[TripExpensesTable.expenseIdColumn] as int,
      amount: (map[TripExpensesTable.amountColumn] as num).toDouble(),
    );
  }

  TripExpenseModel copyWith({
    int? id,
    int? tripId,
    int? expenseId,
    double? amount,
  }) {
    return TripExpenseModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      expenseId: expenseId ?? this.expenseId,
      amount: amount ?? this.amount,
    );
  }
}
