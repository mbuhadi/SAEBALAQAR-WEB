import 'dart:convert';

import 'package:daymanager3/models/dealer_model.dart';
import 'package:daymanager3/models/office_model.dart';

// ignore_for_file: non_constant_identifier_names

class MultiLangName {
  final String name_ar;
  final String name_en;
  final int id;
  MultiLangName({
    required this.name_ar,
    required this.name_en,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'name_ar': name_ar,
      'name_en': name_en,
      'id': id,
    };
  }

  factory MultiLangName.fromMap(Map<String, dynamic> map) {
    return MultiLangName(
      name_ar: map['name_ar'],
      name_en: map['name_en'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return name_ar;
  }

  factory MultiLangName.fromJson(String source) =>
      MultiLangName.fromMap(json.decode(source));
}

class DealModel {
  final int id;
  final MultiLangName property_type;
  final MultiLangName property_area;
  final MultiLangName property_outlook;
  final String description;
  final DateTime created;
  final OfficeSummaryModel office;
  final DealerSummaryModel dealer;
  DealModel({
    required this.id,
    required this.property_type,
    required this.property_area,
    required this.property_outlook,
    required this.description,
    required this.created,
    required this.office,
    required this.dealer,
  });

  factory DealModel.fromMap(Map<String, dynamic> map) {
    return DealModel(
      id: map['id'],
      property_type: MultiLangName.fromMap(map['property_type']),
      property_area: MultiLangName.fromMap(map['property_area']),
      property_outlook: MultiLangName.fromMap(map['property_outlook']),
      description: map['description'],
      created: DateTime.parse(map['date_created']),
      office: OfficeSummaryModel.fromMap(map['office']),
      dealer: DealerSummaryModel.fromMap(map['dealer']),
    );
  }

  factory DealModel.fromJson(String source) =>
      DealModel.fromMap(json.decode(source));
}
