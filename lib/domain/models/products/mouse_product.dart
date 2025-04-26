// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

class MouseProduct extends Product {
  final int dpi;
  final String sensor;
  final int buttons;
  final bool bluetooth;
  final double weight;

  MouseProduct({
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
    required this.dpi,
    required this.sensor,
    required this.buttons,
    required this.bluetooth,
    required this.weight,
  });

  factory MouseProduct.fromJson(Map<String, dynamic> json) {
    return MouseProduct(
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
      dpi: json['specs']['dpi'],
      sensor: json['specs']['sensor'],
      buttons: json['specs']['buttons'],
      bluetooth: json['specs']['bluetooth'] == 1,
      weight: double.parse(json['specs']['weight'].toString()),
    );
  }
}