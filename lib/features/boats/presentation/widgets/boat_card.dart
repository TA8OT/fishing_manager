import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/features/boats/data/models/boat_model.dart';
import 'package:flutter/material.dart';
import 'package:fishing_app/l10n/app_localizations.dart';

class BoatCard extends StatelessWidget {
  final BoatModel boat;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const BoatCard({
    super.key,
    required this.boat,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: ListTile(
        title: Row(
          children: [Icon(Icons.directions_boat), AppGap.w12, Text(boat.name)],
        ),
        subtitle: Text(
          '${l10n!.registrationNumber}:  ${boat.registrationNumber} \n${l10n.captainShare}:  ${boat.captainShare}',
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: Icon(Icons.edit),
              color: Theme.of(context).colorScheme.onPrimary,
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
