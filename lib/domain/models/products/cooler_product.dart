// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

class CoolerProduct extends Product {
  final String type;
  final int fan_rpm;
  final int consumption;
  final String socket_support;
  final double width;
  final double height;

  CoolerProduct({
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
    required super.deleted,
    required super.valorations,
    required super.avg_rating,
    required this.type,
    required this.fan_rpm,
    required this.consumption,
    required this.socket_support,
    required this.width,
    required this.height,
  });

  factory CoolerProduct.fromJson(Map<String, dynamic> json) {
    return CoolerProduct(
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
      deleted: json['deleted'] == 1 || json['deleted'] == true,
      valorations: (json['valorations'] as List)
          .map((valoration) => Valoration.fromJson(valoration))
          .toList(),
      avg_rating: double.parse(json['avg_rating'].toString()),
      type: json['specs']['type'],
      fan_rpm: json['specs']['fan_rpm'],
      consumption: json['specs']['consumption'],
      socket_support: json['specs']['socket_support'],
      width: double.parse(json['specs']['width'].toString()),
      height: double.parse(json['specs']['height'].toString()),
    );
  }
}