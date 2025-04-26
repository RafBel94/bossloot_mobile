// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

class KeyboardProduct extends Product {
  String type;
  String switch_type;
  double width;
  double height;
  double weight;

  KeyboardProduct({
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.brand,
    required super.model,
    required super.price,
    required super.discount,
    required super.quantity,
    required super.on_offer,
    required super.featured,
    required super.image,
    required super.points,
    required super.valorations,
    required super.avg_rating,
    required this.type,
    required this.switch_type,
    required this.width,
    required this.height,
    required this.weight,
  });

  factory KeyboardProduct.fromJson(Map<String, dynamic> json) {
    return KeyboardProduct(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      category: json['category'],
      brand: json['brand'],
      model: json['model'],
      price: double.parse(json['price'].toString()),
      discount: double.parse(json['discount'].toString()),
      quantity: json['quantity'],
      on_offer: json['on_offer'] == 1,
      featured: json['featured'] == 1,
      image: json['image'],
      points: json['points'],
      valorations: (json['valorations'] as List)
          .map((valoration) => Valoration.fromJson(valoration))
          .toList(),
      avg_rating: double.parse(json['avg_rating'].toString()),
      type: json['specs']['type'],
      switch_type: json['specs']['switch_type'],
      width: double.parse(json['specs']['width'].toString()),
      height: double.parse(json['specs']['height'].toString()),
      weight: double.parse(json['specs']['weight'].toString()),
    );
  }
}