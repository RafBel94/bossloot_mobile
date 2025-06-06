import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/providers/cart/cart_provider.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/providers/user_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details_screen.dart';
import 'package:bossloot_mobile/utils/dialog_util.dart';
import 'package:bossloot_mobile/widgets/shared/product_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CatalogProductCard extends StatelessWidget {
  const CatalogProductCard({
    super.key,
    required this.product,
  });

  final CatalogProduct product;

  @override
  Widget build(BuildContext context) {

    UserProvider userProvider = context.read<UserProvider>();
    CartProvider cartProvider = context.read<CartProvider>();
    CoinExchangeProvider coinExchangeProvider = context.read<CoinExchangeProvider>();

    String formatedDiscount = product.discount % 1 == 0 
      ? product.discount.toStringAsFixed(0) 
      : product.discount.toString();
    String productPriceWithoutDiscount = getProductPriceWithoutDiscount(product.price, coinExchangeProvider);
    String productPriceWithDiscount = getProductPrice(product.price, product.discount, coinExchangeProvider);

    return GestureDetector(
      onLongPress: () {
        DialogUtil.showProductImageDialog(context, product.image);
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailsScreen(productId: product.id, onBackPressed: () {
          Navigator.pop(context);
        },)));
      },
      child: Container(
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.0),
        boxShadow: [
          BoxShadow(
          color: const Color.fromRGBO(0, 0, 0, 0.1),
          blurRadius: 4.0,
          offset: Offset(0, 2),
          ),
        ],
        ),
        child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
      
          Material(
            elevation: 4,
            color: Colors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5.0),
              topRight: Radius.circular(5.0),
            ),
            child: SizedBox(
              height: 170,
              child: Stack(
                children: [
                    
                  // PRODUCT IMAGE
                  ProductImage(image: product.image,),

                  if (product.onOffer)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      alignment: Alignment.center,
                      height: 28,
                      width: 55,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 168, 43, 43),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text('-$formatedDiscount%', style: const TextStyle(color: Colors.white, fontSize: 12.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis), textAlign: TextAlign.center),
                    ),
                  ),
                ],
              ),
            ),
          ),
      
          SizedBox(height: 10,),
      
          // PRODUCT NAME
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(5.0),
              child: Container(
                padding: const EdgeInsets.all(8.0),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Color.fromARGB(255, 239, 239, 239),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ),
              ),
            ),
          ),
      
          const SizedBox(height: 7,),
      
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: [
                // PRODUCT PRICE
                Expanded(
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(5.0),
                    child: Container(
                      padding: product.onOffer ? const EdgeInsets.only(top: 3.0, left: 3, right: 3) : const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Color.fromARGB(255, 239, 239, 239),
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: product.onOffer
                      ? Column(
                        mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15.0),
                              alignment: Alignment.topLeft,
                              height: 15,
                              child: FittedBox(fit: BoxFit.scaleDown, child: Text(productPriceWithoutDiscount, style: const TextStyle(color: Color.fromARGB(255, 181, 181, 181), fontSize: 16.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis, decoration: TextDecoration.lineThrough))),
                            ),
                            Container(
                              alignment: Alignment.topCenter,
                              height: 25,
                              child: FittedBox(fit: BoxFit.scaleDown, child: Text(productPriceWithDiscount, style: const TextStyle(color: Color.fromARGB(255, 198, 79, 79), fontSize: 18.0, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis))),
                            ),
                            SizedBox(height: 8,),
                          ]
                        )
                      : FittedBox(fit: BoxFit.scaleDown, child: Text(productPriceWithoutDiscount, style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,))
                    ),
                  ),
                ),
            
                // ADD TO CART BUTTON
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
                      backgroundColor: const Color.fromARGB(255, 214, 165, 205),
                      side: BorderSide(
                        color: const Color.fromARGB(255, 192, 144, 182),
                        width: 2.0,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 8.0),
                      elevation: 4
                    ),
                    child: const Icon(Icons.add_shopping_cart, color: Color.fromARGB(255, 255, 255, 255), size: 30,),
                    onPressed: () {
                      if (userProvider.currentUser == null) {
                        DialogUtil.showLoginRequiredDialog(context);
                      } else if (product.quantity == 0) {
                        DialogUtil.showProductOutOfStockDialog(context);
                      } else {
                        DialogUtil.showAddToCartDialog(context, cartProvider, product.id);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }

  String getProductPrice(double price, double discount, CoinExchangeProvider coinExchangeProvider) {
    double discountedPrice = (product.price - (product.price * (product.discount / 100)));
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

