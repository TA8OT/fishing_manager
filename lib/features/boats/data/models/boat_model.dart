import 'package:fishing_app/features/boats/data/tables/boat_table.dart';

class BoatModel {
  final int? id;
  final String name;
  final String registrationNumber;
  final double captainShare;

  const BoatModel({
    this.id,
    required this.name,
    required this.registrationNumber,
    required this.captainShare,
  });

  Map<String, dynamic> toMap() {
    return {
      BoatTable.idColumn: id,
      BoatTable.nameColumn: name,
      BoatTable.registrationNumberColumn: registrationNumber,
      BoatTable.captainShareColumn: captainShare,
    };
  }

  factory BoatModel.fromMap(Map<String, dynamic> map) {
    return BoatModel(
      id: map[BoatTable.idColumn],
      name: map[BoatTable.nameColumn],
      registrationNumber: map[BoatTable.registrationNumberColumn],
      captainShare: map[BoatTable.captainShareColumn],
    );
  }

  BoatModel copyWith({
    int? id,
    String? name,
    String? registrationNumber,
    double? captainShare,
  }) {
    return BoatModel(
      id: id ?? this.id,
      name: name ?? this.name,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      captainShare: captainShare ?? this.captainShare,
    );
  }
}
