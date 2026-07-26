import 'package:fishing_app/features/owners/data/tables/owner_table.dart';

class OwnerModel {
  final int? id;
  final String name;
  final String? phone;

  const OwnerModel({this.id, required this.name, this.phone});

  Map<String, dynamic> toMap() {
    return {
      OwnerTable.idColumn: id,
      OwnerTable.nameColumn: name,
      OwnerTable.phoneColumn: phone,
    };
  }

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
      id: map[OwnerTable.idColumn],
      name: map[OwnerTable.nameColumn],
      phone: map[OwnerTable.phoneColumn],
    );
  }

  OwnerModel copyWith({int? id, String? name, String? phone}) {
    return OwnerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      phone: phone ?? this.phone,
    );
  }
}
