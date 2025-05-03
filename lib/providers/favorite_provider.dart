// ignore_for_file: avoid_print

import 'package:bossloot_mobile/domain/models/favorite.dart';
import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:bossloot_mobile/services/favorite_service.dart';
import 'package:bossloot_mobile/services/token_service.dart';
import 'package:flutter/material.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteService favoriteService;
  final TokenService tokenService;

  List<Favorite> favoriteList = [];

  String? errorMessage;

  FavoriteProvider({required this.favoriteService, required this.tokenService});

  // Fetch all favorites for a user
  Future<void> fetchFavorites(String userId) async {
    try {
      // Get the token from the TokenService
      String? token = await tokenService.getToken();

      FetchResponse response = await favoriteService.getFavorites(userId, token!);
      if (response.success) {
        favoriteList = response.data.map((item) => Favorite.fromJson(item)).toList();
        errorMessage = null;
      } else {
        errorMessage = response.message[0];
      }
    } catch (e) {
      errorMessage = 'Failed to load products: $e';
      print(errorMessage);
    } finally {
      notifyListeners();
    }
  }

  // Add a favorite
  Future<void> addFavorite(String userId, String productId) async {
    try {
      // Get the token from the TokenService
      String? token = await tokenService.getToken();
      
      FetchResponse response = await favoriteService.addFavorite(userId, productId, token!);
      if (response.success) {
        print('Favorite added successfully!');
        print('favoriteList: $favoriteList');
        errorMessage = null;
      } else {
        errorMessage = response.message[0];
      }
    } catch (e) {
      errorMessage = 'Failed to add favorite: $e';
      print(errorMessage);
    } finally {
      notifyListeners();
    }
  }

  // Remove a favorite
  Future<void> removeFavorite(String userId, String productId) async {
    try {
      // Get the token from the TokenService
      String? token = await tokenService.getToken();
      
      FetchResponse response = await favoriteService.removeFavorite(userId, productId, token!);
      if (response.success) {
        favoriteList.removeWhere((favorite) => favorite.productId == int.parse(productId));
        errorMessage = null;
      } else {
        errorMessage = response.message[0];
      }
    } catch (e) {
      errorMessage = 'Failed to remove favorite: $e';
      print(errorMessage);
    } finally {
      notifyListeners();
    }
  }
}