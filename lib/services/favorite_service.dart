
import 'dart:convert';

import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  String baseUrl = dotenv.get('API_URL');

  FavoriteService();

  // Method to fetch all favorites for a user
  Future<FetchResponse> getFavorites(String userId, String token) async {
    final endpoint = '$baseUrl/favorites/user-favorites/$userId';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return FetchResponse.fromJson(json.decode(response.body));
  }

  // Method to add a favorite
  Future<FetchResponse> addFavorite(String userId, String productId, String token) async {
    final endpoint = '$baseUrl/favorites/store';

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode({
        'user_id': userId,
        'product_id': productId,
      }),
    );

    return FetchResponse.fromJson(json.decode(response.body));
  }

  // Method to remove a favorite
  Future<FetchResponse> removeFavorite(String userId, String productId, String token) async {
    final endpoint = '$baseUrl/favorites/delete/$userId/$productId';

    final response = await http.delete(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    return FetchResponse.fromJson(json.decode(response.body));
  }
}