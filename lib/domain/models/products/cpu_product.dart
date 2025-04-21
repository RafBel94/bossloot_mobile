// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';

class CpuProduct extends Product {
  final String socket;
  final int coreCount;
  final int thread_count;
  final double base_clock;
  final double boost_clock;
  final int consumption;
  final bool integrated_graphics;

  CpuProduct({
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
    required this.socket,
    required this.coreCount,
    required this.thread_count,
    required this.base_clock,
    required this.boost_clock,
    required this.consumption,
    required this.integrated_graphics,
  });

  factory CpuProduct.fromJson(Map<String, dynamic> json) {
    return CpuProduct(
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
      socket: json['specs']['socket'],
      coreCount: json['specs']['core_count'],
      thread_count: json['specs']['thread_count'],
      base_clock: double.parse(json['specs']['base_clock'].toString()),
      boost_clock: double.parse(json['specs']['boost_clock'].toString()),
      consumption: json['specs']['consumption'],
      integrated_graphics: json['specs']['integrated_graphics'] == 1,
    );
  }
}