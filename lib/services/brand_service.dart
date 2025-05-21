import 'dart:convert';

import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class BrandService {
  String baseUrl = dotenv.get('API_URL');

  BrandService();

  Future<FetchResponse> getBrands() async {
    final endpoint = '$baseUrl/brands';

    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return FetchResponse.fromJson(json.decode(response.body));
  }
}