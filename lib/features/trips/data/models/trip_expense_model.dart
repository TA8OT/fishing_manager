import 'package:fishing_app/features/trips/data/tables/trip_expenses_table.dart';

class TripExpenseModel {
  final int? id;
  final int tripId;
  final String name;
  final double amount;

  const TripExpenseModel({
    this.id,
    required this.tripId,
    required this.amount,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      TripExpensesTable.idColumn: id,
      TripExpensesTable.tripIdColumn: tripId,
      TripExpensesTable.tableName: name,
      TripExpensesTable.amountColumn: amount,
    };
  }

  factory TripExpenseModel.fromMap(Map<String, dynamic> map) {
    return TripExpenseModel(
      id: map[TripExpensesTable.idColumn],
      tripId: map[TripExpensesTable.tripIdColumn],
      name: map[TripExpensesTable.tableName],
      amount: map[TripExpensesTable.amountColumn],
    );
  }

  TripExpenseModel copyWith(
    int? id,
    int? tripId,
    String? name,
    double? amount,
  ) {
    return TripExpenseModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      amount: amount ?? this.amount,
      name: name ?? this.name,
    );
  }
}
