// ignore_for_file: avoid_print

import 'package:bossloot_mobile/domain/models/api_response.dart';
import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:bossloot_mobile/domain/models/products/case_product.dart';
import 'package:bossloot_mobile/domain/models/products/cooler_product.dart';
import 'package:bossloot_mobile/domain/models/products/cpu_product.dart';
import 'package:bossloot_mobile/domain/models/products/display_product.dart';
import 'package:bossloot_mobile/domain/models/products/gpu_product.dart';
import 'package:bossloot_mobile/domain/models/products/keyboard_product.dart';
import 'package:bossloot_mobile/domain/models/products/motherboard_product.dart';
import 'package:bossloot_mobile/domain/models/products/mouse_product.dart';
import 'package:bossloot_mobile/domain/models/products/psu_product.dart';
import 'package:bossloot_mobile/domain/models/products/ram_product.dart';
import 'package:bossloot_mobile/domain/models/products/storage_product.dart';
import 'package:bossloot_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
  ProductService productService;
  List<CatalogProduct> catalogProductList = [];
  List<CatalogProduct> featuredProductList = [];

  // Filtered products lists
  List<CatalogProduct> filteredCatalogList = [];
  List<CatalogProduct> filteredFeaturedList = [];
  
  // Filter options
  List<String> selectedCategories = [];
  List<String> selectedBrands = [];
  double? minPrice;
  double? maxPrice;
  String priceOrder = ''; // 'asc', 'desc' or empty string for no order

  dynamic currentProductDetails;

  String? errorMessage;

  ProductProvider(this.productService);

  /// Fetches catalog products from the product service and updates the state.
  Future<void> fetchCatalogProducts() async {
    try {
      FetchResponse response = await productService.getCatalogProducts();
      if (response.success) {
        catalogProductList = response.data.map((item) => CatalogProduct.fromJson(item)).toList();
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


  /// Fetches product details by ID from the product service.
  Future<void> fetchProductDetails(int id) async {
    try {
      ApiResponse response = await productService.getProductDetails(id);
      if (response.success) {
        _determineProductTypeAndReturn(response.data);
      } else {
        errorMessage = response.message;
        print(errorMessage);
      }
    } catch (e) {
      errorMessage = '[fetchProductDetails] Failed to load product details: $e';
      print(errorMessage);
    }
  }

  // Fetch products by category
  Future<void> fetchProductsByCategory(String category) async {
    try {
      FetchResponse response = await productService.getProductsByCategory(category);
      if (response.success) {
        catalogProductList = response.data.map((item) => CatalogProduct.fromJson(item)).toList();
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

  /// Determines the product type and returns the appropriate product object.
  void _determineProductTypeAndReturn(Map<String, dynamic> productData) {
    String category = productData['category'];

    switch (category) {
      case 'ram':
        currentProductDetails = RamProduct.fromJson(productData);
      case 'gpu':
        currentProductDetails = GpuProduct.fromJson(productData);
      case 'cpu':
        currentProductDetails = CpuProduct.fromJson(productData);
      case 'storage':
        currentProductDetails = StorageProduct.fromJson(productData);
      case 'psu':
        currentProductDetails = PsuProduct.fromJson(productData);
      case 'cooler':
        currentProductDetails = CoolerProduct.fromJson(productData);
      case 'case':
        currentProductDetails = CaseProduct.fromJson(productData);
      case 'motherboard':
        currentProductDetails = MotherboardProduct.fromJson(productData);
      case 'display':
        currentProductDetails = DisplayProduct.fromJson(productData);
      case 'keyboard':
        currentProductDetails = KeyboardProduct.fromJson(productData);
      case 'mouse':
        currentProductDetails = MouseProduct.fromJson(productData);
      default:
        currentProductDetails = CatalogProduct.fromJson(productData);
    }
  }
  

  // ----- FEATURED PRODUCTS -----
  /// Fetches featured and latest added products from the product service and updates the state.
  Future<void> fetchFeaturedProducts() async {
    try {
      FetchResponse response = await productService.getFeaturedProducts();
      if (response.success) {
        featuredProductList = response.data.map((item) => CatalogProduct.fromJson(item)).toList();
        errorMessage = null;
      } else {
        errorMessage = response.message[0];
      }
    } catch (e) {
      errorMessage = 'Failed to load featured products: $e';
      print(errorMessage);
    } finally {
      notifyListeners();
    }
  }
}