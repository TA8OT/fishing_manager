import 'package:flutter/material.dart';

class BoatOwnerSummary extends StatelessWidget {
  final double totalShare;

  const BoatOwnerSummary({super.key, required this.totalShare});

  @override
  Widget build(BuildContext context) {
    final remaining = 100 - totalShare;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Total ownership'),
                  const SizedBox(height: 4),
                  Text(
                    '$totalShare%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Remaining'),
                  const SizedBox(height: 4),
                  Text(
                    '$remaining%',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
