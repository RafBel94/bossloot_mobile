import 'package:bossloot_mobile/domain/models/catalog_product.dart';
import 'package:bossloot_mobile/providers/coin_exchange_provider.dart';
import 'package:bossloot_mobile/screens/main_screen/product_details_screen/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoriteProductCard extends StatelessWidget {
  final CatalogProduct product;
  final VoidCallback onRemoveFavorite;

  const FavoriteProductCard({
    super.key,
    required this.product,
    required this.onRemoveFavorite,
  });

  @override
  Widget build(BuildContext context) {
    final CoinExchangeProvider coinExchangeProvider = context.watch<CoinExchangeProvider>();
    String productPriceWithDiscount = getProductPrice(product.price, product.discount, coinExchangeProvider);


    return GestureDetector(
      onTap: () async {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            productId: product.id,
            onBackPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
        elevation: 2.0,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
          side: const BorderSide(color: Color.fromARGB(255, 233, 233, 233), width: 1),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(6.0),
            child: Image.network(
              product.image,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 70,
                  height: 70,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                );
              },
            ),
          ),
          title: FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              product.name.split(' ').take(4).join(' '),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      productPriceWithDiscount,
                      style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 82, 3, 89)),
                    ),
                  ),
                ),

                const SizedBox(width: 5),

                if (product.onOffer)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 1.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 168, 43, 43),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      '-${product.discount} %',
                      style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                  ),
              ],
            )
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, size: 30 , color: Color.fromARGB(255, 255, 18, 176), shadows: [Shadow(color: Color.fromARGB(255, 70, 16, 79), offset: Offset(2, 2), blurRadius: 1)],),
            onPressed: onRemoveFavorite,
          ),
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