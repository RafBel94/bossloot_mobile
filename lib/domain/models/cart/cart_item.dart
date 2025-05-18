
import 'dart:convert';
import 'package:bossloot_mobile/domain/models/products/simple_product.dart';

class CartItem {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SimpleProduct? product;

  CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.createdAt,
    required this.updatedAt,
    this.product,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cart_id': cartId,
      'product_id': productId,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'product': product?.toMap(),
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> map) {
    return CartItem(
      id: map['id']?.toInt() ?? 0,
      cartId: map['cart_id']?.toInt() ?? 0,
      productId: map['product_id']?.toInt() ?? 0,
      quantity: map['quantity']?.toInt() ?? 0,
      unitPrice: map['unit_price'] == null
        ? 0.0
        : map['unit_price'] is String
          ? double.parse(map['unit_price'])
          : map['unit_price'].toDouble(),
      totalPrice: map['total_price'] == null
        ? 0.0
        : map['total_price'] is String
          ? double.parse(map['total_price'])
          : map['total_price'].toDouble(),
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updated_at'] ?? DateTime.now().toIso8601String()),
      product: map['product'] != null ? SimpleProduct.fromJson(map['product']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJsonString(String source) => CartItem.fromJson(json.decode(source));

  @override
  String toString() {
    return 'CartItem(id: $id, cartId: $cartId, productId: $productId, quantity: $quantity, unitPrice: $unitPrice, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is CartItem &&
      other.id == id &&
      other.cartId == cartId &&
      other.productId == productId &&
      other.quantity == quantity &&
      other.unitPrice == unitPrice &&
      other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      cartId.hashCode ^
      productId.hashCode ^
      quantity.hashCode ^
      unitPrice.hashCode ^
      totalPrice.hashCode;
  }
}