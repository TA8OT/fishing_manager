import 'package:fishing_app/core/constants/app_sizes.dart';
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
      appBar: AppBar(title: Text(l10n!.boats)),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : state.errorMessage != null
          ? Center(child: Text(state.errorMessage.toString()))
          : state.boats.isEmpty
          ? Center(child: Text('no boats data is found'))
          : ListView.builder(
              padding: EdgeInsets.all(AppSpacing.sm),
              itemCount: state.boats.length,
              itemBuilder: (context, index) {
                return BoatCard(
                  boat: state.boats[index],
                  onEdit: () {},
                  onDelete: () {},
                );
              },
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
