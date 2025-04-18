// ignore_for_file: avoid_print

import 'package:bossloot_mobile/domain/models/category.dart';
import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:bossloot_mobile/services/category_service.dart';
import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier{
  final CategoryService categoryService;
  List<Category> categories = [];
  String? errorMessage;
  String? fetchCategoriesErrorMessage;

  CategoryProvider(this.categoryService);

  Future<void> fetchCategories() async {
    try {
      FetchResponse response = await categoryService.getCategories();
      if (response.success) {
        categories = response.data.map((category) => Category.fromJson(category)).toList();
        fetchCategoriesErrorMessage = null;
      } else {
        fetchCategoriesErrorMessage = response.message[0];
      }
    } catch (e) {
      fetchCategoriesErrorMessage = 'Failed to load categories: $e';
      print(fetchCategoriesErrorMessage);
    } finally {
      notifyListeners();
    }
  }
}