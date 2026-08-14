import 'package:fishing_app/features/trips/data/tables/trip_worker_table.dart';

class TripWorkerModel {
  final int? id;
  final int tripId;
  final int workerId;

  const TripWorkerModel({
    this.id,
    required this.tripId,
    required this.workerId,
  });

  Map<String, dynamic> toMap() {
    return {
      TripWorkerTable.idColumn: id,
      TripWorkerTable.tripIdColumn: tripId,
      TripWorkerTable.workerIdColumn: workerId,
    };
  }

  factory TripWorkerModel.fromMap(Map<String, dynamic> map) {
    return TripWorkerModel(
      id: map[TripWorkerTable.idColumn],
      tripId: map[TripWorkerTable.tripIdColumn],
      workerId: map[TripWorkerTable.workerIdColumn],
    );
  }

  TripWorkerModel copyWith({int? id, int? tripId, int? workerId}) {
    return TripWorkerModel(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      workerId: workerId ?? this.workerId,
    );
  }
}
