// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';

class StorageProduct extends Product {
  final String type;
  final int capacity;
  final int rpm;
  final int readSpeed;
  final int writeSpeed;

  StorageProduct({
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
    required this.type,
    required this.capacity,
    required this.rpm,
    required this.readSpeed,
    required this.writeSpeed,
  });

  factory StorageProduct.fromJson(Map<String, dynamic> json) {
    return StorageProduct(
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
      type: json['specs']['type'],
      capacity: json['specs']['capacity'],
      rpm: json['specs']['rpm'],
      readSpeed: json['specs']['read_speed'],
      writeSpeed: json['specs']['write_speed'],
    );
  }
}