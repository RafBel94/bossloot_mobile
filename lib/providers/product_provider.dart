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
  bool filterOnOffer = false;

  // Loading state
  bool isLoading = false;

  dynamic currentProductDetails;

  String? errorMessage;

  ProductProvider(this.productService);

  /// Fetches catalog products from the product service and updates the state.
  Future<void> fetchCatalogProducts() async {
    try {
      isLoading = true;
      notifyListeners();

      FetchResponse response = await productService.getCatalogProducts();
      if (response.success) {
        catalogProductList = response.data
            .where((item) => item['deleted'] == 0)
            .map((item) => CatalogProduct.fromJson(item))
            .toList();
        filteredCatalogList = List.from(catalogProductList);

        errorMessage = null;
      } else {
        errorMessage = response.message[0];
      }
    } catch (e) {
      errorMessage = 'Failed to load products: $e';
      print(errorMessage);
    } finally {
      isLoading = false;
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
        catalogProductList = response.data
            .where((item) => item['deleted'] == 0)
            .map((item) => CatalogProduct.fromJson(item))
            .toList();
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

      isLoading = true;
      notifyListeners();

      FetchResponse response = await productService.getFeaturedProducts();
      if (response.success) {
        featuredProductList = response.data
            .where((item) => item['deleted'] == 0)
            .map((item) => CatalogProduct.fromJson(item))
            .toList();
        filteredFeaturedList = List.from(featuredProductList);
        
        errorMessage = null;
      } else {
        errorMessage = response.message[0];
      }
    } catch (e) {
      errorMessage = 'Failed to load featured products: $e';
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  // ----- FILTERING -----

  // Method for adding or removing a category from the filters
  void toggleCategoryFilter(String category) {
    if (selectedCategories.contains(category)) {
      selectedCategories.remove(category);
    } else {
      selectedCategories.add(category);
    }
    notifyListeners();
  }
  
  // Method for adding or removing a brand from the filters
  void toggleBrandFilter(String brand) {
    if (selectedBrands.contains(brand)) {
      selectedBrands.remove(brand);
    } else {
      selectedBrands.add(brand);
    }
    notifyListeners();
  }
  
  // Method for setting the minimum price
  void setMinPrice(double? value) {
    minPrice = value;
    notifyListeners();
  }
  
  // Method for setting the maximum price
  void setMaxPrice(double? value) {
    maxPrice = value;
    notifyListeners();
  }
  
  // Method for setting the price order
  void setPriceOrder(String order) {
    priceOrder = order;
    notifyListeners();
  }

  // Method for toggling the on offer filter
  void toggleOnOfferFilter(bool value) {
    filterOnOffer = value;
    notifyListeners();
  }
  
  // Method for clearing all filters
  void clearFilters() {
    selectedCategories = [];
    selectedBrands = [];
    minPrice = null;
    maxPrice = null;
    priceOrder = '';
    filterOnOffer = false;
    
    // Reset the filtered lists to their original state
    filteredCatalogList = List.from(catalogProductList);
    filteredFeaturedList = List.from(featuredProductList);
    
    notifyListeners();
  }
  
  // Method for applying the filters
  Future<void> applyFilters() async {
    try {

      isLoading = true;
      notifyListeners();

      Map<String, dynamic> params = {};
      
      if (selectedCategories.isNotEmpty) {
        params['categories'] = selectedCategories;
      }
      
      if (selectedBrands.isNotEmpty) {
        params['brands'] = selectedBrands;
      }
      
      if (minPrice != null) {
        params['min_price'] = minPrice;
      }
      
      if (maxPrice != null) {
        params['max_price'] = maxPrice;
      }
      
      if (priceOrder.isNotEmpty) {
        params['price_order'] = priceOrder;
      }

      // Añadir el nuevo filtro de ofertas
      if (filterOnOffer) {
        params['on_offer'] = true;
      }
      
      FetchResponse response = await productService.getFilteredProducts(params);
      
      if (response.success) {
        // Update the filtered catalog list
        filteredCatalogList = response.data
            .where((item) => item['deleted'] == 0)
            .map((item) => CatalogProduct.fromJson(item))
            .toList();
        
        // Apply the same filters to the featured products
        if (params.isEmpty) {
          filteredFeaturedList = List.from(featuredProductList);
        } else {
          filteredFeaturedList = await _filterFeaturedProducts(params);
        }
        
        errorMessage = null;
      } else {
        errorMessage = response.message[0];
      }
    } catch (e) {
      errorMessage = 'Failed to apply filters: $e';
      print(errorMessage);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  
  // Method to filter featured products based on the same parameters
  Future<List<CatalogProduct>> _filterFeaturedProducts(Map<String, dynamic> params) async {
    try {
      params['featured'] = true;
      
      FetchResponse response = await productService.getFilteredProducts(params);
      
      if (response.success) {
        return response.data
        .where((item) => item['deleted'] == 0)
        .map((item) => CatalogProduct.fromJson(item))
        .toList();
      } else {
        return [];
      }
    } catch (e) {
      print('Error filtering featured products: $e');
      return [];
    }
  }
}