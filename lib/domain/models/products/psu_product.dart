// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

class PsuProduct extends Product {
  final String efficiency_rating;
  final int wattage;
  final bool modular;
  final bool fanless;

  PsuProduct({
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
    required this.efficiency_rating,
    required this.wattage,
    required this.modular,
    required this.fanless,
  });

  factory PsuProduct.fromJson(Map<String, dynamic> json) {
    return PsuProduct(
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
      efficiency_rating: json['specs']['efficiency_rating'],
      wattage: json['specs']['wattage'],
      modular: json['specs']['modular'] == 1,
      fanless: json['specs']['fanless'] == 1,
    );
  }
}