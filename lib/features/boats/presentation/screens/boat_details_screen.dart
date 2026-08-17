import 'package:fishing_app/features/boats/data/models/boat_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BoatDetailsScreen extends StatelessWidget {
  final BoatModel boat;

  const BoatDetailsScreen({super.key, required this.boat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(boat.name)),
      body: ListTile(
        title: const Text('Owners'),
        onTap: () {
          context.push('/boat-owners', extra: boat.id);
        },
      ),
    );
  }
}
