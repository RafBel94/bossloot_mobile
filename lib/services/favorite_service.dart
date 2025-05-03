
import 'dart:convert';

import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:http/http.dart' as http;

class FavoriteService {
  // final String baseUrl = 'https://bossloot-kbsiw.ondigitalocean.app/api';
  final String baseUrl = 'http://192.168.1.49:8000/api';

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