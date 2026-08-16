import 'package:fishing_app/features/boats/presentation/providers/boat_owner_provider.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_owner_state.dart';
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
      return _buildError(state.errorMessage!);
    }

    if (state.boatOwners.isEmpty) {
      return _buildEmpty();
    }

    return _buildContent(state);
  }

  Widget _buildContent(BoatOwnerState state) {
    return Column(
      children: [
        _buildTotalShare(state),
        Expanded(child: _buildOwnersList(state)),
      ],
    );
  }

  Widget _buildTotalShare(BoatOwnerState state) {
    final remaining = (100 - state.totalShare).clamp(0, 100);

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _ShareInfo(
                label: 'Total ownership',
                value: '${state.totalShare}%',
              ),
            ),
            Expanded(
              child: _ShareInfo(label: 'Remaining', value: '$remaining%'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOwnersList(BoatOwnerState state) {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: state.boatOwners.length,
      itemBuilder: (context, index) {
        final boatOwner = state.boatOwners[index];

        return _buildOwnerCard(boatOwner);
      },
    );
  }

  Widget _buildOwnerCard(dynamic boatOwner) {
    return Card(
      child: ListTile(
        leading: const CircleAvatar(child: Icon(Icons.person)),
        title: Text(boatOwner.owner.name),
        subtitle: Text(boatOwner.owner.phone ?? 'No phone'),
        trailing: Text(
          '${boatOwner.share}%',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return const Center(child: Text('No owners found'));
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(message, textAlign: TextAlign.center),
      ),
    );
  }

  void _addOwner() {
    // سنبنيها في الخطوة القادمة
  }
}

class _ShareInfo extends StatelessWidget {
  final String label;
  final String value;

  const _ShareInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
