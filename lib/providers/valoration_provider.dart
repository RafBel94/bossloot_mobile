import 'dart:io';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/services/valoration_service.dart';
import 'package:flutter/material.dart';

class ValorationProvider extends ChangeNotifier{
  ValorationService valorationService;

  ValorationProvider({required this.valorationService});

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // Send a message
  Future<bool> sendValorationForm(int rating, int productId, String comment, File? image) async {
    try {
      ApiResponse updateResponse = await valorationService.sendValorationForm(rating, productId, comment, image);
      
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