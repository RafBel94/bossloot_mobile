import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/loading_screen/data_loading_screen.dart';
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
      ? DataLoadingScreen()
      : RefreshIndicator(
        onRefresh: () => _refreshSpotlightProducts(),
        child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/ladder-background.png'),
                fit: BoxFit.fill,
                repeat: ImageRepeat.repeat
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 9.0,
                  mainAxisSpacing: 9.0,
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
