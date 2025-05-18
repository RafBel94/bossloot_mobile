
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'order_item.dart';

class Order {
  final int id;
  final int userId;
  final int? cartId;
  final String status;
  final String? paymentMethod;
  final String? paymentId;
  final double totalAmount;
  final String currency;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.userId,
    this.cartId,
    required this.status,
    this.paymentMethod,
    this.paymentId,
    required this.totalAmount,
    required this.currency,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'cart_id': cartId,
      'status': status,
      'payment_method': paymentMethod,
      'payment_id': paymentId,
      'total_amount': totalAmount,
      'currency': currency,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> map) {
    return Order(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      cartId: map['cart_id']?.toInt(),
      status: map['status'] ?? 'pending_payment',
      paymentMethod: map['payment_method'],
      paymentId: map['payment_id'],
      totalAmount: map['total_amount'] == null
        ? 0.0
        : map['total_amount'] is String
            ? double.parse(map['total_amount'])
            : map['total_amount'].toDouble(),
      currency: map['currency'] ?? 'EUR',
      notes: map['notes'],
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updated_at'] ?? DateTime.now().toIso8601String()),
      items: map['items'] != null
          ? List<OrderItem>.from(map['items']?.map((x) => OrderItem.fromJson(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJsonString(String source) => Order.fromJson(json.decode(source));

  @override
  String toString() {
    return 'Order(id: $id, userId: $userId, status: $status, totalAmount: $totalAmount, currency: $currency)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Order &&
      other.id == id &&
      other.userId == userId &&
      other.cartId == cartId &&
      other.status == status &&
      other.paymentMethod == paymentMethod &&
      other.paymentId == paymentId &&
      other.totalAmount == totalAmount &&
      other.currency == currency &&
      other.notes == notes &&
      listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      cartId.hashCode ^
      status.hashCode ^
      paymentMethod.hashCode ^
      paymentId.hashCode ^
      totalAmount.hashCode ^
      currency.hashCode ^
      notes.hashCode ^
      items.hashCode;
  }
}