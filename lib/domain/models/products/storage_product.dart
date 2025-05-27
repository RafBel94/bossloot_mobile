// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/products/product.dart';
import 'package:bossloot_mobile/domain/models/valoration.dart';

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
    required super.deleted,
    required super.valorations,
    required super.avg_rating,
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
      deleted: json['deleted'] == 1 || json['deleted'] == true,
      valorations: (json['valorations'] as List)
          .map((valoration) => Valoration.fromJson(valoration))
          .toList(),
      avg_rating: double.parse(json['avg_rating'].toString()),
      type: json['specs']['type'],
      capacity: json['specs']['capacity'],
      rpm: json['specs']['rpm'],
      readSpeed: json['specs']['read_speed'],
      writeSpeed: json['specs']['write_speed'],
    );
  }
}