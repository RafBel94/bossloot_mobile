
// ignore_for_file: avoid_print

import 'package:bossloot_mobile/domain/models/orders/order.dart';

class CheckoutResponse {
  final bool success;
  final String message;
  final dynamic data; // Acepta cualquier tipo (Map o List)

  CheckoutResponse({
    required this.success, 
    required this.message, 
    required this.data
  });

  factory CheckoutResponse.fromJson(Map<String, dynamic> json) {
    return CheckoutResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'] ?? {'error': 'Empty data'},
    );
  }
  
  // Helper para obtener la orden de forma segura
  Order? getOrder() {
    try {
      if (data is Map && data.containsKey('order')) {
        return Order.fromJson(data['order']);
      } else if (data is List && data.isNotEmpty) {
        // Si la lista contiene objetos y el primer objeto tiene una clave 'id'
        if (data[0] is Map && data[0].containsKey('id')) {
          return Order.fromJson(data[0]);
        }
      }
      return null;
    } catch (e) {
      print('Error parsing order: $e');
      return null;
    }
  }
}