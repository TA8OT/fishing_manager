import 'package:fishing_app/features/boats/data/tables/boat_owner_table.dart';

class BoatOwnerModel {
  final int? id;
  final int boatId;
  final int ownerId;

  const BoatOwnerModel({this.id, required this.boatId, required this.ownerId});

  Map<String, dynamic> toMap() {
    return {
      BoatOwnerTable.idColumn: id,
      BoatOwnerTable.boatIdColumn: boatId,
      BoatOwnerTable.ownerIdColumn: ownerId,
    };
  }

  factory BoatOwnerModel.fromMap(Map<String, dynamic> map) {
    return BoatOwnerModel(
      id: map[BoatOwnerTable.idColumn] as int?,
      boatId: map[BoatOwnerTable.boatIdColumn] as int,
      ownerId: map[BoatOwnerTable.ownerIdColumn] as int,
    );
  }

  BoatOwnerModel copyWith({int? id, int? boatId, int? ownerId}) {
    return BoatOwnerModel(
      id: id ?? this.id,
      boatId: boatId ?? this.boatId,
      ownerId: ownerId ?? this.ownerId,
    );
  }
}
