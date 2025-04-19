// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';

class CaseProduct extends Product {
  final String case_type;
  final String form_factor_support;
  final bool tempered_glass;
  final int expansion_slots;
  final double max_gpu_length;
  final double max_cpu_cooler_height;
  final bool radiator_support;
  final int extra_fans_connectors;
  final double depth;
  final double width;
  final double height;
  final double weight;

  CaseProduct({
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
    required this.case_type,
    required this.form_factor_support,
    required this.tempered_glass,
    required this.expansion_slots,
    required this.max_gpu_length,
    required this.max_cpu_cooler_height,
    required this.radiator_support,
    required this.extra_fans_connectors,
    required this.depth,
    required this.width,
    required this.height,
    required this.weight,
  });

  factory CaseProduct.fromJson(Map<String, dynamic> json) {
    return CaseProduct(
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
      case_type: json['specs']['case_type'],
      form_factor_support: json['specs']['form_factor_support'],
      tempered_glass: json['specs']['tempered_glass'] == 1,
      expansion_slots: json['specs']['expansion_slots'],
      max_gpu_length: double.parse(json['specs']['max_gpu_length'].toString()),
      max_cpu_cooler_height: double.parse(json['specs']['max_cpu_cooler_height'].toString()),
      radiator_support: json['specs']['radiator_support'] == 1,
      extra_fans_connectors: json['specs']['extra_fans_connectors'],
      depth: double.parse(json['specs']['depth'].toString()),
      width: double.parse(json['specs']['width'].toString()),
      height: double.parse(json['specs']['height'].toString()),
      weight: double.parse(json['specs']['weight'].toString()),
    );
  }
}