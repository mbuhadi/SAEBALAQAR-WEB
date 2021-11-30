// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:daymanager3/models/dealer_model.dart';

class OfficeModel {
  final int id;
  final String name;
  final String image;
  final String owner;

  OfficeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.owner,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'owner': owner,
    };
  }

  factory OfficeModel.fromMap(dynamic map) {
    return OfficeModel(
      id: map['id'],
      name: map['name_ar'],
      image: map['image'],
      owner: map['owner']['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfficeModel.fromJson(String source) =>
      OfficeModel.fromMap(json.decode(source));
}

class OfficeProfileModel {
  String name;
  String imageUrl;
  List<DealerSummaryModel> dealers;
  DealerSummaryModel owner;

  OfficeProfileModel({
    required this.name,
    required this.imageUrl,
    required this.owner,
    required this.dealers,
  });

  OfficeProfileModel.fromJson(Map<String, dynamic> map)
      : this(
          name: map['name'],
          imageUrl: map['image'],
          owner: DealerSummaryModel.fromMap(map['owner']),
          dealers: List<DealerSummaryModel>.from(
              map['dealers'].map((x) => DealerSummaryModel.fromMap(x))),
        );
}

class OfficeSummaryModel {
  final String name;
  final String image;
  OfficeSummaryModel({
    required this.name,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }

  factory OfficeSummaryModel.fromMap(Map<String, dynamic> map) {
    return OfficeSummaryModel(
      name: map['name_ar'],
      image: map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfficeSummaryModel.fromJson(String source) =>
      OfficeSummaryModel.fromMap(json.decode(source));
}
