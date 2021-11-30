import 'dart:convert';

class PropertyTypeModel {
  int id;
  String nameAr;
  String nameEn;
  PropertyTypeModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  PropertyTypeModel.create({required this.nameAr, required this.nameEn})
      : id = 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  factory PropertyTypeModel.fromMap(Map<String, dynamic> map) {
    return PropertyTypeModel(
      id: map['id'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyTypeModel.fromJson(String source) =>
      PropertyTypeModel.fromMap(json.decode(source));
}
