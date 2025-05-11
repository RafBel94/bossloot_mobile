
import 'dart:convert';
import 'package:bossloot_mobile/domain/models/products/simple_product.dart';

class OrderItem {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final DateTime createdAt;
  final DateTime updatedAt;
  final SimpleProduct? product;

  OrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
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
      'order_id': orderId,
      'product_id': productId,
      'product_name': productName,
      'quantity': quantity,
      'unit_price': unitPrice,
      'total_price': totalPrice,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'product': product?.toMap(),
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> map) {
    return OrderItem(
      id: map['id']?.toInt() ?? 0,
      orderId: map['order_id']?.toInt() ?? 0,
      productId: map['product_id']?.toInt() ?? 0,
      productName: map['product_name'] ?? '',
      quantity: map['quantity']?.toInt() ?? 0,
      unitPrice: map['unit_price'] == null
        ? 0.0
        : map['unit_price'] is String
          ? double.parse(map['unit_price'])
          : map['unit_price'].toDouble(),
      totalPrice: map['total_amount'] == null
        ? 0.0
        : map['total_amount'] is String
            ? double.parse(map['total_amount'])
            : map['total_amount'].toDouble(),
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updated_at'] ?? DateTime.now().toIso8601String()),
      product: map['product'] != null ? SimpleProduct.fromJson(map['product']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderItem.fromJsonString(String source) => OrderItem.fromJson(json.decode(source));

  @override
  String toString() {
    return 'OrderItem(id: $id, orderId: $orderId, productId: $productId, productName: $productName, quantity: $quantity, unitPrice: $unitPrice, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is OrderItem &&
      other.id == id &&
      other.orderId == orderId &&
      other.productId == productId &&
      other.productName == productName &&
      other.quantity == quantity &&
      other.unitPrice == unitPrice &&
      other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      orderId.hashCode ^
      productId.hashCode ^
      productName.hashCode ^
      quantity.hashCode ^
      unitPrice.hashCode ^
      totalPrice.hashCode;
  }
}