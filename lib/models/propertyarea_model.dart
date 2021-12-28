import 'dart:convert';

import 'package:daymanager3/models/governorate_model.dart';

class PropertyAreaModel {
  int id;
  String nameAr;
  String nameEn;
  final GovernorateModel governorate;
  PropertyAreaModel(
      {required this.id,
      required this.nameAr,
      required this.nameEn,
      required this.governorate});

  PropertyAreaModel.create(
      {required this.nameAr, required this.nameEn, required this.governorate})
      : id = 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name_ar': nameAr,
      'name_en': nameEn,
      'governorate': governorate,
    };
  }

  factory PropertyAreaModel.fromMap(Map<String, dynamic> map) {
    return PropertyAreaModel(
      id: map['id'],
      nameAr: map['name_ar'],
      nameEn: map['name_en'],
      governorate: GovernorateModel.fromMap(map['governorate']),
    );
  }

  String toJson() => json.encode(toMap());
//
  factory PropertyAreaModel.fromJson(String source) =>
      PropertyAreaModel.fromMap(json.decode(source));

  PropertyAreaModel copyWith(
      {int? id,
      String? nameAr,
      String? nameEn,
      GovernorateModel? governorate}) {
    return PropertyAreaModel(
      id: id ?? this.id,
      nameAr: nameAr ?? this.nameAr,
      nameEn: nameEn ?? this.nameEn,
      governorate: governorate ?? this.governorate,
    );
  }
}
