import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/domain/models/user.dart';
import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/favorite_screen/favorite_product_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 63, 8, 73),
                border: Border(
                  left: BorderSide(
                    color: Color.fromARGB(255, 223, 64, 251),
                    width: 1.0,
                  ),
                  right: BorderSide(
                    color: Color.fromARGB(255, 223, 64, 251),
                    width: 1.0,
                  ),
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 223, 64, 251),
                    width: 1.0,
                  ),
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16.0),
                  bottomRight: Radius.circular(16.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 223, 64, 251),
                    blurRadius: 6.0,
                    spreadRadius: 0.5,
                  ),
                ],
              ),
              child: AppBar(
                centerTitle: true,
                title: Text(
                  AppLocalizations.of(context)!.favorites_screen_title,
                  style: GoogleFonts.pressStart2p(
                    color: Colors.amber,
                    shadows: const [
                      Shadow(
                        offset: Offset(2.5, 2.5),
                        color: Color.fromARGB(255, 202, 10, 199),
                      ),
                    ],
                  ),
                ),
                backgroundColor: Colors.transparent,
                elevation: 0,
                shadowColor: Colors.purpleAccent,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back, 
                    size: 30, 
                    color: Colors.amber, 
                    shadows: [
                      Shadow(
                        offset: Offset(2.5, 2.5),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 202, 10, 199),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.fromLTRB(16, 70, 16, 16),
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background-image-workshop-2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(204, 136, 25, 156),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color.fromARGB(150, 223, 64, 251),
                  width: 1,
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(156, 39, 176, 0.5),
                    blurRadius: 6,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 244, 244),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: _isLoading 
                  ? const Center(child: CircularProgressIndicator())
                  : favoriteProducts.isEmpty
                    ? Center(
                        child: Text(
                          'No favorites found',
                          style: GoogleFonts.pressStart2p(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        itemCount: favoriteProducts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 2.0,
                              horizontal: 4.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color.fromARGB(51, 178, 45, 201),
                                    blurRadius: 5,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 1),
                                  ),
                                ],
                              ),
                              child: FavoriteProductCard(
                                product: favoriteProducts[index],
                                onRemoveFavorite: () {
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
            ),
          )
        ),
      )
    );
  }
}