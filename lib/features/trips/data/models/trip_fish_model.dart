import 'package:fishing_app/features/trips/data/tables/trip_fishs_table.dart';

class TripFishModel {
  final int? id;
  final int tripId;
  final int fishId;
  final double weight;
  final double pricePerKg;

  const TripFishModel({
    this.id,
    required this.tripId,
    required this.fishId,
    required this.weight,
    required this.pricePerKg,
  });

  Map<String, dynamic> toMap() {
    return {
      TripFishsTable.idColumn: id,
      TripFishsTable.tripIdColumn: tripId,
      TripFishsTable.fishIdColumn: fishId,
      TripFishsTable.weightColumn: weight,
      TripFishsTable.pricePerKgColumn: pricePerKg,
    };
  }

  factory TripFishModel.fromMap(Map<String, dynamic> map) {
    return TripFishModel(
      id: map[TripFishsTable.idColumn] as int?,
      tripId: map[TripFishsTable.tripIdColumn] as int,
      fishId: map[TripFishsTable.fishIdColumn] as int,
      weight: (map[TripFishsTable.weightColumn] as num).toDouble(),
      pricePerKg: (map[TripFishsTable.pricePerKgColumn] as num).toDouble(),
    );
  }

  TripFishModel copyWith({
    int? id,
    int? tripId,
    int? fishId,
    double? weight,
    double? pricePerKg,
  }) {
    return TripFishModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      fishId: fishId ?? this.fishId,
      weight: weight ?? this.weight,
      pricePerKg: pricePerKg ?? this.pricePerKg,
    );
  }
}
