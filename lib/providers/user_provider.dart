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

  // Logout user
  Future<void> logoutUser() async {
    currentUser = null;
    await tokenService.clearToken();
    notifyListeners();
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