import 'dart:convert';

class OfferModel {
  final int id;
  final String name;
  final String image;
  final double price;
  final int credit;

  OfferModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.credit,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'credit': credit,
    };
  }

  factory OfferModel.fromMap(Map<String, dynamic> map) {
    return OfferModel(
      id: map['id'],
      name: map['name_ar'],
      image: map['image'],
      price: map['price'],
      credit: map['credit'],
    );
  }

  String toJson() => json.encode(toMap());

  factory OfferModel.fromJson(String source) =>
      OfferModel.fromMap(json.decode(source));
}
