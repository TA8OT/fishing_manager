import 'package:fishing_app/features/trips/data/tables/trip_table.dart';

class TripModel {
  final int? id;
  final int boatId;
  final int captainWorkerId;
  final DateTime startDate;
  final DateTime endDate;
  final String? notes;

  TripModel({
    this.id,
    required this.boatId,
    required this.captainWorkerId,
    required this.startDate,
    required this.endDate,
    this.notes,
  });

  Map<String, dynamic> toMap() {
    return {
      TripTable.idColumn: id,
      TripTable.boatIdColumn: boatId,
      TripTable.captainWorkerIdColumn: captainWorkerId,
      TripTable.startDateColumn: startDate.toIso8601String(),
      TripTable.endDateColumn: endDate.toIso8601String(),
      TripTable.notesColumn: notes,
    };
  }

  factory TripModel.fromMap(Map<String, dynamic> map) {
    return TripModel(
      id: map[TripTable.idColumn],
      boatId: map[TripTable.boatIdColumn],
      captainWorkerId: map[TripTable.captainWorkerIdColumn],
      startDate: DateTime.parse(map[TripTable.startDateColumn]),
      endDate: DateTime.parse(map[TripTable.endDateColumn]),
      notes: map[TripTable.notesColumn],
    );
  }

  TripModel copyWith({
    int? id,
    int? boatId,
    int? captainWorkerId,
    DateTime? startDate,
    DateTime? endDate,
    String? notes,
  }) {
    return TripModel(
      id: id ?? this.id,
      boatId: boatId ?? this.boatId,
      captainWorkerId: captainWorkerId ?? this.captainWorkerId,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      notes: notes ?? this.notes,
    );
  }
}
