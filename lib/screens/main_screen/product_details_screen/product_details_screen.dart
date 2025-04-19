// ignore_for_file: type_literal_in_constant_pattern

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
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  final VoidCallback onBackPressed;

  const ProductDetailsScreen({super.key, required this.productId, required this.onBackPressed});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  bool _isLoading = true;
  late ProductProvider productProvider;

  @override
  void initState() {
    super.initState();
    productProvider = context.read<ProductProvider>();
    _fetchProductDetails(widget.productId);
  }

  _fetchProductDetails(int productId) async {
    await productProvider.fetchProductDetails(productId);
    if(mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
    ? Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF270140), Color.fromARGB(255, 141, 24, 112)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
          ),
          child: const CircularProgressIndicator(color: Colors.white),
        )
      )
    : Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF270140), Color.fromARGB(255, 141, 24, 112)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _productDetails(productProvider.currentProductDetails),

              SizedBox(height: 20),

              Center(
                child: ElevatedButton(onPressed: widget.onBackPressed, child: Text('Volver')),
              ),
            ],
          ),
        ),
      );
  }

  Widget _productDetails(dynamic product) {
    switch (product.runtimeType) {
      case RamProduct:
        return Text('THIS IS A RAM PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);      
      case GpuProduct:
        return Text('THIS IS A GPU PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case CpuProduct:
        return Text('THIS IS A CPU PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case StorageProduct:
        return Text('THIS IS A STORAGE PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case PsuProduct:
        return Text('THIS IS A PSU PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case CoolerProduct:
        return Text('THIS IS A COOLER PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case CaseProduct:
        return Text('THIS IS A CASE PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case MotherboardProduct:
        return Text('THIS IS A MOTHERBOARD PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case DisplayProduct:
        return Text('THIS IS A DISPLAY PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case KeyboardProduct:
        return Text('THIS IS A KEYBOARD PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      case MouseProduct:
        return Text('THIS IS A MOUSE PRODUCT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),);
      default:
        return const Text('Tipo de producto no soportado');
    }
  }
}