
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'cart_item.dart';

class Cart {
  final int id;
  final int userId;
  final String status;
  final double totalAmount;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<CartItem> items;

  Cart({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalAmount,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    this.items = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'status': status,
      'total_amount': totalAmount,
      'currency': currency,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': items.map((x) => x.toMap()).toList(),
    };
  }

  factory Cart.fromJson(Map<String, dynamic> map) {
    return Cart(
      id: map['id']?.toInt() ?? 0,
      userId: map['user_id']?.toInt() ?? 0,
      status: map['status'] ?? 'active',
      totalAmount: map['total_amount'] == null
        ? 0.0
        : map['total_amount'] is String
            ? double.parse(map['total_amount'])
            : map['total_amount'].toDouble(),
      currency: map['currency'] ?? 'EUR',
      createdAt: DateTime.parse(map['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(map['updated_at'] ?? DateTime.now().toIso8601String()),
      items: map['items'] != null
          ? List<CartItem>.from(map['items']?.map((x) => CartItem.fromJson(x)))
          : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory Cart.fromJsonString(String source) => Cart.fromJson(json.decode(source));

  @override
  String toString() {
    return 'Cart(id: $id, userId: $userId, status: $status, totalAmount: $totalAmount, currency: $currency, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Cart &&
      other.id == id &&
      other.userId == userId &&
      other.status == status &&
      other.totalAmount == totalAmount &&
      other.currency == currency &&
      listEquals(other.items, items);
  }

  @override
  int get hashCode {
    return id.hashCode ^
      userId.hashCode ^
      status.hashCode ^
      totalAmount.hashCode ^
      currency.hashCode ^
      items.hashCode;
  }
}