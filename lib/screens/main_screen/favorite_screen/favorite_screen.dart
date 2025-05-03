import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  final User? user;

  const FavoriteScreen({super.key, required this.user});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  List<CatalogProduct> _getFavoriteProducts() {
    final favoriteProvider = context.watch<FavoriteProvider>();
    final productProvider = context.read<ProductProvider>();
    final List<CatalogProduct> favoriteProducts = [];
    
    for (var product in productProvider.catalogProductList) {
      if (favoriteProvider.favoriteList.any((favorite) => favorite.productId == product.id)) {
        favoriteProducts.add(product);
      }
    }
    
    return favoriteProducts;
  }

  @override
  Widget build(BuildContext context) {
    final List<CatalogProduct> favoriteProducts = _getFavoriteProducts();
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background-image-workshop-2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color.fromARGB(150, 223, 64, 251),
                width: 1,
              ),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(156, 39, 176, 0.5),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
            margin: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.all(5.0),
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : favoriteProducts.isEmpty
                ? const Center(
                    child: Text(
                      'No favorites found',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: favoriteProducts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text(favoriteProducts[index].name),
                          subtitle: Text('Price: \$${favoriteProducts[index].price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              favoriteProvider.removeFavorite(
                                widget.user!.id.toString(), 
                                favoriteProducts[index].id.toString()
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
          ),
        )
      ),
    );
  }
}