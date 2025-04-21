// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';

class GpuProduct extends Product {
  final int memory;
  final String memory_type;
  final int core_clock;
  final int boost_clock;
  final int consumption;
  final double length;

  GpuProduct({
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
    required this.memory,
    required this.memory_type,
    required this.core_clock,
    required this.boost_clock,
    required this.consumption,
    required this.length,
  });

  factory GpuProduct.fromJson(Map<String, dynamic> json) {
    return GpuProduct(
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
      memory: json['specs']['memory'],
      memory_type: json['specs']['memory_type'],
      core_clock: json['specs']['core_clock'],
      boost_clock: json['specs']['boost_clock'],
      consumption: json['specs']['consumption'],
      length: double.parse(json['specs']['length'].toString()),
    );
  }
}