// ignore_for_file: avoid_print

import 'package:bossloot_mobile/domain/models/brand.dart';
import 'package:bossloot_mobile/domain/models/fetch_response.dart';
import 'package:bossloot_mobile/services/brand_service.dart';
import 'package:flutter/material.dart';

class BrandProvider extends ChangeNotifier{
  final BrandService brandService;
  List<Brand> brands = [];
  String? errorMessage;
  String? fetchBrandsErrorMessage;

  BrandProvider({required this.brandService});

  Future<void> fetchBrands() async {
    try {
      FetchResponse response = await brandService.getBrands();
      if (response.success) {
        brands = response.data.map((brand) => Brand.fromJson(brand)).toList();
        fetchBrandsErrorMessage = null;
      } else {
        fetchBrandsErrorMessage = response.message[0];
      }
    } catch (e) {
      fetchBrandsErrorMessage = 'Failed to load brands: $e';
      print(fetchBrandsErrorMessage);
    } finally {
      notifyListeners();
    }
  }
}