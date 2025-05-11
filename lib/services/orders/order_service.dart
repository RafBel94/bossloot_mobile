// lib/services/order_service.dart
import 'dart:convert';
import 'package:bossloot_mobile/domain/models/checkout_response.dart';
import 'package:http/http.dart' as http;
import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/services/token_service.dart';

class OrderService {
  // final String baseUrl = 'https://bossloot-kbsiw.ondigitalocean.app/api';
  final String baseUrl = 'http://192.168.1.49:8000/api';
  final TokenService tokenService;

  OrderService(this.tokenService);

  // Method to get all user orders
  Future<ApiResponse> getOrders() async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/orders';

      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return ApiResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return ApiResponse(
        success: false, 
        message: 'Error getting orders: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }

  // Method to get a specific order
  Future<ApiResponse> getOrder(int orderId) async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/orders/$orderId';

      final response = await http.get(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return ApiResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return ApiResponse(
        success: false, 
        message: 'Error getting order details: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }

  // Method to create an order from the cart (checkout)
  Future<CheckoutResponse> checkout() async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/checkout';

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      final responseBody = json.decode(response.body);

      // Imprimir la respuesta para depuración
      // print('Checkout response: $responseBody');
      
      return CheckoutResponse.fromJson(responseBody);
    } catch (e) {
      print('Error during checkout: $e');
      return CheckoutResponse(
        success: false, 
        message: 'Error during checkout: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }
}