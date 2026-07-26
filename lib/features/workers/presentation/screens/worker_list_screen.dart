import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/workers/presentation/providers/worker_provider.dart';
import 'package:fishing_app/features/workers/presentation/widgets/worker_card.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class WorkerListScreen extends ConsumerWidget {
  const WorkerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(workerProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.workers),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(workerProvider.notifier).loadWorkers();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(workerProvider.notifier).loadWorkers();
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

            if (state.workers.isEmpty) {
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
              itemCount: state.workers.length,
              itemBuilder: (context, index) {
                return WorkerCard(
                  worker: state.workers[index],
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
                                    .read(workerProvider.notifier)
                                    .deleteWorker(state.workers[index].id!);

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
                    context.push('workerform', extra: state.workers[index]);
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
          context.push('workerform');
        },
      ),
    );
  }
}
