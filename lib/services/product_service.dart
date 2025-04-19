import 'dart:convert';

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
}