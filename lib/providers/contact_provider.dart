import 'dart:io';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/services/contact_service.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  ContactMessageService contactMessageService;

  ContactProvider({required this.contactMessageService});

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  // Send a message
  Future<bool> sendContactForm(String name, String email, String subject, String message, File? image) async {
    try {
      ApiResponse updateResponse = await contactMessageService.sendContactMessage(name, email, subject, message, image);
      
      if (updateResponse.success) {
        _errorMessage = null;
        return true;
      } else {
        _errorMessage = updateResponse.data['error'] ?? 'Update Failed';
        return false;
      }
    } catch (error) {
      _errorMessage = 'Error: ${error.toString()}';
      return false;
    } finally {
      notifyListeners();
    }
  }
}