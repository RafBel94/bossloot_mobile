// ignore_for_file: type_literal_in_constant_pattern, must_be_immutable, use_build_context_synchronously

import 'package:bossloot_mobile/domain/models/catalog_product.dart';
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
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/favorite_provider.dart';
import 'package:bossloot_mobile/providers/product_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/catalog_screen/catalog_product_card.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/case_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/cooler_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/cpu_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/display_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/gpu_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/keyboard_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/motherboard_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/mouse_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/psu_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/ram_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/storage_product_details.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details/valorations/product_valorations.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GeneralProductDetails extends StatefulWidget {
  final dynamic product;

  const GeneralProductDetails({super.key, required this.product});

  @override
  State<GeneralProductDetails> createState() => _GeneralProductDetailsState();
}

class _GeneralProductDetailsState extends State<GeneralProductDetails> {
  late UserProvider userProvider;
  late List<CatalogProduct> similarProducts;
  late ScrollController _scrollController;
  late GlobalKey _ratingsKey;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _ratingsKey = GlobalKey();
    userProvider = context.read<UserProvider>();

    // Get similar products
    similarProducts = context.read<ProductProvider>().catalogProductList
      .where((product) => product.category == widget.product.category && product.id != widget.product.id)
      .toList();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CoinExchangeProvider coinExchangeProvider = context.watch<CoinExchangeProvider>();

    String formatedDiscount = widget.product.discount % 1 == 0 
      ? widget.product.discount.toStringAsFixed(0) 
      : widget.product.discount.toString();
    String productPriceWithoutDiscount = getProductPriceWithoutDiscount(widget.product.price, coinExchangeProvider);
    String productPriceWithDiscount = getProductPrice(widget.product.price, widget.product.discount, coinExchangeProvider);

    // Check if the product is in the favorites list
    final favoriteProvider = context.watch<FavoriteProvider>();
    final bool isFavorite = favoriteProvider.favoriteList.any((favorite) => 
      favorite.productId == widget.product.id);

    // Get the total valorations
    int totalValorations = _countVerifiedValorations(widget.product.valorations);

    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 239, 239, 239),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
            
                  // ---- Product Image
                  Stack(
                    children: [
                      GestureDetector(
                        onTap: () => DialogUtil.showProductImageDialog(context, widget.product.image),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 350,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.product.image),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                          ),
                        ),
                      ),
            
            
                      // ---- Zoom In Button
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black54,
                            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                            padding: const EdgeInsets.all(10),
                          ),
                          icon: const Icon(Icons.zoom_in, color: Colors.white),
                          onPressed: () => DialogUtil.showProductImageDialog(context, widget.product.image),
                        ),
                      ),

                      // Out of stock label
                      if (widget.product.quantity == 0)
                        Positioned(
                          bottom: 15,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(93, 207, 27, 27),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(color: const Color.fromARGB(158, 135, 18, 18), width: 1),
                            ),
                            child: Text(
                                AppLocalizations.of(context)!.product_details_screen_no_stock_label,
                                style: const TextStyle(fontSize: 23, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),

                      // ---- Favorite Button
                      if (userProvider.currentUser != null)
                      Positioned(
                        bottom: 12,
                        left: 12,
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(204, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(100, 134, 134, 134),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: IconButton(
                            icon: Icon(
                              isFavorite ? Icons.favorite : Icons.favorite_border, 
                              color: Colors.red, 
                              size: 35
                            ),
                            onPressed: () {
                              DialogUtil.showFavoriteDialog(
                                context,
                                userProvider,
                                favoriteProvider,
                                widget.product,
                                isFavorite
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
              
                  SizedBox(height: 8),
                  
            
                  // ---- Product Name, Price and Valorations
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
            
                        // ---- Product Price
                        Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          child: widget.product.on_offer
                          ? Column(
                            mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(right: 10),
                                  alignment: Alignment.topRight,
                                  height: 15,
                                  child: Text(productPriceWithoutDiscount, style: const TextStyle(color: Color.fromARGB(255, 181, 181, 181), fontSize: 14.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, decoration: TextDecoration.lineThrough)),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(right: 15),
                                  alignment: Alignment.topRight,
                                  height: 25,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 5),
                                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                        alignment: Alignment.center,
                                        height: 20,
                                        width: 50,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(255, 189, 48, 48),
                                          borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: Text('-$formatedDiscount%', style: const TextStyle(color: Colors.white, fontSize: 10.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), textAlign: TextAlign.center),
                                      ),
                                      SizedBox(width: 5),
                                      Text(productPriceWithDiscount, style: const TextStyle(color: Color.fromARGB(255, 198, 79, 79), fontSize: 23.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))
                                    ]
                                  ),
                                ),
                                const SizedBox(height: 8,),
                              ]
                            )
                          : Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5),
                              child: Text(productPriceWithoutDiscount, style: const TextStyle(fontSize: 23.0, color: Color.fromARGB(255, 63, 146, 66), fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), textAlign: TextAlign.center,)
                            )
                          )
                        ),

                        const SizedBox(height: 5),

                        // ---- Product valorations
                        GestureDetector(
                          onTap:() {
                            Scrollable.ensureVisible(
                            _ratingsKey.currentContext!,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...buildStarRating(widget.product.avg_rating ?? 0),
                              const SizedBox(width: 6),
                              Text(widget.product.valorations.length > 0 ? '${(widget.product.avg_rating).toStringAsFixed(1)}' : '0', style: TextStyle(fontSize: 16, )),
                              Text('  |  ${AppLocalizations.of(context)!.product_details_screen_valoration_part1} $totalValorations ${AppLocalizations.of(context)!.product_details_screen_valoration_part2}', style: TextStyle(fontSize: 13,)),
                            ],
                          ),
                        ),
                  
                        const SizedBox(height: 15),
            
                        // ---- Product Name
                        Align(
                          alignment: Alignment.centerLeft,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              widget.product.name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),

                        // ---- Product Model
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.product_details_screen_model_label}: ',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(width: 5),

                              Text(
                                widget.product.model,
                                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 95, 95, 95)),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 5),

                        // ---- Product Brand
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Text(
                                '${AppLocalizations.of(context)!.product_details_screen_brand_label}: ',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(width: 5),

                              Text(
                                widget.product.brand,
                                style: TextStyle(fontSize: 16, color: const Color.fromARGB(255, 95, 95, 95)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
            
                  // ---- Product Description
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocalizations.of(context)!.product_details_screen_description_label, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                        SizedBox(height: 15),
                        Text(widget.product.description, style: TextStyle(fontSize: 16),),
                      ],
                    ),
                  ),
            
            
                  const SizedBox(height: 8),
            
            
                  // ---- Specifications
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                    ),
                    child: _specificProductDetails(widget.product),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // ---- Similar Products
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 239, 239, 239),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color.fromARGB(255, 227, 210, 251), width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(51, 115, 23, 168),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 45,
                    child: FittedBox(child: Text(AppLocalizations.of(context)!.product_details_screen_similar_products_label, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                  ),
                  SizedBox(
                    height: 290,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: similarProducts.length,
                      itemBuilder: (context, index) {
                        final product = similarProducts[index];
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color.fromARGB(137, 200, 200, 200), width: 1),
                          ),
                          child: CatalogProductCard(product: product)
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          
          
            const SizedBox(height: 10),

            // ---- Valorations
            Container(
              key: _ratingsKey,
              padding: const EdgeInsets.all(5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: const Color.fromARGB(220, 239, 239, 239),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ProductValorations(valorations: widget.product.valorations, productId: widget.product.id,),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  int _countVerifiedValorations(List<dynamic> valorations) {
      return valorations.where((v) => v.verified == true).length;
    }

  List<Widget> buildStarRating(double rating) {
    List<Widget> stars = [];
    int fullStars = rating.floor();
    bool hasHalfStar = (rating - fullStars) >= 0.5;

    for (int i = 0; i < fullStars; i++) {
      stars.add(const Icon(Icons.star, color: Color.fromARGB(255, 248, 230, 67), size: 20));
    }

    if (hasHalfStar) {
      stars.add(const Icon(Icons.star_half, color: Color.fromARGB(255, 248, 230, 67), size: 20));
    }

    while (stars.length < 5) {
      stars.add(const Icon(Icons.star_border, color: Color.fromARGB(255, 248, 230, 67), size: 20));
    }

    return stars;
  }

  Widget _specificProductDetails(dynamic product) {
    switch (product.runtimeType) {
      case RamProduct:
        return RamProductDetails(product: product as RamProduct);      
      case GpuProduct:
        return GpuProductDetails(product: product as GpuProduct);
      case CpuProduct:
        return CpuProductDetails(product: product as CpuProduct);
      case StorageProduct:
        return StorageProductDetails(product: product as StorageProduct);
      case PsuProduct:
        return PsuProductDetails(product: product as PsuProduct);
      case CoolerProduct:
        return CoolerProductDetails(product: product as CoolerProduct);
      case CaseProduct:
        return CaseProductDetails(product: product as CaseProduct);
      case MotherboardProduct:
        return MotherboardProductDetails(product: product as MotherboardProduct);
      case DisplayProduct:
        return DisplayProductDetails(product: product as DisplayProduct);
      case KeyboardProduct:
        return KeyboardProductDetails(product: product as KeyboardProduct);
      case MouseProduct:
        return MouseProductDetails(product: product as MouseProduct);
      default:
        return const Text('Product type not supported');
    }
  }

  String getProductPrice(double price, double discount, CoinExchangeProvider coinExchangeProvider) {
    double discountedPrice = (widget.product.price - (widget.product.price * (widget.product.discount / 100)));
    double exchangedPrice = coinExchangeProvider.convertPrice(discountedPrice);
    String formatedPrice = coinExchangeProvider.formatPrice(exchangedPrice);
    return formatedPrice;
  }

  String getProductPriceWithoutDiscount(double price, CoinExchangeProvider coinExchangeProvider) {
    double exchangedPrice = coinExchangeProvider.convertPrice(price);
    String formatedPrice = coinExchangeProvider.formatPrice(exchangedPrice);
    return formatedPrice;
  }
}