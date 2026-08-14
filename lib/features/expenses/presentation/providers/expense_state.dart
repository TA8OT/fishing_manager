import 'package:fishing_app/features/expenses/data/models/expense_model.dart';

class ExpenseState {
  final List<ExpenseModel> expenses;
  final bool isLoading;
  final String? errorMessage;

  ExpenseState({
    required this.expenses,
    required this.isLoading,
    this.errorMessage,
  });

  ExpenseState copyWith({
    final List<ExpenseModel>? expenses,
    final bool? isLoading,
    final String? errorMessage,
  }) {
    return ExpenseState(
      expenses: expenses ?? this.expenses,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
