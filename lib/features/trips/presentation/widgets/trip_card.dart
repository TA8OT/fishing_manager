import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/features/trips/data/models/trip_model.dart';
import 'package:fishing_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final TripModel trip;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const TripCard({
    super.key,
    required this.trip,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Card(
      child: ListTile(
        title: Row(
          children: [
            Icon(Icons.person),
            AppGap.w12,
            Text(trip.boatId.toString()),
          ],
        ),
        subtitle: Text("${l10n!.phone}: ${trip.id ?? l10n.notAvailable}"),
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
