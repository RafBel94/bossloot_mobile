import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/spotlight_screen/spotlight_product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SpotlightScreen extends StatefulWidget {
  const SpotlightScreen({super.key});

  @override
  State<SpotlightScreen> createState() => _SpotlightScreenState();
}

class _SpotlightScreenState extends State<SpotlightScreen> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refreshSpotlightProducts() async {
    _isLoading = true;
    await context.read<ProductProvider>().fetchFeaturedProducts();

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
        onRefresh: () => _refreshSpotlightProducts(),
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
                itemCount: context.watch<ProductProvider>().featuredProductList.length,
                itemBuilder: (context, index) {
                  final product = context.watch<ProductProvider>().featuredProductList[index];
                  return SpotlightProductCard(product: product);
                },
              ),
            ),
          ),
      );
  }
}
