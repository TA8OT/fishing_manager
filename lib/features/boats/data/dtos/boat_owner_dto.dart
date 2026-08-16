import 'package:fishing_app/features/owners/data/models/owner_model.dart';

class BoatOwnerDto {
  final int boatOwnerId;
  final int boatId;
  final OwnerModel owner;
  final double share;

  const BoatOwnerDto({
    required this.boatOwnerId,
    required this.boatId,
    required this.owner,
    required this.share,
  });
}
