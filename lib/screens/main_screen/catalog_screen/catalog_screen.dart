import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/catalog_screen/catalog_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshCatalogProducts() async {
    await context.read<ProductProvider>().fetchCatalogProducts();

    if (mounted) {
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
      : RefreshIndicator(
          onRefresh: () => _refreshCatalogProducts(),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF270140), Color.fromARGB(255, 141, 24, 112)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  mainAxisExtent: 289
                ),
                itemCount: context.read<ProductProvider>().catalogProductList.length,
                itemBuilder: (context, index) {
                  final product = context.read<ProductProvider>().catalogProductList[index];
                  return CatalogProductCard(product: product);
                },
              ),
            ),
          ),
      );
  }
}
