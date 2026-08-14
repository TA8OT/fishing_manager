import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/features/owners/data/models/owner_model.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class OwnerCard extends StatelessWidget {
  final OwnerModel owner;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const OwnerCard({
    super.key,
    required this.owner,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: ListTile(
        title: Row(
          children: [Icon(Icons.person), AppGap.h12, Text(owner.name)],
        ),
        subtitle: Text('${l10n!.phone}: ${owner.phone ?? l10n.notAvailable}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.primary,
            ),
            AppGap.w8,

            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
