import 'package:fishing_app/features/boats/data/dtos/boat_owner_dto.dart';
import 'package:flutter/material.dart';

class BoatOwnerCard extends StatelessWidget {
  final BoatOwnerDto boatOwner;

  const BoatOwnerCard({super.key, required this.boatOwner});

  @override
  Widget build(BuildContext context) {
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
}
