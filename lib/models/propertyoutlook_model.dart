import 'dart:convert';

class PropertyOutlookModel {
  int id;
  String nameAr;
  String nameEn;
  PropertyOutlookModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  PropertyOutlookModel.create({required this.nameAr, required this.nameEn})
      : id = 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  factory PropertyOutlookModel.fromMap(Map<String, dynamic> map) {
    return PropertyOutlookModel(
      id: map['id'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PropertyOutlookModel.fromJson(String source) =>
      PropertyOutlookModel.fromMap(json.decode(source));
}
