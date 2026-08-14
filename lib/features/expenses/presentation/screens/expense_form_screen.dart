import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/expenses/data/models/expense_model.dart';
import 'package:fishing_app/features/expenses/presentation/providers/expense_provider.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ExpenseFormScreen extends ConsumerStatefulWidget {
  final ExpenseModel? expense;
  const ExpenseFormScreen({super.key, this.expense});

  @override
  ConsumerState<ExpenseFormScreen> createState() => _ExpenseFormScreenState();
}

class _ExpenseFormScreenState extends ConsumerState<ExpenseFormScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController(text: widget.expense?.name ?? "");
  }

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.expense == null ? l10n!.addExpense : l10n!.editExpense,
        ),
      ),
      body: Form(
        key: _formKey,

        child: Padding(
          padding: EdgeInsetsGeometry.all(AppSpacing.md),
          child: Column(
            // Name
            children: [
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return l10n.enterExpenseName;
                  }
                  return null;
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text(l10n.name),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              AppGap.h16,
              ElevatedButton(
                onPressed: ref.read(expenseProvider).isLoading
                    ? null
                    : () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        final messanger = ScaffoldMessenger.of(context);
                        final focusScope = FocusScope.of(context);
                        final router = GoRouter.of(context);

                        if (widget.expense == null) {
                          await ref
                              .read(expenseProvider.notifier)
                              .addExpense(
                                ExpenseModel(name: nameController.text.trim()),
                              );
                        } else {
                          await ref
                              .read(expenseProvider.notifier)
                              .updateExpense(
                                ExpenseModel(
                                  id: widget.expense!.id,
                                  name: nameController.text.trim(),
                                ),
                              );
                        }

                        if (ref.read(expenseProvider).errorMessage != null) {
                          messanger.showSnackBar(
                            SnackBar(
                              content: Text(
                                "${l10n.error}: ${l10n.failedToSave} \n ${ref.read(expenseProvider).errorMessage}",
                              ),
                            ),
                          );
                          return;
                        } else {
                          messanger.showSnackBar(
                            SnackBar(content: Text(l10n.succeeded)),
                          );

                          focusScope.unfocus();
                          router.pop();
                        }
                      },
                child: Text(widget.expense == null ? l10n.save : l10n.update),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
