import 'dart:convert';

class GovernorateModel {
  int id;
  String nameAr;
  String nameEn;
  GovernorateModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
  });

  GovernorateModel.create({required this.nameAr, required this.nameEn})
      : id = 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
    };
  }

  factory GovernorateModel.fromMap(Map<String, dynamic> map) {
    return GovernorateModel(
      id: map['id'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
    );
  }

  String toJson() => json.encode(toMap());
//
  factory GovernorateModel.fromJson(String source) =>
      GovernorateModel.fromMap(json.decode(source));

  GovernorateModel copyWith({
    int? id,
    String? nameAr,
    String? nameEn,
  }) {
    return GovernorateModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
    );
  }
}
