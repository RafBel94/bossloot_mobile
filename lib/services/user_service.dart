// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserService {
  String baseUrl = dotenv.get('API_URL');

  // Login endpoint
  Future<ApiResponse> login(String email, String password) async {
    final endpoint = '$baseUrl/loginUser';
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
    
    try {
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
      
      return ApiResponse.fromJson(json.decode(response.body));
    } catch (e) {
      print('Error durante el registro: $e');
      return ApiResponse(
        success: false,
        message: 'Error de conexión: ${e.toString()}',
        data: null,
      );
    }
  }

  // Update user endpoint
  Future<ApiResponse> updateUser(String? token, int userId, String name, String mobilePhone, String address1, String address2, File? profilePicture) async {
    final endpoint = '$baseUrl/users/update-profile/$userId';

    var request = http.MultipartRequest('POST', Uri.parse(endpoint));

    // Add fields to the request
    request.fields.addAll({
      'name': name,
      'mobile_phone': mobilePhone,
      'address_1': address1,
      'address_2': address2,
    });

    // Add file to the request if it exists
    if (profilePicture != null) {
      final extension = profilePicture.path.split('.').last.toLowerCase();
      
      request.files.add(
        await http.MultipartFile.fromPath(
          'profile_picture', 
          profilePicture.path,
          filename: 'profile_$userId.$extension',
        ),
      );
    }

    // Add headers to the request
    request.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      final responseData = await response.stream.bytesToString();
      return ApiResponse.fromJson(json.decode(responseData));
    } else {
      final errorData = await response.stream.bytesToString();
      throw Exception('Error: ${response.statusCode} - $errorData');
    }
  }

  // Get user by ID endpoint
  Future<ApiResponse> getUserById(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');
    final endpoint = '$baseUrl/users/$userId';
    try {
    final response = await http.get(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
      print('User id: $userId');
      print('URI: $endpoint');
      print ('Response body: ${response.body}');
      return ApiResponse.fromJson(json.decode(response.body));
    } catch (error) {
      print('Error fetching user: $error');
      return ApiResponse(success: false, message: 'Error fetching user', data: null);
    }
  }

  // Check email verification endpoint
  Future<ApiResponse> checkEmailVerification(String email) async {
    final endpoint = '$baseUrl/check-verification';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    return ApiResponse.fromJson(json.decode(response.body));
  }

  // Resend email verification endpoint
  Future<ApiResponse> resendEmailVerification(String email) async {
    final endpoint = '$baseUrl/resend-verification';
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
      }),
    );
    return ApiResponse.fromJson(json.decode(response.body));
  }
}