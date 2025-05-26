
import 'dart:convert';

class SimpleProduct {
  final int id;
  final String name;
  final String? description;
  final String? model;
  final double price;
  final int quantity;
  final bool onOffer;
  final double? discount;
  final bool featured;
  final String? image;
  final int? points;
  final bool deleted;

  SimpleProduct({
    required this.id,
    required this.name,
    this.description,
    this.model,
    required this.price,
    required this.quantity,
    required this.onOffer,
    this.discount,
    required this.featured,
    this.image,
    this.points,
    this.deleted = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'model': model,
      'price': price,
      'quantity': quantity,
      'on_offer': onOffer,
      'discount': discount,
      'featured': featured,
      'image': image,
      'points': points,
      'deleted': deleted,
    };
  }

  factory SimpleProduct.fromJson(Map<String, dynamic> map) {
    return SimpleProduct(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      description: map['description'],
      model: map['model'],
      price: map['price'] == null
        ? 0.0
        : map['price'] is String
            ? double.parse(map['price'].toString())
            : map['price'].toDouble(),
      quantity: map['quantity']?.toInt() ?? 0,
      onOffer: map['on_offer'] == 1 || map['on_offer'] == true,
      discount: map['discount'] == null
        ? 0.0
        : map['discount'] is String
            ? double.parse(map['discount'].toString())
            : map['discount'].toDouble(),
      featured: map['featured'] == 1 || map['featured'] == true,
      image: map['image'],
      points: map['points']?.toInt(),
      deleted: map['deleted'] == 1 || map['deleted'] == true,
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleProduct.fromJsonString(String source) => SimpleProduct.fromJson(json.decode(source));

  @override
  String toString() {
    return 'SimpleProduct(id: $id, name: $name, price: $price, quantity: $quantity)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is SimpleProduct &&
      other.id == id &&
      other.name == name &&
      other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ price.hashCode;
}