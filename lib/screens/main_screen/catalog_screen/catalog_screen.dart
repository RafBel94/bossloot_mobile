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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final isLoading = productProvider.isLoading;
    final products = productProvider.filteredCatalogList;
    
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/loading-image-2.png'),
          fit: BoxFit.fill,
          repeat: ImageRepeat.repeat
        ),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),
            child: isLoading && products.isNotEmpty
                ? Container()
                : GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 9.0,
                      mainAxisSpacing: 9.0,
                      mainAxisExtent: 289
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return CatalogProductCard(product: product);
                    },
                  ),
          ),
          
          // Loading overlay
          if (isLoading)
            Container(
              color: const Color.fromRGBO(0, 0, 0, 0.3),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.deepPurple),
                  strokeWidth: 5.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}