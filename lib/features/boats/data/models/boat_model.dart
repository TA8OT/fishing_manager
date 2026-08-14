import 'package:fishing_app/features/boats/data/tables/boat_table.dart';

class BoatModel {
  final int? id;
  final String name;
  final String? registrationNumber;
  final double captainShare;
  final int? captainWorkerId;

  const BoatModel({
    this.id,
    required this.name,
    this.registrationNumber,
    required this.captainShare,
    this.captainWorkerId,
  });

  Map<String, dynamic> toMap() {
    return {
      BoatTable.idColumn: id,
      BoatTable.nameColumn: name,
      BoatTable.registrationNumberColumn: registrationNumber,
      BoatTable.captainShareColumn: captainShare,
      BoatTable.captainWorkerId: captainWorkerId,
    };
  }

  factory BoatModel.fromMap(Map<String, dynamic> map) {
    return BoatModel(
      id: map[BoatTable.idColumn],
      name: map[BoatTable.nameColumn],
      registrationNumber: map[BoatTable.registrationNumberColumn],
      captainShare: map[BoatTable.captainShareColumn],
      captainWorkerId: map[BoatTable.captainWorkerId],
    );
  }

  BoatModel copyWith({
    int? id,
    String? name,
    String? registrationNumber,
    double? captainShare,
    int? captainWorkerId,
  }) {
    return BoatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      captainShare: captainShare ?? this.captainShare,
      captainWorkerId: captainWorkerId ?? this.captainWorkerId,
    );
  }
}
