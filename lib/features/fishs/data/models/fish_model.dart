import 'package:fishing_app/features/fishs/data/tables/fish_table.dart';

class FishModel {
  final int? id;
  final String name;

  const FishModel({this.id, required this.name});

  Map<String, dynamic> toMap() {
    return {FishTable.idColumn: id, FishTable.nameColumn: name};
  }

  factory FishModel.fromMap(Map<String, dynamic> map) {
    return FishModel(
      id: map[FishTable.idColumn],
      name: map[FishTable.nameColumn],
    );
  }

  FishModel copyWith({int? id, String? name}) {
    return FishModel(id: id ?? this.id, name: name ?? this.name);
  }
}
