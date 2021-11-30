import 'dart:convert';

// ignore_for_file: non_constant_identifier_names
class DealerSummaryModel {
  String name;
  String phone;

  DealerSummaryModel({
    required this.phone,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
    };
  }

  factory DealerSummaryModel.fromMap(Map<String, dynamic> map) {
    return DealerSummaryModel(
      name: map['name'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DealerSummaryModel.fromJson(String source) =>
      DealerSummaryModel.fromMap(json.decode(source));
}

class DealerModel implements DealerSummaryModel {
  @override
  String name;

  @override
  String phone;

  final int post_limit;
  final int carry_over;
  final int post_count;
  final int remaining;
  DealerModel({
    required this.name,
    required this.phone,
    required this.post_limit,
    required this.carry_over,
    required this.post_count,
    required this.remaining,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'post_limit': post_limit,
      'carry_over': carry_over,
      'post_count': post_count,
      'remaining': remaining,
    };
  }

  factory DealerModel.fromMap(Map<String, dynamic> map) {
    return DealerModel(
      name: map['name'],
      phone: map['phone'],
      post_limit: map['carry_over'] + map['post_count'] + map['remaining'],
      carry_over: map['carry_over'],
      post_count: map['post_count'],
      remaining: map['remaining'],
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory DealerModel.fromJson(String source) =>
      DealerModel.fromMap(json.decode(source));
}
