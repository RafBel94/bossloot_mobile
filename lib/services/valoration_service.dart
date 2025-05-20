import 'dart:convert';
import 'dart:io';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ValorationService {
  String baseUrl = dotenv.get('API_URL');

  ValorationService();

  // Send contact message endpoint
  Future<ApiResponse> sendValorationForm(int rating, int productId, String comment, File? image) async {
    final endpoint = '$baseUrl/valorations';
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('user_token');

    var request = http.MultipartRequest('POST', Uri.parse(endpoint));

    // Add fields to the request
    request.fields.addAll({'rating': rating.toString(), 'product_id': productId.toString(), 'comment': comment});

    // Add file to the request if it exists
    if (image != null) {
      final extension = image.path.split('.').last.toLowerCase();
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      request.files.add(await http.MultipartFile.fromPath('image', image.path, filename: 'attachment_$timestamp.$extension'));
    }

    // Add headers to the request
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    
    request.headers.addAll(headers);

    try {
      var response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = await response.stream.bytesToString();
        return ApiResponse.fromJson(json.decode(responseData));
      } else {
        final errorData = await response.stream.bytesToString();
        throw Exception('Error: ${response.statusCode} - $errorData');
      }
    } catch (e) {
      throw Exception('Error al enviar el mensaje: ${e.toString()}');
    }
  }
}
