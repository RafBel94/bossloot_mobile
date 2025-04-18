import 'dart:convert';

import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:bossloot_mobile/services/token_service.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final TokenService tokenService;
  final String baseUrl = 'https://bossloot-kbsiw.ondigitalocean.app/api';

  CategoryService(this.tokenService);

  Future<FetchResponse> getCategories() async {
    final endpoint = '$baseUrl/categories';
    final token = await tokenService.getToken();

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    return FetchResponse.fromJson(json.decode(response.body));
  }
}