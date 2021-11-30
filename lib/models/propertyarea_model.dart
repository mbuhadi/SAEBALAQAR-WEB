import 'dart:convert';

class PropertyAreaModel {
  int id;
  String nameAr;
  String nameEn;
  PropertyAreaModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  PropertyAreaModel.create({required this.nameAr, required this.nameEn})
      : id = 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  factory PropertyAreaModel.fromMap(Map<String, dynamic> map) {
    return PropertyAreaModel(
      id: map['id'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyAreaModel.fromJson(String source) =>
      PropertyAreaModel.fromMap(json.decode(source));

  PropertyAreaModel copyWith({
    int? id,
    String? nameAr,
    String? nameEn,
  }) {
    return PropertyAreaModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
    );
  }
}
