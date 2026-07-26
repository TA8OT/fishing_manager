import 'package:fishing_app/features/workers/data/tables/worker_table.dart';

class WorkerModel {
  final int? id;
  final String name;
  final String? phone;
  const WorkerModel({this.id, required this.name, this.phone});

  Map<String, dynamic> toMap() {
    return {
      WorkerTable.idColumn: id,
      WorkerTable.nameColumn: name,
      WorkerTable.phoneColumn: phone,
    };
  }

  factory WorkerModel.fromMap(Map<String, dynamic> map) {
    return WorkerModel(
      id: map[WorkerTable.idColumn],
      name: map[WorkerTable.nameColumn],
      phone: map[WorkerTable.phoneColumn],
    );
  }

  WorkerModel copyWith({int? id, String? name, String? phone}) {
    return WorkerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
