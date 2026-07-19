import 'package:fishing_app/core/constants/app_spacing.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_provider.dart';
import 'package:fishing_app/features/boats/presentation/widgets/boat_card.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BoatListScreen extends ConsumerWidget {
  const BoatListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(boatProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.boats),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(boatProvider.notifier).loadBoats();
            },
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(boatProvider.notifier).loadBoats();
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

            if (state.boats.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 500,
                    child: Center(child: Text(l10n.noBoatFound)),
                  ),
                ],
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(AppSpacing.sm),
              itemCount: state.boats.length,
              itemBuilder: (context, index) {
                return BoatCard(
                  boat: state.boats[index],

                  onEdit: () {
                    context.push("boatform", extra: state.boats[index]);
                  },

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
                                    .read(boatProvider.notifier)
                                    .deleteBoat(state.boats[index].id!);

                                Navigator.pop(dialogContext);
                              },

                              child: Text(l10n.delete),
                            ),
                          ],
                        );
                      },
                    );
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
          context.push('boatform');
        },
      ),
    );
  }
}
