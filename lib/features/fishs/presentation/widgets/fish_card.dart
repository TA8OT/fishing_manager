import 'package:fishing_app/core/constants/app_gap.dart';
import 'package:fishing_app/features/fishs/data/models/fish_model.dart';
import 'package:flutter/material.dart';

class FishCard extends StatelessWidget {
  final FishModel fish;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  const FishCard({
    super.key,
    required this.fish,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: [Icon(Icons.set_meal), AppGap.w12, Text(fish.name)],
        ),
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
