// ignore_for_file: avoid_print

import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:bossloot_mobile/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier{
  ProductService productService;
  List<CatalogProduct> catalogProductList = [];

  String? errorMessage;

  ProductProvider(this.productService);

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
}