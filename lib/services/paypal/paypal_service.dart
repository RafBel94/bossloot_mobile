// lib/services/paypal_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/domain/models/paypal_response.dart'; // Nuevo modelo
import 'package:bossloot_mobile/services/token_service.dart';

class PayPalService {
  // final String baseUrl = 'https://bossloot-kbsiw.ondigitalocean.app/api';
  final String baseUrl = 'http://192.168.1.49:8000/api';
  final TokenService tokenService;

  PayPalService(this.tokenService);

  // Method to create a PayPal order
  Future<PaypalResponse> createPayPalOrder(int orderId) async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/paypal/create-order/$orderId';

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      return PaypalResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return PaypalResponse(
        success: false, 
        message: 'Error creating PayPal order: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }

  // Method to capture/confirm a PayPal payment
  Future<ApiResponse> capturePayment(String paypalOrderId) async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/paypal/capture-payment';

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'order_id': paypalOrderId,
        }),
      );

      return ApiResponse.fromJson(json.decode(response.body)); // Esto sigue usando ApiResponse
    } catch (e) {
      return ApiResponse(
        success: false, 
        message: 'Error capturing payment: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }
}