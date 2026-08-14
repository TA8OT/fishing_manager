import 'package:fishing_app/features/expenses/data/tables/expense_table.dart';

class ExpenseModel {
  final int? id;
  final String name;

  const ExpenseModel({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {ExpenseTable.idColumn: id, ExpenseTable.nameColumn: name};
  }

  factory ExpenseModel.fromMap(Map<String, dynamic> map) {
    return ExpenseModel(
      id: map[ExpenseTable.idColumn],
      name: map[ExpenseTable.nameColumn],
    );
  }

  ExpenseModel copyWith({int? id, String? name}) {
    return ExpenseModel(id: id ?? this.id, name: name ?? this.name);
  }
}
