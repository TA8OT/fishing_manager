import 'package:fishing_app/core/database/app_database.dart';
import 'package:fishing_app/features/expenses/data/models/expense_model.dart';
import 'package:fishing_app/features/expenses/data/repositories/expense_repository.dart';
import 'package:fishing_app/features/expenses/presentation/providers/expense_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends Notifier<ExpenseState> {
  late final ExpenseRepository repository;

  @override
  ExpenseState build() {
    repository = ExpenseRepository(AppDatabase.instance);

    Future.microtask(() => loadExpense());

    return ExpenseState(expenses: [], isLoading: false);
  }

  Future<void> loadExpense() async {
    state = state.copyWith(isLoading: true);

    try {
      final result = await repository.getAllExpense();

      state = state.copyWith(
        expenses: result,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  Future<void> addExpense(ExpenseModel expense) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.insertExpense(expense);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadExpense();
  }

  Future<void> updateExpense(ExpenseModel expense) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.updateExpense(expense);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadExpense();
  }

  Future<void> deleteExpense(int id) async {
    state = state.copyWith(isLoading: true);

    try {
      await repository.deleteExpense(id);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }

    await loadExpense();
  }
}
