// lib/services/cart_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/services/token_service.dart';

class CartService {
  // final String baseUrl = 'https://bossloot-kbsiw.ondigitalocean.app/api';
  final String baseUrl = 'http://192.168.1.49:8000/api';
  final TokenService tokenService;

  CartService(this.tokenService);

  // Method to get the user's cart
  Future<ApiResponse> getCart() async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/cart';

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
        message: 'Error getting cart: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }

  // Method to add an item to the cart
  Future<ApiResponse> addItemToCart(int productId, int quantity) async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/cart/items';

      final response = await http.post(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'product_id': productId,
          'quantity': quantity,
        }),
      );

      return ApiResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return ApiResponse(
        success: false, 
        message: 'Error adding item to cart: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }

  // Method to update the quantity of an item in the cart
  Future<ApiResponse> updateCartItem(int itemId, int quantity) async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/cart/items/$itemId';

      final response = await http.put(
        Uri.parse(endpoint),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: json.encode({
          'quantity': quantity,
        }),
      );

      return ApiResponse.fromJson(json.decode(response.body));
    } catch (e) {
      return ApiResponse(
        success: false, 
        message: 'Error updating cart item: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }

  // Method to remove an item from the cart
  Future<ApiResponse> removeCartItem(int itemId) async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/cart/items/$itemId';

      final response = await http.delete(
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
        message: 'Error removing cart item: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }

  // Method to clear the cart
  Future<ApiResponse> clearCart() async {
    try {
      final token = await tokenService.getToken();
      final endpoint = '$baseUrl/cart';

      final response = await http.delete(
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
        message: 'Error clearing cart: ${e.toString()}',
        data: {'error': e.toString()}
      );
    }
  }
}