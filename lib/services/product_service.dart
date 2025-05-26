import 'dart:convert';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ProductService {
  String baseUrl = dotenv.get('API_URL');

  ProductService();

  // Method to fetch catalog products
  Future<FetchResponse> getCatalogProducts() async {
    final endpoint = '$baseUrl/products';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    
    return FetchResponse.fromJson(json.decode(response.body));
  }

  // Method to fetch product details by ID
  Future<ApiResponse> getProductDetails(int id) async {
    final endpoint = '$baseUrl/products/detailed/$id';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return ApiResponse.fromJson(json.decode(response.body));
  }

  // Method to fetch featured products or added last week
  Future<FetchResponse> getFeaturedProducts() async {
    final endpoint = '$baseUrl/products/featured';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return FetchResponse.fromJson(json.decode(response.body));
  }

  // Method to fetch products by category
  Future<FetchResponse> getProductsByCategory(String category) async {
    final endpoint = '$baseUrl/products/category/$category';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return FetchResponse.fromJson(json.decode(response.body));
  }

  // Method to filter products based on various criteria
Future<FetchResponse> getFilteredProducts(Map<String, dynamic> filters) async {
  String endpoint = '$baseUrl/products/filter';
  
  // Añadir los parámetros de consulta a la URL
  if (filters.isNotEmpty) {
    endpoint += '?';
    filters.forEach((key, value) {
      if (value is List) {
        // Para listas, las codificamos como JSON
        endpoint += '$key=${Uri.encodeComponent(jsonEncode(value))}&';
      } else {
        // Para valores simples, simplemente los convertimos a string
        endpoint += '$key=${Uri.encodeComponent(value.toString())}&';
      }
    });
    // Eliminar el último '&'
    endpoint = endpoint.substring(0, endpoint.length - 1);
  }
  
  try {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    
    return FetchResponse.fromJson(json.decode(response.body));
  } catch (e) {
    return FetchResponse(
      success: false,
      message: 'Network error: $e',
      data: [],
    );
  }
}
}