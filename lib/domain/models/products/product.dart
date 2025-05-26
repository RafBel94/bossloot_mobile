// ignore_for_file: non_constant_identifier_names

import 'package:bossloot_mobile/domain/models/valoration.dart';

class Product {
  int id;
  String name;
  String description;
  String category;
  String brand;
  String model;
  double price;
  double discount;
  int quantity;
  bool on_offer;
  bool featured;
  String image;
  int points;
  bool deleted;
  List<Valoration> valorations;
  double avg_rating;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.category,
    required this.brand,
    required this.model,
    required this.price,
    required this.discount,
    required this.quantity,
    required this.on_offer,
    required this.featured,
    required this.image,
    required this.points,
    required this.deleted,
    required this.valorations,
    required this.avg_rating,
  });
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'category': category,
      'brand': brand,
      'model': model,
      'price': price,
      'discount': discount,
      'quantity': quantity,
      'on_offer': on_offer,
      'featured': featured,
      'image': image,
      'points': points,
      'deleted': deleted,
      'valorations': valorations.map((x) => x.toJson()).toList(),
      'avg_rating': avg_rating
    };
  }

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      category: map['category'] ?? '',
      brand: map['brand'] ?? '',
      model: map['model'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      discount: map['discount']?.toDouble() ?? 0.0,
      quantity: map['quantity']?.toInt() ?? 0,
      on_offer: map['on_offer'] ?? false,
      featured: map['featured'] ?? false,
      image: map['image'] ?? '',
      points: map['points']?.toInt() ?? 0,
      deleted: map['deleted'] ?? false,
      valorations: List<Valoration>.from(map['valorations']?.map((x) => Valoration.fromJson(x))),
      avg_rating: map['avg_rating']?.toDouble() ?? 0.0,
    );
  }

}