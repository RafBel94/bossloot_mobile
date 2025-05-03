import 'dart:io';

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/services/token_service.dart';
import 'package:bossloot_mobile/services/user_service.dart';
import 'package:flutter/material.dart';
class UserProvider extends ChangeNotifier {
  final UserService userService;
  final TokenService tokenService;

  User? currentUser;
  String? errorMessage;
  String? temporalUserEmail;

  UserProvider(this.tokenService, this.userService);

  // Login user
  Future<void> loginUser(String email, String password) async {
    try {
      ApiResponse loginResponse = await userService.login(email, password);
      if (loginResponse.success) {
        currentUser = User.fromLoginJson(loginResponse.data);
        tokenService.saveToken(currentUser!.token ?? '');

        errorMessage = null;
      } else {
        errorMessage = loginResponse.data['error'];
      }
    } catch (error) {
      errorMessage = 'Error: ${error.toString()}';
    } finally {
      notifyListeners();
    }
  }

  // Register user
  Future<void> registerUser(String name, String email, String password, String repeatPassword) async {
    try {
      ApiResponse registerResponse = await userService.register(name, email, password, repeatPassword);
      
      if (registerResponse.success) {
        errorMessage = null;
      } else {
        errorMessage = registerResponse.data['error'] ?? 'Registration Failed';
      }
    } catch (error) {
      errorMessage = 'Error: ${error.toString()}';
    } finally {
      notifyListeners();
    }
  }

  // Update user
  Future<void> updateUser(int userId, String name, String mobilePhone, String address1, String address2, File? profilePicture) async {
    try {
      String? token = currentUser?.token;
      ApiResponse updateResponse = await userService.updateUser(token, userId, name, mobilePhone, address1, address2, profilePicture);
      
      if (updateResponse.success) {
        currentUser = User.fromJson(updateResponse.data);
        errorMessage = null;
      } else {
        errorMessage = updateResponse.data['error'] ?? 'Update Failed';
      }
    } catch (error) {
      errorMessage = 'Error: ${error.toString()}';
    } finally {
      notifyListeners();
    }
  }

  // Logout user
  Future<void> logoutUser() async {
    currentUser = null;
    await tokenService.clearToken();
    notifyListeners();
  }

  // Get user by ID
  Future<void> getUserById(int userId) async {
    try {
      ApiResponse userResponse = await userService.getUserById(userId);
      
      if (userResponse.success) {
        currentUser = User.fromJson(userResponse.data);
        errorMessage = null;
      } else {
        errorMessage = userResponse.data['error'] ?? 'Failed to fetch user data';
      }
    } catch (error) {
      errorMessage = 'Error: ${error.toString()}';
    } finally {
      notifyListeners();
    }
  }

  // Check email verification
  Future<void> checkEmailVerification(String email) async {
    try {
      errorMessage = null;

      ApiResponse checkEmailResponse = await userService.checkEmailVerification(email);

      if (checkEmailResponse.success) {
        errorMessage = null;
      } else {
        errorMessage = checkEmailResponse.data['error'] ?? 'Email verification failed';
        temporalUserEmail = email;
      }
    } catch (error) {
      errorMessage = 'Error: ${error.toString()}';
    } finally {
      notifyListeners();
    }
  }

  // Resend email verification
  Future<void> resendEmailVerification(String email) async {
    try {
      ApiResponse resendEmailResponse = await userService.resendEmailVerification(email);
      
      if (resendEmailResponse.success) {
        errorMessage = null;
      } else {
        errorMessage = resendEmailResponse.data['error'] ?? 'Resend email verification failed';
      }
    } catch (error) {
      errorMessage = 'Error: ${error.toString()}';
    } finally {
      notifyListeners();
    }
  }
}