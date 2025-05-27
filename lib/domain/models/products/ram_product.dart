// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

class RamProduct extends Product {
  final int speed;
  final int memory;
  final String memory_type;
  final int latency;

  RamProduct({
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
    required super.deleted,
    required super.valorations,
    required super.avg_rating,
    required this.speed,
    required this.memory,
    required this.memory_type,
    required this.latency,
  });

  factory RamProduct.fromJson(Map<String, dynamic> json) {
    return RamProduct(
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
      deleted: json['deleted'] == 1 || json['deleted'] == true,
      valorations: (json['valorations'] as List)
          .map((valoration) => Valoration.fromJson(valoration))
          .toList(),
      avg_rating: double.parse(json['avg_rating'].toString()),
      speed: json['specs']['speed'],
      memory: json['specs']['memory'],
      memory_type: json['specs']['memory_type'],
      latency: json['specs']['latency'],
    );
  }

}