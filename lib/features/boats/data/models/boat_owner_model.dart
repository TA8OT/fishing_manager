import 'package:fishing_app/features/boats/data/tables/boat_owner_table.dart';

class BoatOwnerModel {
  final int? id;
  final int boatId;
  final int ownerId;
  final double share;

  const BoatOwnerModel({
    this.id,
    required this.boatId,
    required this.ownerId,
    required this.share,
  });

  Map<String, dynamic> toMap() {
    return {
      BoatOwnerTable.idColumn: id,
      BoatOwnerTable.boatIdColumn: boatId,
      BoatOwnerTable.ownerIdColumn: ownerId,
      BoatOwnerTable.shareColumn: share,
    };
  }

  factory BoatOwnerModel.fromMap(Map<String, dynamic> map) {
    return BoatOwnerModel(
      id: map[BoatOwnerTable.idColumn] as int?,
      boatId: map[BoatOwnerTable.boatIdColumn] as int,
      ownerId: map[BoatOwnerTable.ownerIdColumn] as int,
      share: (map[BoatOwnerTable.shareColumn] as num).toDouble(),
    );
  }

  BoatOwnerModel copyWith({int? id, int? boatId, int? ownerId, double? share}) {
    return BoatOwnerModel(
      id: id ?? this.id,
      boatId: boatId ?? this.boatId,
      ownerId: ownerId ?? this.ownerId,
      share: share ?? this.share,
    );
  }
}
