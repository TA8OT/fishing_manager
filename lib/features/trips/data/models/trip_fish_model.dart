import 'package:fishing_app/features/trips/data/tables/trip_fishs_table.dart';

class TripFishModel {
  final int? id;
  final int tripId;
  final int fishId;
  final double weight;
  final double pricePerKg;

  const TripFishModel({
    this.id,
    required this.fishId,
    required this.tripId,
    required this.pricePerKg,
    required this.weight,
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
      id: map[TripFishsTable.idColumn],
      fishId: map[TripFishsTable.fishIdColumn],
      tripId: map[TripFishsTable.tripIdColumn],
      pricePerKg: map[TripFishsTable.pricePerKgColumn],
      weight: map[TripFishsTable.weightColumn],
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
      fishId: fishId ?? this.fishId,
      tripId: tripId ?? this.tripId,
      pricePerKg: pricePerKg ?? this.pricePerKg,
      weight: weight ?? this.weight,
    );
  }
}
