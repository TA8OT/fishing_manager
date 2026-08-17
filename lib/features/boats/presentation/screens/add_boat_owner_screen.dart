import 'package:fishing_app/features/boats/data/models/boat_owner_model.dart';
import 'package:fishing_app/features/boats/presentation/providers/boat_owner_provider.dart';
import 'package:fishing_app/features/owners/presentation/providers/owner_provider.dart';
import 'package:fishing_app/features/owners/presentation/providers/owner_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddBoatOwnerScreen extends ConsumerStatefulWidget {
  final int boatId;
  final double remainingShare;

  const AddBoatOwnerScreen({
    super.key,
    required this.boatId,
    required this.remainingShare,
  });

  @override
  ConsumerState<AddBoatOwnerScreen> createState() => _AddBoatOwnerScreenState();
}

class _AddBoatOwnerScreenState extends ConsumerState<AddBoatOwnerScreen> {
  final _formKey = GlobalKey<FormState>();

  int? selectedOwnerId;

  final shareController = TextEditingController();

  @override
  void dispose() {
    shareController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ownerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Add Boat Owner')),
      body: state.isLoading && state.owners.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : state.errorMessage != null && state.owners.isEmpty
          ? Center(child: Text(state.errorMessage!))
          : _buildForm(state),
    );
  }

  Widget _buildForm(OwnerState state) {
    if (state.owners.isEmpty) {
      return const Center(child: Text('No owners found'));
    }

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<int>(
            initialValue: selectedOwnerId,
            decoration: const InputDecoration(
              labelText: 'Owner',
              border: OutlineInputBorder(),
            ),
            items: state.owners.map((owner) {
              return DropdownMenuItem<int>(
                value: owner.id,
                child: Text(owner.name),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedOwnerId = value;
              });
            },
            validator: (value) {
              if (value == null) {
                return 'Please select an owner';
              }

              return null;
            },
          ),

          const SizedBox(height: 16),

          TextFormField(
            controller: shareController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Ownership share',
              suffixText: '%',
              border: OutlineInputBorder(),
            ),
            validator: _validateShare,
          ),

          const SizedBox(height: 24),

          FilledButton(onPressed: _submit, child: const Text('Add Owner')),
        ],
      ),
    );
  }

  String? _validateShare(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter the ownership share';
    }

    final share = double.tryParse(value);

    if (share == null) {
      return 'Please enter a valid number';
    }

    if (share <= 0) {
      return 'Share must be greater than 0';
    }

    if (share > widget.remainingShare) {
      return 'Maximum available share is ${widget.remainingShare}%';
    }

    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final share = double.parse(shareController.text.trim());

    final boatOwner = BoatOwnerModel(
      boatId: widget.boatId,
      ownerId: selectedOwnerId!,
      share: share,
    );

    final success = await ref
        .read(boatOwnerProvider.notifier)
        .addBoatOwner(boatOwner);

    if (!mounted) return;

    if (!success) {
      final error = ref.read(boatOwnerProvider).errorMessage;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error ?? 'Failed to add owner')));

      return;
    }

    Navigator.of(context).pop();
  }
}
