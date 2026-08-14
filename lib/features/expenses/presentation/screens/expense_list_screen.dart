import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/expenses/presentation/providers/expense_provider.dart';
import 'package:fishing_app/features/expenses/presentation/widgets/expense_card.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExpenseListScreen extends ConsumerWidget {
  const ExpenseListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expenseProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.expense),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(expenseProvider.notifier).loadExpense();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(expenseProvider.notifier).loadExpense();
        },
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 500,
                    child: Center(child: Text(state.errorMessage!)),
                  ),
                ],
              );
            }

            if (state.expenses.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 500,
                    child: Center(child: Text(l10n.noDataFound)),
                  ),
                ],
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.sm),
              itemCount: state.expenses.length,
              itemBuilder: (context, index) {
                return ExpenseCard(
                  expense: state.expenses[index],
                  onDelete: () {
                    showDialog(
                      context: context,

                      builder: (dialogContext) {
                        return AlertDialog(
                          title: Text(l10n.deleteConfirmation),

                          content: Text(l10n.areSuretoDelete),

                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(dialogContext),

                              child: Text(l10n.cancel),
                            ),

                            TextButton(
                              onPressed: () {
                                ref
                                    .read(expenseProvider.notifier)
                                    .deleteExpense(state.expenses[index].id!);

                                Navigator.pop(dialogContext);
                              },

                              child: Text(l10n.delete),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onEdit: () {
                    context.push('expenseform', extra: state.expenses[index]);
                  },
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.push('expenseform');
        },
      ),
    );
  }
}
