import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  final int productId;
  final VoidCallback onBackPressed;

  const ProductDetailsScreen({super.key, required this.productId, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
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
        child: Center(
          child: ElevatedButton(onPressed: onBackPressed, child: Text('Volver')),
        ),
      ),
    );
  }
}