import 'dart:convert';
import 'dart:io';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:http/http.dart' as http;

class ContactMessageService {
  // final String baseUrl = 'https://bossloot-kbsiw.ondigitalocean.app/api';
  final String baseUrl = 'http://192.168.1.49:8000/api';

  ContactMessageService();

  // Send contact message endpoint
  Future<ApiResponse> sendContactMessage(String name, String email, String subject, String message, File? image) async {
    final endpoint = '$baseUrl/contact';

    var request = http.MultipartRequest('POST', Uri.parse(endpoint));

    // Add fields to the request
    request.fields.addAll({'name': name, 'email': email, 'subject': subject, 'message': message});

    // Add file to the request if it exists
    if (image != null) {
      final extension = image.path.split('.').last.toLowerCase();
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      request.files.add(await http.MultipartFile.fromPath('image', image.path, filename: 'attachment_$timestamp.$extension'));
    }

    // Add headers to the request
    var headers = {'Accept': 'application/json'};

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
