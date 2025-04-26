import 'dart:convert';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:http/http.dart' as http;

class ProductService {
  final String baseUrl = 'https://bossloot-kbsiw.ondigitalocean.app/api';

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
}