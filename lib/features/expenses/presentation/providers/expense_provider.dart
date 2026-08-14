import 'package:fishing_app/features/expenses/presentation/providers/expense_notifier.dart';
import 'package:fishing_app/features/expenses/presentation/providers/expense_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final expenseProvider = NotifierProvider<ExpenseNotifier, ExpenseState>(
  ExpenseNotifier.new,
);
