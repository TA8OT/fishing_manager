import 'package:fishing_app/features/boats/presentation/providers/boat_owner_provider.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_owner_state.dart';
import 'package:fishing_app/features/boats/presentation/widgets/boat_owner_card.dart';
import 'package:fishing_app/features/boats/presentation/widgets/boat_owner_summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BoatOwnersScreen extends ConsumerStatefulWidget {
  final int boatId;

  const BoatOwnersScreen({super.key, required this.boatId});

  @override
  ConsumerState<BoatOwnersScreen> createState() => _BoatOwnersScreenState();
}

class _BoatOwnersScreenState extends ConsumerState<BoatOwnersScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      ref.read(boatOwnerProvider.notifier).loadBoatOwners(widget.boatId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(boatOwnerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Boat Owners')),

      body: _buildBody(state),

      floatingActionButton: FloatingActionButton(
        onPressed: _addOwner,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildBody(BoatOwnerState state) {
    if (state.isLoading && state.boatOwners.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null && state.boatOwners.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(state.errorMessage!, textAlign: TextAlign.center),
        ),
      );
    }

    if (state.boatOwners.isEmpty) {
      return const Center(child: Text('No owners found'));
    }

    return _buildContent(state);
  }

  Widget _buildContent(BoatOwnerState state) {
    return Column(
      children: [
        BoatOwnerSummary(totalShare: state.totalShare),

        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.boatOwners.length,
            itemBuilder: (context, index) {
              final boatOwner = state.boatOwners[index];

              return BoatOwnerCard(boatOwner: boatOwner);
            },
          ),
        ),
      ],
    );
  }

  void _addOwner() {
    // سنبني إضافة المالك لاحقًا
  }
}
