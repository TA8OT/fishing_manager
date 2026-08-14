import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/owners/presentation/providers/owner_provider.dart';
import 'package:fishing_app/features/owners/presentation/widgets/owner_card.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class OwnerListScreen extends ConsumerWidget {
  const OwnerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ownerProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.owners),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.read(ownerProvider.notifier).loadOwners();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(ownerProvider.notifier).loadOwners();
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

            if (state.owners.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: 500),
                  Center(child: Text(l10n.noDataFound)),
                ],
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.sm),
              itemCount: state.owners.length,
              itemBuilder: (context, index) {
                return OwnerCard(
                  owner: state.owners[index],
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
                                    .read(ownerProvider.notifier)
                                    .deleteOwner(state.owners[index].id!);

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
                    context.push('ownerform', extra: state.owners[index]);
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
          context.push('ownerform');
        },
      ),
    );
  }
}
