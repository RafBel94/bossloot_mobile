import 'dart:convert';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:http/http.dart' as http;

class UserService {
  final String baseUrl = 'http://10.0.2.2:8000/api';

  // Login endpoint
  Future<ApiResponse> login(String email, String password) async {
    final endpoint = '$baseUrl/login';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    return ApiResponse.fromJson(json.decode(response.body));
  }

  // Register endpoint
  Future<ApiResponse> register(String name, String email, String password, String repeatPassword) async {
    final endpoint = '$baseUrl/register';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'repeatPassword': repeatPassword,
      }),
    );
    print(response.body);
    return ApiResponse.fromJson(json.decode(response.body));
  }
}